function dtx_v35()
% Designated Receiver Parameter Structure
prm = init_v35();
% Blank Data: For putting on Transmit Buffer while in a Rx Major State
db  = complex(zeros(prm.USRPFrameLength,1));
% df: This USRP Data frame: The most-recently-received frame from USRP Rx Buffer
df  = complex(zeros(prm.USRPFrameLength,1));
% d2s: Data To Send: To put on Transmit Buffer while in a Tx Major State
d2s = complex(zeros(prm.USRPFrameLength,1));
% fe: Terminal Flag to Signal End-of-Transmission (EOT)
fe  = logical(false(1));
% ff: FCS Flag
ff  = logical(false(1));
% fpt: Full Payload Transmitted Flag
fpt = logical(false(1));
% ft: Terminal Flag to release System objects
ft  = logical(false(1));
% hfd: Handle to MAC FCS Detector
hfd = comm.CRCDetector( ...
    'ChecksumsPerFrame', prm.CRCChecksumsPerFrame, ...
    'FinalXOR',          prm.CRCFinalXOR, ...
    'InitialConditions', prm.CRCInitialConditions, ...
    'Polynomial',        prm.FCSPolynomial ...
    ); 
% n8f: Number of 802.11b Frames Sent
n8f = uint8(0);
% ni:  Number of iterations of the main loop
ni  = uint32(0);
% nib: Total Number of Transmitted Image Bits: Length of Data in tib, range 0 to 103,864
nib = uint64(0);
% nmb: Total Number of Transmitted MPDU Bits: Length of Data in tfs, range 0 to 16,192
nmb = uint64(0);
% npb: Total Number of Transmitted Payload Bits: nmb-len(header)-len(FCS)
npb = uint64(0);
% nub: Number of Transmitted USRP Bits: Length of Data in tbs, range 0 to 64
nub = uint16(0);
% sdr: State for Designated Receiver (DRx): 3 Digits, 1st Digit is 2 for DRx
% 2nd Digit is 1 for Receive Data, 2 for Transmit ACK, or 3 for Wait DIFS
sdr = uint8(prm.DTxStateStart);
% sm: DRx Major State: Most Significant 2 Digits of Full DRx State
sm  = uint8(0);
% tbs: Transmitted Binary Sequence: Recovered from Payload (MAC Body) (64 bits)
tbs = zeros(prm.NumUSRPFrameBits,1);
% tfs: Transmitted MPDU for one 802.11b Frame: Combined from rbs's (16,192 bits)
tfs = zeros(prm.NumUSRPFrameBits,1);
% ti1: Transmitted Image Height, or Number of Rows (expected 110)
ti1 = uint32(is(1));
% ti2: Transmitted Image Width, or Number of Columns (expected 118)
ti2 = uint32(prm.ImageExpectedWidth);
% ti3: Transmitted Image 3rd Dimension Size (expected 1 for grayscale image)
ti3 = uint32(prm.ImageExpectedDepth);
% til: Transmitted Image Length: the Total Number of Bits Expected (103,864 bits)
til = uint32(is(1)*is(2)*is(3)*uint32(prm.NumBitsPerOctet)+uint32(prm.ImageExpectedNumHeaderBits));
% tib: Transmitted Full Binary Image Sequence: Concatenated from tfs's,  
%      802.11b Frame Payloads, contains entire image data (103,864 bits)
tib = zeros(ril,1);
% tid: Transmitted Image Data (expected size is 110x118x1)
tid = uint8(zeros(ri1,ri2,ri3));
% to: Timeout: The #iterations of the main loop to wait before exiting.
to  = uint32(1000);
% v: Verbose Mode: Displays additional text describing DRx actions
v   = logical(true(1));
while ~fe
    sm = sdr/uint8(10);
    if (sm==prm.DTxStateTransmitDATA)
        [d2s] = dtx_2TransmitDATA();
        transceive103_mex(d2s,ft);
    elseif (sm==prm.DTxStateRxACK)
        df = transceive202_mex(db,ft);
        [] = dtx_3ReceiveACK(df,ft);
    elseif (sm==prm.DTxStateEnergyDet)
        sdr = dtx_1DetectEnergy(sdr);
    end % END IF DS
    ni = ni+uint32(1);
    if ni > to
        fe = logical(true(1));
    end
