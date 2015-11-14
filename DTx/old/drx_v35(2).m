function drx_v35()
% Designated Receiver Parameter Structure
prm = init_v35();
% db: Data Blank (CONSTANT): To put on Tx Buffer while in a Rx major state
db  = complex(zeros(1408,1));
% c8f: Count of 802.11b Frames Recovered
c8f = uint16(0);
% cev: Count of Events: Counts #events in the Event Log, evl
cev = uint16(0);
% cni: Count #No-Action Iterations: Counts #iter in which no DATA Rx/ACK Tx
cni = uint16(0);
% cti: Count Total #Iterations: Counts #iterations of main WHILE loop
cti = uint16(0);
% df:  This USRP Data frame: The most-recently-received frame from USRP Rx Buffer
df  = complex(zeros(1408,1)); 
% dfl: Data Flagged: uint16 to accompany data, set when status flag is true
dfl = uint16(0); %#ok<NASGU>
% d2s: Data To Send: To put on Transmit Buffer while in a Tx Major State
d2s = complex(zeros(1408,1)); %#ok<NASGU>
% evl: Event Log: Records the cit and flg values when any flag is true
%      A matrix of size CEVx3, where each row represents a separate event
%      Col 1: Timestamp; Col 2: Flags Event Type; Col 3: Associated Data
evl = uint16(zeros(65535,3,'uint16'));
% fe: Flag End: Signals end-of-transmission; timeout or full image recovery
fe  = logical(false(1));
% ff: Flag Frame Check Sequence (FCS) Failure: if MPDU data fails CRC check
ff  = logical(false(1)); %#ok<NASGU>
% flg: Status Flags: a 4x1 logical aray, carrying the following flags: 
% (1): fdf: Flag Detected Preamble: Set true if PLCP Preamble (SYNC) found
% (2): fph: Flag PLCP Header Found: Init false, set true if PHY Header rx'd
% (3): fec: Flag Error CRC: Init false, set true if PHY Header CRC in error
% (4): fmh: Flag MAC Header Found: Init false, set true if MAC Header rx'd
% (5): fpf: Flag All Payload Found: Init false, set true if all payload rxd
flg = logical(false(1,5)); %#ok<NASGU>
% ft: Terminal Flag to release System objects
ft  = logical(false(1));
% hfd: Handle to MAC FCS Detector
hfd = comm.CRCDetector('ChecksumsPerFrame',1,'FinalXOR',1, ...
    'InitialConditions',1,'Polynomial', ...
    [31,30,26,25,24,18,15,14,12,11,10,8,6,5,4,3,1,0]); 
