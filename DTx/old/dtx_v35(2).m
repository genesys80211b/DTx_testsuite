function dtx_v35()
% Designated Receiver Parameter Structure
prm = init_v35();
% Blank Data: For putting on Transmit Buffer while in a Rx Major State
db  = complex(zeros(1408,1));
% df: This USRP Data frame: The most-recently-received frame from USRP Rx Buffer
df  = complex(zeros(1408,1));
% d2s: Data To Send: To put on Transmit Buffer while in a Tx Major State
d2s = complex(zeros(1408,1)); %#ok<NASGU>
% f8t: Flag 802.11b frame Transmitted; wait for ACK
f8t = logical(false(1)); %#ok<NASGU>
% fe: Terminal Flag to Signal End-of-Transmission (EOT)
fe  = logical(false(1));
% fit: Flag Full Image Transmitted; program can exit after last ACK
fit = logical(false(1));
% ft: Terminal Flag to release System objects
ft  = logical(false(1));
% n8f: Number of 802.11b Frames Sent
n8f = uint8(0);
% ni:  Number of iterations of the main loop
ni  = uint32(0);
% sdt: State for Designated Transmitter (DTx): 3 Digits, 1st Digit is 1 for DTx
% 2nd Digit is 1 for Detect Energy, 2 for Transmit DATA, or 3 for Rx ACK
sdt = uint8(prm.DTxStateTransmitHeader);
% smt: DTx Major State: Most Significant 2 Digits of Full DTx State
smt = uint8(0); %#ok<NASGU>
% to: Timeout: The #iterations of the main loop to wait before exiting.
to  = uint32(1000);
% v: Verbose Mode: Displays additional text describing DRx actions
v   = logical(true(1));
while ~fe
    smt = sdt/uint8(10);
    if (smt==prm.DTxStateTransmitDATA)
        [d2s,f8t,fit] = dtx_2TransmitDATA(ft);
        transceive103_mex(d2s,ft);
        if (f8t)
            n8f = n8f + uint8(1);
            if (v)
                fprintf(1,'802.11B frame #%2d transmitted.\n',n8f);
            end
            sdt = prm.DTxStateRxACKSearchPLCP;
        end
    elseif (smt==prm.DTxStateRxACK)
        df = transceive103_mex(db,ft);
        [faf,sdt] = dtx_3ReceiveACK(df,ft,prm,sdt);
        if (faf)
            if (v)
                fprintf(1,'802.11B ACK #%2d received.\n',n8f);
            end
            if (fit)
                fe = logical(true(1));
            else
                sdt = prm.DTxStateTransmitHeader;
            end
        end
    elseif (smt==prm.DTxStateEnergyDet)
        sdt = dtx_1DetectEnergy(sdt);
    end % END IF DS
    ni = ni+uint32(1);
    if ni > to
        fe = logical(true(1));
    end
end % End While ~EOTFLAG
% Clear persistent data within all helper functions
ft = logical(true(1));
transceive103_mex(db,ft);
dtx_2TransmitDATA(ft);
dtx_3ReceiveACK(df,ft,prm,sdt);
return;
end % End Function DTX_V35

function [d2s,f8t,fit] = dtx_2TransmitDATA(ft)
% DTX_2TRANSMITDATA: Transmits DATA 802.11b frame in consecutive USRP frames
% Function Arguments: 
% d2s: Data To Send, frame data in 1408 samples to put on USRP Tx buffer
% f8t: Flag Full 802.11b Frame Transmitted: If true, specifies to change state to receive ACK
% fit: Flag Full Image Transmitted: If true, specifies to exit program after ACK
% ft:  Flag Terminal: If true, specifies to release System objects
% prm: Parameter Structure, as initialized from init_v35

