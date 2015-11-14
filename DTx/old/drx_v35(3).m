function drx_v35()
% Designated Receiver Parameter Structure
prm = init_v35();
% cdb: CONSTANT Blank Data: To put on Tx Buffer while in a Rx major state
cdb  = complex(zeros(1408,1));
% df: This USRP Data frame: The most-recently-received frame from USRP Rx Buffer
df  = complex(zeros(1408,1)); %#ok<NASGU>
% d2s: Data To Send: To put on Transmit Buffer while in a Tx Major State
d2s = complex(zeros(1408,1)); %#ok<NASGU>
% fe: Terminal Flag to Signal End-of-Transmission (EOT)
fe  = logical(false(1));
% ff: FCS Flag
ff  = logical(false(1)); %#ok<NASGU>
% fpf: Flag Full Payload Found: Init false, set true when full payload rx'd
fpf = logical(false(1)); %#ok<NASGU>
% ft: Terminal Flag to release System objects
ft  = logical(false(1));
% hfd: Handle to MAC FCS Detector
hfd = comm.CRCDetector('ChecksumsPerFrame',1,'FinalXOR',1, ...
    'InitialConditions',1,'Polynomial', ...
    [31,30,26,25,24,18,15,14,12,11,10,8,6,5,4,3,1,0]); 
% n8f: Number of 802.11b Frames Recovered
n8f = uint8(0);
% ni:  Number of iterations of the main loop
ni  = uint32(0);
% nib: Total Number of Recovered Image Bits: Length of Data in rib, range 0 to 103,864
nib = uint64(0);
% nmb: Total Number of Recovered MPDU Bits: Length of Data in rfs, range 0 to 16,192
nmb = uint64(0);
% npb: Total Number of Recovered Payload Bits: nmb-len(header)-len(FCS)
npb = uint64(0);
% nub: Number of Recovered USRP Bits: Length of Data in rbs, range 0 to 64
nub = uint16(0);
% rbs: Recovered Binary Sequence: Recovered from Payload (MAC Body) (64 bits)
rbs = zeros(64,1);
% rfs: Recovered MPDU for one 802.11b Frame: Combined from rbs's (16,192 bits)
rfs = zeros(16192,1);
% ri1: Recovered Image Height, or Number of Rows (expected 110)
ri1 = uint32(prm.ImageExpectedHeight);
% ri2: Recovered Image Width, or Number of Columns (expected 118)
ri2 = uint32(prm.ImageExpectedWidth);
% ri3: Recovered Image 3rd Dimension Size (expected 1 for grayscale image)
ri3 = uint32(prm.ImageExpectedDepth);
% ril: Recovered Image Length: the Total Number of Bits Expected (103,864 bits)
ril = uint32(ri1*ri2*ri3*uint32(prm.NumBitsPerOctet)+uint32(prm.ImageExpectedNumHeaderBits));
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
% to: Timeout: The #iterations of the main loop to wait before exiting.
to  = uint32(1000);

% v: Verbose Mode: Displays additional text describing DRx actions
v   = logical(true(1));
while ~fe
    sm = sr/uint8(10);
    if (sm==uint8(21)) %prm.DRxStateRxDATA
        df = transceive202_mex(cdb,ft);
        [fpf,nub,rbs,sr] = drx_1ReceiveData(df,prm,sr);
        if (nub > 0)
            rfs((nmb+1):(nmb+nub)) = rbs(1:nub);
            % Increase total MPDU bit count by this # of recovered USRP bits
            nmb = nmb + uint64(nub);
            if fpf
                % Check FCS in MAC Header
                [~,ff] = step(hfd, rfs);
                if ff
                    % TODO: Actions when MAC FCS check fails
                end
                % On first fully received 802.11b frame payload, get image size
                if (n8f < 1) && (tnb==uint64(0))
                    [~,ri1,ri2,ri3] = partialbi2im(rfs,1);
                    ril = uint32(ri1*ri2*ri3*uint32(prm.NumBitsPerOctet) ...
                        +uint32(prm.ImageExpectedNumHeaderBits));
                end
                % Optional: Display message and show partial image
                if v
                    fprintf(1,'Full Payload Found for 802.11b Frame #%d.\n',n8f);
                    rid = partialbi2im(rib,2,ri1,ri2,ri3);
                    if ~isempty(rid);
                        figure(128);
                        imshow(rid);
                    end
                end % IF V
                % Append this 802.11b frame's Payload Bits to Recovered
                % Image Bitstream vector
                npb = (nmb-prm.NumMACHeaderBits-prm.NumFCSBits);
                rib((nib+1):(nib+npb)) = rfs((prm.NumMACHeaderBits+1): ...
                    (prm.NumMPDUBits-prm.NumFCSBits));
                nib = nib + uint64(npb);
                nmb = uint64(0);
                
                % Increment total number of 802.11b frames found by 1
                n8f = n8f + 1; 
                % Change DRx State to Transmit ACK
                sr = prm.DRxStateRxSearchPreamble; %prm.DRxTransmitACK;
                % Clear all persistent Data in function drx_1ReceiveData()
                clear('drx_1ReceiveData');
                if (nib == ril) % If #image bits equals expected image length, set flag to exit
                    fe = logical(true(1));
                end
            end % IF FPF

        end % IF NRB>0
            
    elseif (sm==prm.DRxStateTxACK)
        [d2s,sr] = drx_2TransmitACK(n8f,sr);
        transceive202_mex(d2s,ft);
    elseif (sm==prm.DRxStateDIFS)
        sr = drx_3WaitDIFS(sr);
    end % END IF DS
    ni = ni+uint32(1);
    if ni > to
        fe = logical(true(1));
    end
