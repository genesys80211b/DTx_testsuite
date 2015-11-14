function dfe = smsrc(df,ft)
% SMSRC: Scrambles, Modulates, Spreads, and RCTFilters Input Data
% Function Arguments: 
% df:  This Data Frame: Input Data Bits to Transmit (length 64)
% dfe: This Data Frame Encoded: Output Data Samples after Scrambling, 
%   Modulation, Spreading & RCTF, to be put on USRP Tx buffer (length 1408)
% ft:  Flag Terminal: If true, specifies to release all System objects
% prm: DBPSK Transceiver Parameter Structure

% Persistent Data: Maintained between function calls to SMSRC()
% hm:  Handle to Modulation System object
persistent hm;
% hrt: Handle to Raised Cosine Transmit Filter (RCTF) System object
persistent hrt;
% hs:  Handle to Scrambling System object
persistent hs;
% Initialize Persistent Data: Only on first call to DDD()
if isempty(hm)
    hm = comm.DBPSKModulator('OutputDataType','double','PhaseRotation',0);
end % IF ISEMPTY(HM)
if isempty(hrt)
    hrt = comm.RaisedCosineTransmitFilter('FilterSpanInSymbols',8, ...
        'Gain',1,'OutputSamplesPerSymbol',2,'RolloffFactor',0.3, ...
        'Shape','Square root');
end % IF ISEMPTY(HRT)
if isempty(hs)
    hs = comm.Scrambler('CalculationBase',2,'InitialConditions', ...
        [0,0,0,0,0,0,0],'Polynomial',[1,0,0,0,1,0,0,1]);
end % IF ISEMPTY(HS)
% Local data preallocation
dfb = zeros(64,1); %#ok<PREALL>
dfe = complex(zeros(1408,1));
mtx = complex(zeros(11,64));
tmp = complex(zeros(704,1));
if ft
    % Release System objects: only on final call to DDD()
    release(hm);
    release(hrt);
    release(hs);
    %clear('hm','hrt','hs'); %Not supported for code generation
else
    % Scrambling
    dfb = step(hs,df);
    % Modulation
    dfb = step(hm,dfb);
    % Spreading 
    mtx(1:11,1:64) = [1;-1;1;1;-1;1;1;1;-1;-1;-1] * dfb(1:64).';
    tmp(1:704) = mtx(1:704);
    % Raised Cosine Transmit Filter (RCTF)
    dfe = step(hrt,tmp);
end % IF FT
end % FUNCTION DDD