% Persistent Data: Maintained between function calls to drx_1ReceiveData
% c8f: 802.11b Frame Count: Counts #802.11b Frames transmitted
persistent c8f;
% c8s: 802.11b Frame Sample Count: Counts #802.11b Frame samples transmitted
persistent c8s;
% cib: Image Bit Count: Counts #Image Data Bits transmitted
persistent cib;
% cuf: USRP Frame Count: Counts #USRP frames transmitted
persistent cuf;
% d8b: Data 802.11b Frame Bits: Binary seq to partition into USRP frames
persistent d8b;
% d8s: Data 802.11b Frame Samples: Complex seq to partition into USRP frames
persistent d8s;
% dib: Data Image Bits: Binary sequence to be sent in payload segments
persistent dib;
% hcg: Handle to PHY PLCP CRC Generator
persistent hcg;
% hfg: Handle to MAC FCS Generator
persistent hfg;
% hrt: Handle to Raised Cosine Transmit Filter (RCTF) System object
persistent hrt;
% nbb: Number of MSDU/MAC Frame Body Bits per 802.11b Frame (def 16,096)
persistent nbb;
% nib: Number of Image Data Bits: Length of dib vector (def 103,864)
persistent nib;
% nmb: Number of MPDU/MAC Frame Bits per 802.11b Frame (def 16,192)
persistent nmb;
% n8b: Number of PPDU/802.11b Frame Bits: Length of d8b vector (def 16,384)
persistent n8b;
% n8f: Number of 802.11b Frames to send the entire binary image data seq
persistent n8f;
% n8s: Number of PPDU/802.11b Frame Spread Samples (def 180,224)
persistent n8s;
% nuf: Number of USRP Frames for this 802.11b Frame (def 256)
persistent nuf;
% Initialize Persistent Data: Only on first call to dtx_2TransmitDATA
if isempty(c8f),    c8f = uint32(0);        end
if isempty(c8s),    c8s = uint32(0);        end
if isempty(cib),    cib = uint32(0);        end
if isempty(cuf),    cuf = uint32(0);        end
if isempty(d8b),    d8b = zeros(16384,1);   end
if isempty(d8s),    d8s = complex(zeros(180224,1));  end
if isempty(dib) || isempty(nib)
    % Load Image Data with any size -- MPDU preparation 
    fn  = 'membrane_color_smaller.jpg';  % fn: File Name
    him = vision.VideoFileReader(fn,'VideoOutputDataType','uint8');
    ic  = step(him);
    ig  = rgb2gray(ic);
    ii  = info(him);
    is  = ii.VideoSize;
    dib = im2bi(ig);
    nib = uint32(is(1)*is(2)*8+24);
    release(him);
    % clear('him'); %Not supported for code generation
end
if isempty(hcg)
    hcg = comm.CRCGenerator('ChecksumsPerFrame',1,'FinalXOR',1, ...
        'InitialConditions',1,'Polynomial',[16,12,5,0]); 
end
if isempty(hfg)
    hfg = comm.CRCGenerator('ChecksumsPerFrame',1,'FinalXOR',1, ...
        'InitialConditions',1,'Polynomial', ...
        [31,30,26,25,24,18,15,14,12,11,10,8,6,5,4,3,1,0]); 
end
if isempty(hrt)
    hrt = comm.RaisedCosineTransmitFilter('FilterSpanInSymbols',8, ...
        'Gain',1,'OutputSamplesPerSymbol',2,'RolloffFactor',0.3, ...
        'Shape','Square root');
end % IF ISEMPTY(HRT)
% Initial MAC frame bodies have 2012 octets, or 16,096 bits
if isempty(nbb),    nbb = uint32(16096);        end
% Initial MAC frames have 2024 octets, or 16096+96=16,192 bits
if isempty(nmb),    nmb = nbb+uint32(96);       end
% Initial PHY frames have 2048 octets, or 16192+192=16,384 bits
if isempty(n8b),    n8b = nmb+uint32(192);      end
% Small image takes 103,864/16,096=6 802.11b Frames
if isempty(n8f),    n8f = uint32(ceil(double(nib)/double(nbb))); end
% Initial PHY frames have 16,384*11=180,224 spread samples
if isempty(n8s),    n8s = n8b*uint32(11);       end
% Initial 802.11b Frames take 16,384/64=256 USRP frames
if isempty(nuf),    nuf = uint32(ceil(double(n8b)/64)); end
% Local data preallocation
d2s = complex(zeros(1408,1));
dss = complex(zeros(704,1));
f8t = logical(false(1));
fit = logical(false(1));
if (ft)
    % Release System objects: only on final call to dtx_2TransmitDATA()
    release(hcg);
    release(hfg);
    release(hrt);
    % Release System objects created by SMS() function
    sms(d8s,ft);
    % clear('hcg','hfg','hrt'); % Not supported for code generation
    % Clear persistent data within SMS() function
    % clear('sms'); % Not supported for code generation