% it:  Iterator (Generic), used to iterate through FOR loop of <=65535 elem
it  = uint16(0); %#ok<NASGU>
% neb: #Expected MPDU Bits: Recovered from PLCP Header (LENGTH, bits 33-48, def. 16192)
neb = uint16(0);
% nib: Total #Recovered Image Bits: Length of Data in rib, range 0-103,864
nib = uint64(0);
% nmb: Total #Recovered MPDU Bits: Length of Data in rfs, range 0-16,192
nmb = uint16(0);
% npb: Total #Recovered Payload Bits: nmb-len(hdr)-len(FCS), range 0-16,096
npb = uint16(0); %#ok<NASGU>
% nsq: Number in Sequence: Recovered from MAC Header Info (bits 49-64)
nsq = uint16(0);
% nrb: Number of Recovered USRP MAC Bits: Length of Data in rbs, range 0-64
nrb = uint16(0); %#ok<NASGU>
% nti: Number of Timeout Iterations: #no-action iterations before exiting
nti = uint16(2000);
% rbs: Recovered Binary Sequence: Recovered from MPDU (MAC Data) (64 bits)
rbs = zeros(64,1); %#ok<PREALL>
% rms: Recovered MPDU Sequence for one 802.11b Frame: Combined from rbs's (16,192 bits)
rms = zeros(16192,1);
% ri1: Recovered Image Height, or Number of Rows (expected 110)
ri1 = uint64(110); %prm.ImageExpectedHeight
% ri2: Recovered Image Width, or Number of Columns (expected 118)
ri2 = uint64(118); %prm.ImageExpectedWidth
% ri3: Recovered Image 3rd Dimension Size (expected 1 for grayscale image)
ri3 = uint64(1);   %prm.ImageExpectedDepth
% ril: Recovered Image Length: the Total Number of Bits Expected (103,864 bits)
ril = uint64((ri1*ri2*ri3*uint64(8))+uint64(24));
% rib: Recovered Full Binary Image Sequence: Concatenated from rfs's,  
%      802.11b Frame Payloads, contains entire image data (103,864 bits)
rib = zeros(ril,1);
% rid: Recovered Image Data (expected size is 110x118x1)
rid = uint8(zeros(ri1,ri2,ri3)); %#ok<NASGU>
% sr:  State for Designated Receiver (DRx): 3 Digits, 1st Digit is 2 for DRx
% 2nd Digit is 1 for Receive Data, 2 for Transmit ACK, or 3 for Wait DIFS
sr  = uint8(211); %prm.DRxStateStart
% sm: DRx Major State: Most Significant 2 Digits of Full DRx State
sm  = uint8(0); %#ok<NASGU>
% vm: Verbose Mode: Displays additional text describing DRx actions
vm  = logical(true(1));
while ~fe
    sm = sr/uint8(10);
    if (sm==uint8(21)) %prm.DRxStateRxDATA
        df = transceive202_mex(db,ft);
        [dfl,flg,nrb,rbs,sr] = drx_1ReceiveDATA(df,ft,prm,sr);
        if (flg(1) || flg(2) || flg(3) || flg(4) || flg(5))
            cni = uint16(0); % Reset no-action counter
            % Record any flags in event log
            cev = cev+uint16(1);
            evl(cev,1) = cti;
            evl(cev,2) = uint16(bi2de(flg));
            evl(cev,3) = dfl;
            if flg(2) %PLCP header info found
                % Store expected #MPDU bits (LENGTH) for this 802.11 frame
                neb = dfl;
            elseif flg(4) % MAC header info found
                % Store which 802.11 frame# in Sequence (nsq) is being rx'd
                nsq = dfl;
            end
        end
        if (nrb > uint16(0))
            % Store this recovered binary sequence in rfs vector
            rms((nmb+uint16(1)):(nmb+nrb)) = rbs(uint16(1):nrb);
            % Increase total MPDU bit count by this # of recovered USRP bits
            nmb = (nmb + nrb);
            if (flg(5) || nmb>=neb) % Full payload found
                % Check FCS in MAC Header
                [~,ff] = step(hfd, rfs);
                if (ff)
                    % When MAC FCS check fails, record flag in event log
                    cev = cev+uint16(1);
                    evl(cev,1) = cti;
                    evl(cev,2) = uint16(32); % 6th evl bit for FCS fail
                    evl(cev,3) = uint16(nsq);
                end
                % Append this 802.11b frame's Payload Bits to Recovered
                % Image Bitstream vector
                npb = (nmb-uint16(96));
                rib((nib+uint64(1)):(nib+uint64(npb))) = ...
                    rfs(uint16(65):(nmb-uint16(32)));
                % On first fully rx'd MSDU (payload), get image dimensions
                if (c8f<uint16(1)) && (nib<uint64(1)) && (npb>uint16(23))
                    [ri1,ri2,ri3,ril] = getImageDims(rib(1:24));
                end
                % Update count of the total number of image bits recovered
                nib = (nib + uint64(npb));
                % Increment total number of 802.11b frames found by 1
                c8f = (c8f + uint16(1)); 
                % Change DRx State to Transmit ACK
                sr  = uint8(220); %prm.DRxStateTxACKSendACK;
                % Reset Count Variables
                nmb = uint16(0);       
            end % IF FLG(5): FPF
        end % IF NRB>0
    elseif (sm==uint8(21)) %prm.DRxStateTxACK
        [d2s,fat,sr] = drx_2TransmitACK(ft,nsq,sr);
        transceive202_mex(d2s,ft);
        if (fat) 
            % On ACK fully tx'd, reset no-action counter and flag
            cni = uint16(0);
            if (nib >= ril)
                % If ACK Tx'd & #image bits>=expected image len, set exit flag
                fe = logical(true(1));
                % Change DRx State to Terminal State: no more Tx/Rx performed
                sr = uint8(240); %prm.DRxStateEOT
                % Record an Event to denote image is fully received
                cev = cev+uint16(1);
                evl(cev,1) = cti;
                evl(cev,2) = uint16(64); % 7th bit denotes full image rx'd
                evl(cev,3) = uint16(c8f);
            end
        end
    elseif (sm==prm.DRxStateDIFS)
        sr = drx_3WaitDIFS(sr);
    end % END IF SM==#
    cni = (cni+uint16(1));
    cti = (cti+uint16(1));
    if (cni >= nti)
        % Record an Event to denote timeout from no action in nti frames
        cev = cev+uint16(1);
        evl(cev,1) = cti;
        evl(cev,2) = uint16(128); % 8th bit denotes timeout
        evl(cev,3) = uint16(cni);
        % Set exit flag
        fe = logical(true(1));
        % Change DRx State to Terminal State: no more Tx/Rx performed
        sr = uint8(240); %prm.DRxStateEOT
    end
