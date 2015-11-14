function drx_v34()
% Designated Receiver Parameter Structure
prm = init_v34();
% CONSTANTS
% cuc: CONSTANT USRP Center Frequency (1.85 GHz)
cuc = double(1.85e9);
% cud: CONSTANT USRP Decimation(Rx)/Interpolation(Tx) Rate (500)
cud = double(500);
% cug: CONSTANT USRP Rx Gain (35 dB)
cug = double(35);
% cui: CONSTANT USRP IPv4 Address for this node (DRx: 192.168.20.2)
cui = '192.168.20.2';
% cul: CONSTANT USRP Local Oscillator Offset (0 Hz)
cul = double(0);
% cuo: CONSTANT USRP Output Data Type ('double')
cuo = 'double';
% cur: CONSTANT USRP Sample Rate in Hertz (constant 200,000)
cur = double(200000);
% cus: CONSTANT USRP Frame Length in Samples (constant 1408)
cus = double(1408);
% cut: CONSTANT USRP Tx Gain (25 dB)
cut = double(25);
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
% fpf: Flag Full Payload Found: Init false, set true when full payload rx'd
fpf = logical(false(1));
% ft: Terminal Flag to release System objects
ft  = logical(false(1));
% hfd: Handle to MAC FCS Detector
hfd = comm.CRCDetector( ...
    'ChecksumsPerFrame', prm.CRCChecksumsPerFrame, ...
    'FinalXOR',          prm.CRCFinalXOR, ...
    'InitialConditions', prm.CRCInitialConditions, ...
    'Polynomial',        prm.FCSPolynomial ...
    ); 
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
rbs = zeros(prm.NumUSRPFrameBits,1);
% rfs: Recovered MPDU for one 802.11b Frame: Combined from rbs's (16,192 bits)
rfs = zeros(prm.NumUSRPFrameBits,1);
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
rid = uint8(zeros(ri1,ri2,ri3));
% sdr: State for Designated Receiver (DRx): 3 Digits, 1st Digit is 2 for DRx
% 2nd Digit is 1 for Receive Data, 2 for Transmit ACK, or 3 for Wait DIFS
sdr = uint8(prm.DRxStateStart);
% sm: DRx Major State: Most Significant 2 Digits of Full DRx State
sm  = uint8(0);
% to: Timeout: The #iterations of the main loop to wait before exiting.
to  = uint32(1000);

% v: Verbose Mode: Displays additional text describing DRx actions
v   = logical(true(1));
while ~fe
    sm = sdr/uint8(10);
    if (sm==prm.DRxStateRxDATA)
        df = transceive202_mex(db,cuc,cud,cug,cui,cul,cuo,cur,cus,cut);
        [fpf,nub,rbs,sdr] = drx_1ReceiveData(df,prm,sdr);
        if (nub > 0)
            rfs((nmb+1):(nmb+nub)) = rbs(1:nub);
            % Increase total MPDU bit count by this # of recovered USRP bits
            nmb = nmb + uint64(nub);
            if fpf
                % Check FCS in MAC Header
                [~, ff] = step(hfd, rfs);
                if ff
                    % TODO: Actions when MAC FCS check fails
                end
                % On first fully received 802.11b frame payload, get image size
                if (n8f < 1) && (tnb==uint64(0))
                    [rid,ri1,ri2,ri3] = partialbi2im(rfs,1);
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
                sdr = prm.DRxStateRxSearchPreamble; %prm.DRxTransmitACK;
                % Clear all persistent Data in function drx_1ReceiveData()
                clear('drx_1ReceiveData');
                if (nib == ril) % If #image bits equals expected image length, set flag to exit
                    fe = logical(true(1));
                end
            end % IF FPF

        end % IF NRB>0
            
    elseif (sm==prm.DRxStateTransmitACK)
        [d2s,sdr] = drx_2TransmitACK(n8f,sdr);
        transceive202_mex(db,prm,cir,cur,cus);
    elseif (sm==prm.DRxStateDIFS)
        drxState = drx_3WaitDIFS(drxState);
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