else
    % ONLY ON 1ST USRP FRAME IN THIS 802.11B FRAME, prepare PPDU samples
    if (cuf == uint32(0))
        % Update 802.11b Frame Count
        c8f = c8f + 1;
        % ONLY ON LAST 802.11B FRAME, recalculate NXX persistent variables
        if (c8f == n8f)
            % Recalculate MSDU/MAC frame body length from #remaining bits to send
            nbb = min((nib-cib), uint32(16096));
            % Recalculate MPDU/MAC frame length from MSDU length
            nmb = nbb + uint32(96);
            % Recalculate PPDU/802.11b frame length from MPDU length
            n8b = nmb + uint32(192);
            % Recalculate #PPDU samples from #PPDU bits
            n8s = n8b * uint32(11);
            % Recalculate #USRP frames per 802.11b frame
            nuf = uint32(ceil(double(n8b)/64));
        end
        % On 1st USRP frame, prepare this 802.11b frame
        % Send SYNC signal in 1st 128 bits
        d8b(001:128) = ones(128,1);    
        % Send PHY SFD & PLCP Header in next 64 bits
        d8b(129:144) = [0;0;0;0;0;1;0;1;1;1;0;0;1;1;1;1]; 
        d8b(145:152) = [0;1;0;1;0;0;0;0];
        d8b(153:160) = zeros(8, 1);
        % LENGTH=MACHeader (64)+MSDU/MAC Frame Body(0)+MAC FCS (32)
        d8b(161:176) = de2bi(nmb, 16)'; 
        % Append 16-bit CRC to 32-bit PLCP Header: result is 48 bits
        d8b(145:192) = step(hcg, d8b(145:176));
        % Send MAC Header for DATA frame
        % DATA Frame Control (8 bits): Ver 00, Type 10, Subtype 0000
        d8b(193:200) = [0;0;1;0;0;0;0;0];
        % DATA Frame Duration/ID Slot (8 bits) holds Frame number in sequence
        d8b(201:208) = de2bi(c8f, 8)'; 
        % DATA Frame Address 1 is RA
        d8b(209:224) = [de2bi(20,8),de2bi(2,8)]';
        % DATA Frame Address 2 is TA
        d8b(225:240) = [de2bi(10,8),de2bi(2,8)]';
        d8b(241:256) = zeros(16,1);
        % DATA MSDU / MAC Frame Body: n8b bits
        d8b(257:257+nbb) = dib(cib+1:cib+nbb);
        % Append 32-bit FCS to MAC Header(64)+MSDU(16,096): res 16,192 bits
        d8b(193:290+nbb) = step(hfg, d8b(193:257+nbb));    
        % Scramble, Modulate, and Spread this 802.11b Frame
        d8s(1:n8s) = sms(d8b,ft);
        % Update Image Data Bit Count
        cib = cib + nbb;
    end % IF CUF==0
    dss(1:704)  = d8s(c8s+1:c8s+704);
    d2s(1:1408) = step(hrt,dss);
    c8s = c8s + uint32(704);
    cuf = cuf + uint32(1);
    if ((cuf>=nuf) || (c8s>=n8s))
        % Update 802.11 Frame Transmitted Flag to TRUE
        f8t = logical(true(1));
        if ((c8f>=n8f) || (cib>=nib))
            % Update Entire Image Transmitted Flag to TRUE
            fit = logical(true(1));
        end
        % Reset 802.11b sample count and USRP frame count
        c8s = uint32(0);
        cuf = uint32(0);
        % Reset default number of bits, samples, and frames
        nbb = uint32(16096); 
        nmb = nbb + uint32(96);
        n8b = nmb + uint32(192);
        n8s = n8b * uint32(11);
        nuf = uint32(ceil(double(n8b)/64)); 
    end % IF CUF==NUF
end
end % End Function DTX_2TRANSMITDATA

function [faf,sdt] = dtx_3ReceiveACK(df,ft,prm,sdt)
% DRX_3RECEIVEACK: Receives ACK 802.11b frame in 4 consecutive USRP frames
%   (SYNC(1), SYNC(2), PHY Header, MAC Header+FCS)
% Function Arguments: 
% df:  This Data Frame, Raw USRP frame data in 1408 samples
% faf: Flag Full ACK Found: Init false, set true when ACK fully received
% ft:  Flag Terminal: If true, specifies to release System objects
% prm: Parameter Structure, as initialized from init_v34
% rbs: Recovered Binary Sequence: Taken from Payload (MAC Body) (64 bits)
% sdt: State for Designated Transmitter