end % End While ~EOTFLAG
% Clear persistent data within all helper functions
ft = logical(true(1));
transceive202_mex(db,ft);
drx_1ReceiveDATA(df,ft,prm,sdt);
drx_2TransmitACK(ft,nsq,sr);
if (vm && (cev>uint16(0)))
    % For each Event in Log, display information about the event
    for it = (uint16(1):cev)
        fprintf(1,'At iteration #%d, ',evl(it,1));
        if (evl(it,2)==uint16(1))
            fprintf(1,'detected preamble with synch delay %d.\n',evl(it,3));
        elseif (evl(it,2)==uint16(2)) || (evl(it,2)==uint16(6))
            fprintf(1,'found PLCP header with LENGTH %d.\n',evl(it,3));
            if (evl(it,2)==uint16(6))
                fprintf(1,'At iteration #%d, CRC ERROR.\n',evl(it,1));
            end
        elseif (evl(it,2)==uint16(8))
            fprintf(1,'found MAC header with Sequence# %d.\n',evl(it,3));
        elseif (evl(it,2)==uint16(16))
            fprintf(1,'found full payload in %d USRP frames.\n',evl(it,3));
        elseif (evl(it,2)==uint16(32))
            fprintf(1,'FCS ERROR for Sequence #%d.\n',evl(it,3));
        elseif (evl(it,2)==uint16(64))
            fprintf(1,'found expected #image bits in %d 802.11 frames.\n',evl(it,3));
        elseif (evl(it,2)==uint16(64))
            fprintf(1,'exiting due to Timeout after %d idle iterations.\n',evl(it,3));
        else
            fprintf(1,'UNKNOWN EVENT-ID:%d-VAL:%d.\n',evl(it,2),evl(it,3));
        end
    end % END FOR IT=0:CEV
end % END IF V
if (vm && (nib >= ril))
    % If all image bits received, display message and recovered image
    fprintf(1,'Full Image of %d bits Received. Exiting... \n',nib);
    rid = partialbi2im(rib,2,ri1,ri2,ri3);
    figure(128);
    imshow(rid);
end
return;
end % END FUNCTION DRX_V35