end % End While ~EOTFLAG
ft = logical(true(1));
transceive103_mex(db,ft);
return;
end % End Function DTX_V35

function [d2s,fpt] = dtx_2TransmitDATA(ft,n8f)
% DTX_2TRANSMITDATA: Transmits DATA 802.11b frame in consecutive USRP frames
% Function Arguments: 
% d2s: Data To Send, frame data in 1408 samples to put on USRP Tx buffer
% fpt: Flag Payload Transmitted: If true, specifies to change state
% ft:  Flag Terminal: If true, specifies to release System objects
% n8f: 802.11b Frame Number, for DATA header info

% Persistent Data: Maintained between function calls to drx_1ReceiveData
% c8f: 802.11b Frame Count: Counts #802.11b Frames transmitted
persistent c8f;
% cib: Image Bit Count: Counts #Image Data Bits transmitted
persistent cib;
% cuf: USRP Frame Count: Counts #USRP frames transmitted
persistent cuf;
% d8b: Data 802.11b Frame Bits: Binary seq to partition into USRP frames
persistent d8b;
% dib: Data Image Bits: Binary sequence to be sent in payload segments
persistent dib;
% hcg: Handle to PHY PLCP CRC Generator
persistent hcg;
% hfg: Handle to MAC FCS Generator
persistent hfg;
% hrt: Handle to Raised Cosine Transmit Filter (RCTF) System object
persistent hrt;
% n8b: Number of 802.11b Frame Payload Bits: Length of data in d8b vector
persistent n8b;
% nib: Number of Image Data Bits: Length of data in dib vector
persistent nib;
% Initialize Persistent Data: Only on first call to drx_1ReceiveData
if isempty(c8f),    c8f = uint8(0);         end
if isempty(cib),    cib = uint32(0);        end
if isempty(cuf),    cuf = uint16(0);        end
if isempty(d8b),    d8b = zeros(360448,1);  end
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
if isempty(n8b),    n8b = uint32(360448);   end
% Local data preallocation
dfb = complex(zeros(64,1));
dfe = complex(zeros(1408,1));
fpt = logical(false(1));
if (ft)
    release(hcg);
    release(hfg);
    release(hrt);
    % Release System objects created by SMS() function
    sms(df,ft);
    clear('hcg','hfg','hrt');
    % Clear persistent data within SMS() function
    clear('smsrc');
else
    if (cuf == uint16(0))
        % On 1st USRP frame, prepare this 802.11b frame
        % Send SYNC signal in 1st 128 bits
        d8b(  1:128) = prm.SYNC(1:128);
        % Send PHY SFD & PLCP Header in next 64 bits
        d8b(129:144) = prm.SFD(1:16);
        d8b(145:152) = prm.SIGNAL(1:8);
        d8b(153:160) = prm.SERVICE(1:8);
        % Calculate PSDU (MPDU) length from #remaining bits to send
        n8b = min(nib - cib, 354112);
        % LENGTH=MACHeader (64)+MAC Frame Body(0)+MAC FCS (32)
        d8b(161:176) = de2bi(, 16)'; 
        % Append 16-bit CRC to 32-bit PLCP Header: result is 48 bits
        d8b(17:64) = step(hcg, dfb(17:48));
    elseif (ca==3)
        % Send MAC Header
        dfb( 1: 8) = prm.FrameControlACK(1:8);
        % ACK Duration/ID Slot holds Frame number in sequence
        dfb( 9:16) = de2bi(n8f, 8)'; 
        % ACK RA is same as Address 2 field of previous directed DATA frame
        dfb(17:32) = prm.DTA(1:16);
        % Append 32-bit FCS to 32-bit MAC Header: result is 64 bits
        dfb( 1:64) = step(hfg, dfb(1:32));
    end % IF CA==#
    dfe(1:prm.USRPFrameLength) = smsrc(dfb,ft,prm);
    ca = ca + uint8(1);
    if (ca==4)
        ca = uint8(0);
        % Update DRx state to resume search for PLCP preamble
        sdr = prm.DRxStateRxSearchPreamble;
    end