% Persistent Data: Maintained between function calls to dtx_3ReceiveACK
% chf: Header Frame Count: Counts #USRP frames with header info (0-2)
persistent chf;
% dbf: Data Buffer (2,816 samples)
persistent dbf;
% drb: Data Received Bits (64)
persistent drb;
% drs: Data Received Samples (704)
persistent drs;
% hcd: Handle to PHY PLCP CRC Detector
persistent hcd;
% hcd: Handle to MAC FCS Detector
persistent hfd;
% n8f: 802.11b MAC Header Frame Number
persistent n8f;
% nds: Number of Delay Samples/Synchronization Delay: Refers to the Sample 
%     Number in the data receive buffer (dbf) that designates the start 
%     of the data sequence for this USRP frame; found thru Preamble Detection
persistent nds;
% nmb: Number of MPDU/MAC Frame Bits (64)
persistent nmb;
% CONSTANTS: For Construction of System objects
% cas: Constant AGC Step Size: 1.0
cas = double(1.0);
% cau: Constant AGC Update Rate: 1408 samples
cau = double(1408);
% cef: Constant Frequency Offset Estimation Freq Resolution: 1.0 Hz
cef = double(1.0);
% Initialize Persistent Data: Only on first call to dtx_3ReceiveACK()
if isempty(chf),    chf = uint8(0);                 end
if isempty(dbf),    dbf = complex(zeros(2816,1));   end
if isempty(drb),    drb = complex(zeros(64,1));     end
if isempty(drs),    drs = complex(zeros(704,1));    end
if isempty(hcd)
    hcd = comm.CRCDetector('ChecksumsPerFrame',1,'FinalXOR',1, ...
        'InitialConditions',1,'Polynomial',[16,12,5,0]); 
end
if isempty(hfd)
    hfd = comm.CRCDetector('ChecksumsPerFrame',1,'FinalXOR',1, ...
        'InitialConditions',1,'Polynomial', ...
        [31,30,26,25,24,18,15,14,12,11,10,8,6,5,4,3,1,0]); 
end
if isempty(n8f),    n8f = uint8(0);                 end
if isempty(nds),    nds = uint16(0);                end
if isempty(nmb),    nmb = uint16(0);                end
% Local Function Data: Overwritten on every call to dtx_3ReceiveACK()
faf = logical(false(1));
fc  = logical(false(1)); %#ok<NASGU>
ff  = logical(false(1)); %#ok<NASGU>
% dfd: Data Frame Decoded: 1/11 the Length of this recovered USRP frame (64)
dfd = complex(zeros(1408,1));
% dfr: Data Frame Recovered: Half the Length of USRP frame data df (704)
dfr = complex(zeros(704,1));

if (ft)
    % Release System objects: only on final call to dtx_3ReceiveACK()
    release(hcd);
    release(hfd);
    % Release all System objects created by RFFE and DDD functions
    rffe(df,ft,cas,cau,cef);
    ddd(dfr,ft);
    % clear('hcd','hfd'); % Not supported for code generation
    % Clear persistent data within RFFE() function
    % clear('rffe','ddd'); % Not supported for code generation
else
    dfr(1:704) = rffe(df,ft,cas,cau,cef);
    % Shift left receive buffer data by one recovered frame length (704)
    dbf(1:2112) = dbf(705:2816);
    % Add this recovered frame to end (last 704 samples) of receive buffer
    dbf(2113:2816) = dfr(1:704);
    if (sdt==prm.DTxStateRxACKSearchPLCP)
        % Detect Preamble: Updates Synchronization Delay to Location of Maximum
        % Correlation with Expected Preamble; when correlation is above a 
        % threshold, it updates DRx State to "DecodeHeader"
        [fpd, nds] = preambleDet(prm, dbf);
        if (fpd)
            sdt = prm.DTxStateRxACKDecodeHeader;
        end % IF FPD
    elseif (sdt==prm.DTxStateRxACKDecodeHeader)
        % Prepare only the 1st 704 frame bits starting at the synchronization delay
        dfr(1:704)  = dbf(nds:(nds+uint16(704)));
        dfd(1:64)   = ddd(dfr,ft);
        chf = chf + uint8(1);
        if (chf==uint8(1))
            % TODO: Lvl 3 Fine SFD Correlation: Find exact start of PLCP Header
            % Check CRC in PLCP Header (first 16 bits, SFD, not used)
            [~, fc] = step(hcd, dfd(17:64));
            if fc
                % TODO: Actions when CRC check fails
            else
                % Get PSDU Length from PLCP Header bits (after SIGNAL/SERVICE)
                nmb = bi2de(dfd(33:48));
            end
        elseif (chf==uint8(2))
            % Confirm whether first 8 bits signify an ACK
            if all(dfd(3:8)==[0;1;1;1;0;1])
                faf = logical(true(1));
                sdt = prm.DTxStateTransmitHeader;
            else
                % TODO: Actions when MAC Frame Control shows NOT an ACK               
            end
            % Check FCS in MAC Header (last 32 bits)
            [~, ff] = step(hfd, dfd(1:64));
            if ff
                % TODO: Actions when MAC FCS CRC check fails
            else
                % Get 802.11 Frame Number from MAC Header
                n8f = bi2de(dfd(9:16)); 
            end
        end
    end % END IF SDT
end % END IF FT
end % END FUNCTION DTX_3RECEIVEACK

function sdt = dtx_1DetectEnergy(sdt)


end % End Function DTX_1ENERGYDET