function [dfl,flg,nrb,rbs,sr] = drx_1ReceiveDATA(df,ft,prm,sr)
% DRX_1RECEIVEDATA: Gets 802.11b DATA frame in 256 consecutive USRP frames
% Function Arguments: 
% df:  This Data Frame, Raw USRP frame data in 1408 samples
% dfl: Data Flagged: uint16 to accompany data, set when status flag is true
% flg: Status Flags: a 1x5 logical array, carrying the following flags: 
% (1): fdf: Flag Detected Preamble: Set true if PLCP Preamble (SYNC) found
% (2): fph: Flag PLCP Header Found: Init false, set true if PHY Header rx'd
% (3): fec: Flag Error CRC: Init false, set true if PHY Header CRC in error
% (4): fmh: Flag MAC Header Found: Init false, set true if MAC Header rx'd
% (5): fpf: Flag All Payload Found: Init false, set true if all payload rxd
% ft:  Flag Terminal: If true, specifies to release System objects
% nrb: Number of Recovered (MAC) Bits: Zero if not returning any MAC bits
% prm: Parameter Structure, as initialized from init_v34
% rbs: Recovered Binary Sequence: Taken from MAC Hdr/Payload/FCS (64 bits)
% sr:  State of Designated Receiver (DRx), a 3-digit enumeration

% Persistent Data: Maintained between function calls to drx_1ReceiveData
% chf: Header Frame Count: Counts #USRP frames that have header info (0-2)
persistent chf;
% cp:  Payload Frame Count: Counts #USRP frames w/only payload data (0-251)
persistent cpf;
% hcd: Handle to PHY PLCP CRC Detector
persistent hcd;
% n8f: Number in Sequence of MPDU 802.11b frame
persistent n8f;
% nmb: Number of MPDU Bits (from LENGTH in PLCP Header, def. 16192 bits)
persistent nmb;
% npf: Number of Payload & FCS Frames =ceil((nmb-64)/64), def. 252
persistent npf;
% rb: Receive Buffer: Twice Length of USRP frame for Preamble Det (2816 samples)
persistent rb;
% sd: Synchronization Delay: Sample Number in USRP frame that designates
%     the start of data for this frame; found through Preamble Detection
persistent sd;
% CONSTANTS: For Construction of System objects
cas = double(1.0);
cau = double(1408);
cef = double(4.0);
% Initialize Persistent Data: Only on first call to drx_1ReceiveData
if isempty(chf),    chf = uint8(0);                 end
if isempty(cpf),    cpf = uint8(0);                 end
if isempty(n8f),    n8f = uint16(0);                end
if isempty(hcd)
    hcd = comm.CRCDetector('ChecksumsPerFrame',1,'FinalXOR',1, ...
        'InitialConditions',1,'Polynomial',[16,12,5,0]); 
end % END IF ISEMPTY(HCD)
if isempty(nmb),    nmb = uint16(16192);            end
if isempty(npf),    npf = uint8(252);               end
if isempty(rb),     rb  = complex(zeros(2816,1));   end
if isempty(sd),     sd  = uint16(0);                end
% Local Function Data: Overwritten on every call to drx_1ReceiveData
dfl = uint16(0);
flg = logical(false(1,5));
flt = logical(false(1,1)); %#ok<NASGU>
nrb = uint16(0);
rbs = zeros(64,1);
% tfd: This Frame Decoded: 1/11 the Length of this recovered USRP frame (64)
dfd = complex(zeros(64,1));
% tfr: This Frame Recovered: Half the Length of this USRP frame tf (704)
dfr = complex(zeros(704,1));
if (ft)
    release(hcd);
    %clear('hcd'); % Not supported for code generation
    rffe(df,ft,cas,cau,cef);
    ddd(dfr,ft);
    % Clear persistent data within RFFE() and DDD() functions
    % clear('rffe','ddd'); % Not supported for code generation