end
d2s(1:prm.USRPFrameLength) = dfe(1:prm.USRPFrameLength);
end % End Function DTX_1SendDATA

function [] = dtx_3ReceiveACK()
% DRX_1RECEIVEDATA: Receives DATA 802.11b frame in 256 consecutive USRP frames
% Function Arguments: 
% df:  This Data Frame, Raw USRP frame data in 1408 samples
% fmh: Flag MAC Header Found: Init false, set true when MAC Header rx'd
% fpf: Flag Full Payload Found: Init false, set true when full payload rx'd
% npb: Number of Recovered Payload Bits: Zero if not returning payload bits
% prm: Parameter Structure, as initialized from init_v34
% rbs: Recovered Binary Sequence: Taken from Payload (MAC Body) (64 bits)
% sdr: Designated Receiver (DRx) State, a 3-digit enumeration

% Persistent Data: Maintained between function calls to drx_1ReceiveData
% ch: Header Count: Counts #USRP frames that have decoded header info (0-2)
persistent ch;
% cp: Payload Count: Counts #USRP frames that have decoded payload info (0-251)
persistent cp;
% cpf: Payload+FCS Count: Counts #USRP frames that have both payload and FCS (0-1)
persistent cpf;
% dfl: Decoded Frame Length: 1/22 the Length of USRP frame (64 bits)
persistent dfl;
% f8n: 802.11b MAC Header Frame Number
persistent f8n;
% hcd: Handle to PHY PLCP CRC Detector
persistent hcd;
% pl: Payload Length: #Bits in Payload (a.k.a. MAC Body) (16096 bits)
persistent pl;
% rb: Receive Buffer: Twice Length of USRP frame for Preamble Det (2816 samples)
persistent rb;
% rfl: Recovered Frame Length: Half the Length of USRP frame (704)
persistent rfl;
% sd: Synchronization Delay: Sample Number in USRP frame that designates
%     the start of data for this frame; found through Preamble Detection
persistent sd;
% CONSTANTS: For Construction of System objects
cad = 'Rectifier';
cal = 'Logarithmic';
cam = double(30.0);
cas = double(1.0);
cau = double(1408);
cea = 'FFT-based';
cef = double(1.0);
cem = double(2);
ces = double(100000);
cff = 'Input port';
cfp = double(0.0);
cmo = 'double';
cmp = double(0.0);
crd = double(2);
cre = double(0);
crf = double(8);
crg = double(1.0);
cri = double(2);
crr = double(0.3);
crs = 'Square root';
csc = double(2);
csi = [0,0,0,0,0,0,0];
csp = [1,0,0,0,1,0,0,1];
% cub: USRP Frame Length in Bits: Constant 64
cub = double(64);
% cus: USRP Frame Length in Samples: Constant 1408
cus = double(1408);
% Initialize Persistent Data: Only on first call to drx_1ReceiveData
if isempty(ch),     ch  = uint8(0);                 end
if isempty(cp),     cp  = uint8(0);                 end
if isempty(cpf),    cpf = uint8(0);                 end
if isempty(dfl),    dfl = prm.NumUSRPFrameBits;     end
if isempty(f8n),    f8n = uint16(0);                end
if isempty(hcd)
    hcd = comm.CRCDetector( ...
        'ChecksumsPerFrame', prm.CRCChecksumsPerFrame, ...
        'FinalXOR',          prm.CRCFinalXOR, ...
        'InitialConditions', prm.CRCInitialConditions, ...
        'Polynomial',        prm.CRCPolynomial ...
        ); 