end % End While ~EOTFLAG
if (nib == ril)
    fprintf(1,'Full Image of %d bits Received. Exiting. \n',nib);
    rid = partialbi2im(rib,2,ri1,ri2,ri3);
    if ~isempty(rid);
        figure(128);
        imshow(rid);
    end
end
end % End Function DRX_V34

function [flg,nrb,rbs,sr] = drx_1ReceiveData(df,ft,prm,sr)
% DRX_1RECEIVEDATA: Gets 802.11b DATA frame in 256 consecutive USRP frames
% Function Arguments: 
% df:  This Data Frame, Raw USRP frame data in 1408 samples
% flg: Status Flags: a 4x1 logical array, carrying the following flags: 
% (1): fdf: Flag Detected Preamble: Set true if PLCP Preamble (SYNC) found
% (2): fec: Flag Error CRC: Init false, set true if PHY Header CRC in error
% (3): fmh: Flag MAC Header Found: Init false, set true if MAC Header rx'd
% (4): fpf: Flag All Payload Found: Init false, set true if all payload rxd
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
% n8f: Number of 802.11b Frame (from Seq# in MAC Header)
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
cef = double(1.0);
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
flg = logical(false(4,1));
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
        [flg(1),sd] = preambleDet(prm,rb);
        if flg(1)
            sr = uint8(212); %prm.DRxStateRxDecodeHeader;
        end
    else
        % Prepare only the 1st 704 frame bits starting at the synch delay
        dfr(1:704)  = rb(sd:(sd+703));
        % Despread, Demodulate, and Descramble Samples to make bitstream
        dfd(1:64)   = ddd(dfr,ft);
        if (sr==uint8(212)) %prm.DRxStateRxDecodeHeader
            chf = chf+uint8(1);
            if (chf==1)
                % TODO: Lvl 3 Fine SFD Correlation: Find exact start of PLCP Header
                % Check CRC in PLCP Header; if CRC check fails, set flag #2
                [~,flg(2)] = step(hcd, dfd(17:64));
                if ~(flg(2))
                    % Get Payload Length from PLCP Header
                    nmb = bi2de(dfd(33:48));
                    % Calculate number of 
                    npf = ceil((nmb-64)/64);
                end
            elseif (chf==2) %prm.NumHeaderFrames
                % Set flag #3: fmh when MAC Header is found
                flg(3) = logical(true(1));
                % TODO: Process other elements of MAC Header? 
                % Pass back all MAC bits, Header+Payload+FCS
                rbs(1:64) = dfd(1:64);
                nrb = uint16(64);
                % Get 802.11 Frame Number from MAC Header
                n8f = bi2de(dfd(49:64));
                sr  = uint8(213); %prm.DRxStateRxGetPayload
            end % END IF CH==#
        elseif (sr==uint8(213)) %prm.DRxStateRxGetPayload
            % Update Payload Frame Count
            cpf = cpf+uint8(1);
            if (cpf==npf) %prm.NumPayloadFrames
                nrb = uint16(rem(nmb,64));
                if (nrb==uint16(0)), nrb=64; end
                rbs(1:nrb) = dfd(1:nrb);
                sr = uint8(220); %prm.DRxStateTxACKSendACK
                % Set flag #4 true to signify all payload data was recovered
                flg(4) = logical(true(1));
                % Reset all counts
                chf = uint8(0);
                cpf = uint8(0);
            else
                % Store All Payload Bits in rbs and update bit count nrb
                % Pass back all bits, even FCS used to verify no error
                nrb = uint16(64);
                rbs(1:64) = dfd(1:64);     
            end
        end % END IF SR==#
    end % END IF SR==211U
end % END IF FT
end % END FUNCTION DRX_1RECEIVEDATA

function [d2s,sr] = drx_2TransmitACK(ft,n8f,sr)
% DRX_2TRANSMITACK: Transmits 802.11 ACK frame in 4 consecutive USRP frames
% Function Arguments: 
% d2s: Data To Send, frame data in 1408 samples to put on USRP Tx buffer
% ft:  Flag Terminal: If true, specifies to release System objects
% n8f: 802.11b Frame Number, for ACK header info
% sr:  State of Designated Receiver (DRx), a 3-digit enumeration

% Persistent Data: Maintained between function calls to drx_1ReceiveData
% ca: ACK Header Count: Counts #USRP frames that have ACK header info (0-4)
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
    if (ca==4)
        ca = uint8(0);
        % Update DRx state to resume search for PLCP preamble
        sr = uint8(211);    %prm.DRxStateRxSearchPreamble;
    end
end
end % End Function DRX_2TRANSMITACK

function sr = drx_3WaitDIFS(sr)


end % End Function DRX_3WAITDIFS