else
    % RF Front End: AGC, Freq Offset Correction, and RCRF
    dfr(1:704) = rffe(df,ft,cas,cau,cef);
    % Shift left receive buffer data by one recovered frame length (704)
    rb(1:2112) = rb(705:2816);
    % Add this recovered frame to end (last 704 samples) of receive buffer
    rb(2113:2816) = dfr(1:704);
    if (sr==uint8(211))     %prm.DRxStateRxSearchPreamble
        % Detect Preamble: Updates Synchronization Delay to Location of Max
        % Correlation with Expected Preamble; when correlation is above a 
        % threshold, it updates DRx State to "DecodeHeader"
        [flt,sd] = preambleDet(prm,rb);
        if (flt)
            % If detected PLCP Preamble, set flag #1: fdp
            flg(1,1) = logical(true(1));
            % Pass back this Synch Delay value in Flagged Data, dfl
            dfl = uint16(sd);
            sr  = uint8(212); %prm.DRxStateRxDecodeHeader;
        end
    else
        % Prepare only the 1st 704 frame bits starting at the synch delay
        dfr(1:704)  = rb(sd:(sd+703));
        % Despread, Demodulate, and Descramble Samples to make bitstream
        dfd(1:64)   = ddd(dfr,ft);
        if (sr==uint8(212)) %prm.DRxStateRxDecodeHeader
            chf = chf+uint8(1);
            if (chf==1)
                % TODO: Lvl 3 Fine SFD Correlation: Find exact PLCP Hdr start
                flg(1,2) = logical(true(1));
                % Get MPDU (MAC Hdr+Payload+FCS) Length from PLCP Header
                nmb = bi2de(dfd(33:48));
                % Pass back this Payload length value in dfl
                dfl = uint16(nmb);
                % Check CRC in PLCP Header
                [~,flt] = step(hcd, dfd(17:64));
                if (flt)
                    % If CRC check fails, set flag #3: fec to true
                    flg(1,3) = logical(true(1));
                    % Use default MPDU length: 16,192 bits
                    nmb = uint16(16192); dfl = nmb;
                end
                % Calculate number of Payload Frames from MPDU length 
                npf = ceil((nmb-64)/64);
            elseif (chf==2) %prm.NumHeaderFrames
                % TODO: Process other elements of MAC Header? 
                % Pass back all MAC bits, Header+Payload+FCS
                rbs(1:64) = dfd(1:64);
                nrb = uint16(64);
                % Get Number in Sequence of 802.11b Frame from MAC Header
                n8f = bi2de(dfd(49:64));
                % Set flag #4: fmh true when MAC Header is found
                flg(1,4) = logical(true(1));
                % Pass back Sequence Number in Flagged Data, dfl
                dfl = uint16(n8f);
                sr  = uint8(213); %prm.DRxStateRxGetPayload
            end % END IF CH==#
        elseif (sr==uint8(213)) %prm.DRxStateRxGetPayload
            % Update Payload Frame Count
            cpf = cpf+uint8(1);
            if (cpf>=npf) %prm.NumPayloadFrames
                % Calculate #bits to return from remainder after division
                % of #MPDU bits by 64 bits/USRPframe
                nrb = uint16(rem(nmb,uint16(64)));
                if (nrb==uint16(0)), nrb=uint16(64); end
                % Pass back all bits, even FCS used to verify no error
                rbs(1:nrb) = dfd(1:nrb);
                % Set flag #5 true to signify all payload data recovered
                flg(1,5) = logical(true(1));
                % Pass back total #payload frames in flagged data, dfl
                dfl = uint16(npf);
                % Change Major State from Rx DATA to Tx ACK
                sr = uint8(220); %prm.DRxStateTxACKSendACK
                % Reset all count variables internal to function
                chf = uint8(0);
                cpf = uint8(0);
            else
                % Store All Payload Bits in rbs and update bit count nrb
                nrb = uint16(64);
                rbs(1:64) = dfd(1:64);     
            end
        end % END IF SR==#
    end % END IF SR==211U
end % END IF FT
end % END FUNCTION DRX_1RECEIVEDATA

function [d2s,fat,sr] = drx_2TransmitACK(ft,n8f,sr)
% DRX_2TRANSMITACK: Transmits 802.11 ACK frame in 4 consecutive USRP frames
% Function Arguments: 
% d2s: Data To Send, frame data in 1408 samples to put on USRP Tx buffer
% fat: Flag ACK Transmitted: Set to true when last ACK USRP frame prepared
% ft:  Flag Terminal: If true, specifies to release System objects
% n8f: 802.11b Frame Number, for ACK header info
% sr:  State of Designated Receiver (DRx), a 3-digit enumeration