end
if isempty(pl),     pl  = uint16(0);                end
if isempty(rfl),    rfl = prm.RecoveredFrameLength; end
if isempty(sd),     sd  = uint16(0);                end
% Local Function Data: Overwritten on every call to drx_1ReceiveData
fc  = logical(false(1));
fmh = logical(false(1));
fpf = logical(false(1));
ft  = logical(false(1));
nrb = uint16(0);
rbs = false(dfl,1);
% tfd: This Frame Decoded: 1/11 the Length of this recovered USRP frame (64)
dfd = complex(zeros(dfl,1));
% tfr: This Frame Recovered: Half the Length of this USRP frame tf (704)
dfr = complex(zeros(rfl,1));
dfr(1:rfl) = rffe(df,ft,prm,cad,cal,cam,cas,cau,cea,cef,cem,ces,cfp, ...
    cff,cus,crd,cre,crf,crg,cri,crr,crs);
if isempty(rb)
    rb = complex(zeros(4*rfl,1));
else
    % Shift left receive buffer data by one recovered frame length (704)
    rb(1:(3*rfl)) = rb((rfl+1):(4*rfl));
    % Add this recovered frame to end (last 704 samples) of receive buffer
    rb((3*frl+1):(4*frl)) = dfr(1:rfl);
end
if (sdr==prm.DRxStateRxSearchPreamble)
    % Detect Preamble: Updates Synchronization Delay to Location of Maximum
    % Correlation with Expected Preamble; when correlation is above a 
    % threshold, it updates DRx State to "DecodeHeader"
    [sd, sdr] = preambleDet(prm,rb,sdr);
elseif (sdr==prm.DRxStateRxDecodeHeader)
    % Prepare only the 1st 704 frame bits starting at the synchronization delay
    dfr(1:rfl) = rb(sd:(sd+rfl));
    dfd(1:dfl) = ddd(dfr,ft,prm,cmo,cmp,csc,csi,csp,cub);
    ch = ch+uint8(1);
    if (ch==1)
        % TODO: Lvl 3 Fine SFD Correlation: Find exact start of PLCP Header
        % Check CRC in PLCP Header
        [~, fc] = step(hcd, dfd(17:64));
        if fc
            % TODO: Actions when CRC check fails
        else
            % Get Payload Length from PLCP Header
            pl = bi2de(dfd(33:48));
        end
    elseif (ch==prm.NumHeaderFrames)
        fmh = true(1);
        % TODO: Process other elements of MAC Header
        % Get 802.11 Frame Number from MAC Header
        % Pass back all bits, even though only 1st 32 payload, the rest are used
        % for FCS check
        nrb = uint16(dfl);
        rbs(1:dfl) = dfd(1:dfl);
        f8n = bi2de(dfd(49:64));
        sdr = prm.DRxStateRxGetPayload;
    end
elseif (sdr==prm.DRxStateRxGetPayload)
    dfr(1:rfl) = rb(sd:(sd+rfl));
    dfd(1:dfl) = ddd(dfr,ft,prm,cmo,cmp,csc,csi,csp,cub);
    % Store Payload Bits in rbs and update bit count nrb
    nrb = uint16(dfl);
    rbs(1:dfl) = dfd(1:dfl);
    % Update Payload Frame Count
    cp = cp+uint8(1);
    if (cp==prm.NumPayloadFrames)
        sdr = prm.DRxStateRxGetPayloadFCS;
    end
elseif (sdr==prm.DRxStateRxGetPayloadFCS)
    dfr(1:rfl) = rb(sd:(sd+rfl));
    dfd(1:dfl) = ddd(dfr,ft,prm,cmo,cmp,csc,csi,csp,cub);
    % Store Payload Bits in rbs and update bit count nrb
    nrb = uint16(dfl-prm.NumFCSBits);
    % Pass back all bits, even though only 1st 32 payload, the rest are used
    % for FCS check
    rbs(1:dfl) = dfd(1:dfl);
    cpf = cpf+uint8(1);
    if (cpf==prm.NumPayloadFCSFrames)
        sdr = prm.DRxStateRxSearchPreamble;
        fpf = true(1);
    end 
end % End IF DS
end % End Function DRX_2RECEIVEACK

function sdr = drx_3WaitDIFS(sdr)


end % End Function DRX_3WAITDIFS