function [fmh,fpf,nrb,rbs,sdr] = drx_1ReceiveData(df,prm,sdr)
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
    if fs
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
end % End Function DRX_1RECEIVEDATA

function [d2s,sdr] = drx_2TransmitACK(ft,n8f,sdr)
% DRX_2TRANSMITACK: Transmits ACK 802.11b frame in 4 consecutive USRP frames
% Function Arguments: 
% d2s: Data To Send, frame data in 1408 samples to put on USRP Tx buffer
% ft:  Flag Terminal: If true, specifies to release System objects
% n8f: 802.11b Frame Number, for ACK header info
% sdr: Designated Receiver (DRx) State, a 3-digit enumeration

% Persistent Data: Maintained between function calls to drx_1ReceiveData
% ca: ACK Header Count: Counts #USRP frames that have ACK header info (0-4)
persistent ca;
% hcg: Handle to PHY PLCP CRC Generator
persistent hcg;
% hfg: Handle to MAC FCS Generator
persistent hfg;
% CONSTANTS: For Construction of System objects
cmo = 'double';
cmp = double(0.0);
crf = double(8);
crg = double(1.0);
cro = double(2);
crr = double(0.3);
crs = 'Square root';
csc = double(2);
csi = [0,0,0,0,0,0,0];
csp = [1,0,0,0,1,0,0,1];
% cub: USRP Frame Length in Bits: Constant 64
cub = double(64);
% Initialize Persistent Data: Only on first call to drx_1ReceiveData
if isempty(ca)
    ca  = uint8(0);
end
if isempty(hcg)
    hcg = comm.CRCGenerator( ...
        'ChecksumsPerFrame', prm.CRCChecksumsPerFrame, ...
        'FinalXOR',          prm.CRCFinalXOR, ...
        'InitialConditions', prm.CRCInitialConditions, ...
        'Polynomial',        prm.CRCPolynomial ...
        ); 
end
if isempty(hfg)
    hfg = comm.CRCGenerator( ...
        'ChecksumsPerFrame', prm.CRCChecksumsPerFrame, ...
        'FinalXOR',          prm.CRCFinalXOR, ...
        'InitialConditions', prm.CRCInitialConditions, ...
        'Polynomial',        prm.FCSPolynomial ...
        ); 
end
% Local data preallocation
dfb = complex(zeros(prm.NumUSRPFrameBits,1));
dfe = complex(zeros(prm.USRPFrameLength,1));
if (ft)
    release(hcg);
    % Release System objects created by SMSRC() function
    dfe(1:prm.USRPFrameLength) = smsrc(df,ft,prm,cmo,cmp,crf,crg,cro,crr,crs,csc,csi,csp,cub);
    % Clear persistent data within SMSRC() function
    clear('smsrc');
else
    if (ca==0)
        % Send 1st half of SYNC signal
        dfb(1:prm.NumUSRPFrameBits) = prm.SYNC(1:prm.NumUSRPFrameBits);
    elseif (ca==1)
        % Send 2nd half of SYNC signal
        dfb(1:prm.NumUSRPFrameBits) = prm.SYNC(prm.NumUSRPFrameBits+1:2*prm.NumUSRPFrameBits);
    elseif (ca==2)
        % Send PHY SFD & PLCP Header
        dfb( 1:16) = prm.SFD(1:16);
        dfb(17:24) = prm.SIGNAL(1:8);
        dfb(25:32) = prm.SERVICE(1:8);
        dfb(33:48) = de2bi(64, 16)'; % LENGTH=MACHeader (64)+MAC Frame Body(0)+MAC FCS (32)
        % Append 16-bit CRC to 32-bit PLCP Header: result is 48 bits
        dfb(17:64) = step(hcg, dfb(17:48));
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
end % End Function DRX_2TRANSMITACK

function sdr = drx_3WaitDIFS(sdr)


end % End Function DRX_3WAITDIFS