% Persistent Data: Maintained between function calls to drx_1ReceiveData
% ca:  Count ACK Header Frame: Tracks #USRP frames w/ ACK header info (0-4)
persistent ca;
% dfs: Data Frame Samples: Scrambled, Modulated, Spread 802.11 ACK Frame
persistent dfs;
% hcg: Handle to PHY PLCP CRC Generator
persistent hcg;
% hfg: Handle to MAC FCS CRC Generator
persistent hfg;
% hrt: Handle to Raised Cosine Transmit Filter (RCTF) System object
persistent hrt;
% Initialize Persistent Data: Only on first call to drx_2TransmitACK
if isempty(ca),     ca  = uint8(0);                 end
if isempty(dfs),    dfs = complex(zeros(2816,1));   end
if isempty(hcg)
    hcg = comm.CRCGenerator('ChecksumsPerFrame',1,'FinalXOR',1, ...
        'InitialConditions',1,'Polynomial',[16,12,5,0]); 
end % END IF ISEMPTY(HCG)
if isempty(hfg)
    hfg = comm.CRCGenerator('ChecksumsPerFrame',1,'FinalXOR',1, ...
        'InitialConditions',1,'Polynomial', ...
        [31,30,26,25,24,18,15,14,12,11,10,8,6,5,4,3,1,0]); 
end % END IF ISEMPTY(HFG)
if isempty(hrt)
    hrt = comm.RaisedCosineTransmitFilter('FilterSpanInSymbols',8, ...
        'Gain',1,'OutputSamplesPerSymbol',2,'RolloffFactor',0.3, ...
        'Shape','Square root');
end % END IF ISEMPTY(HRT)
% Local data preallocation
% dfb: Data Frame Bits: Binary 802.11 ACK Frame Bit Sequence
dfb = complex(zeros(64,1)); 
dfe = complex(zeros(704,1)); 
fat = logical(false(1));
if (ft)
    release(hcg);
    release(hfg);
    release(hrt);
    % Release System objects created by SMSRC() function
    sms(df,ft);
    % clear('hcg','hfg','hrt'); % Not supported for code generation
    % Clear persistent data within SMS() function
    % clear('sms'); % Not supported for code generation
else
    if (ca==0)
        % Prepare ACK 802.11b frame, starting with PLCP Preamble SYNC
        dfb(001:128) = ones(128,1);
        % PHY SFD & Start of PLCP Header
        dfb(129:144) = [0;0;0;0;0;1;0;1;1;1;0;0;1;1;1;1];
        dfb(145:152) = [0;1;0;1;0;0;0;0];
        dfb(153:160) = zeros(8,1);
        % LENGTH=MACHeader (64)+MAC Frame Body(0)+MAC FCS (32)
        dfb(161:176) = de2bi(64,16)';
        % Append 16-bit CRC to 32-bit PLCP Header: result is 48 bits
        dfb(145:192) = step(hcg, dfb(145:176));
        % Start of MAC Header: Frame Control for Type Ctrl/Subtype ACK
        dfb(193:200) = [0;0;0;1;1;1;0;1];
        % ACK Duration/ID Slot holds Frame number in sequence
        dfb(201:208) = de2bi(n8f,8)'; 
        % ACK RA is same as Address 2 field of previous directed DATA frame
        dfb(209:224) = [de2bi(10,8),de2bi(3,8)]';
        % Append 32-bit FCS to 32-bit MAC Header: result is 64 bits
        dfb(193:256) = step(hfg, dfb(193:224));
        % Scramble, Modulate, and Spread Bits (output len is 11x input)
        dfs(1:2816)  = sms(dfb(1:256),ft);
    end % IF CA==0
    dfe(1:704)  = dfs((ca*704+1):((ca+1)*704));
    d2s(1:1408) = step(hrt,dfe(1:704));
    ca = ca + uint8(1);
    if (ca==uint8(4))
        fat = logical(true(1));
        % Update DRx Major state to resume search for PLCP preamble
        sr = uint8(211);    %prm.DRxStateRxSearchPreamble;
        % Reset count variables internal to function
        ca = uint8(0);
    end
end
end % End Function DRX_2TRANSMITACK

function sr = drx_3WaitDIFS(sr)


end % End Function DRX_3WAITDIFS
