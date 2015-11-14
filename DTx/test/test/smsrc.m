function dfe = smsrc(df,ft,prm,cmo,cmp,crf,crg,cro,crr,crs,csc,csi,csp,cub)
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
    hm = comm.DBPSKModulator( ...
        'OutputDataType',       cmo,    ...     % 'double'
        'PhaseRotation',        cmp     ...     % 0
        );
end % IF ISEMPTY(HM)
if isempty(hrt)
    hrt = comm.RaisedCosineTransmitFilter( ...
        'FilterSpanInSymbols',  crf,    ...     % 8
        'Gain',                 crg,    ...     % 1
        'OutputSamplesPerSymbol', cro,  ...     % 2
        'RolloffFactor',        crr,    ...     % 0.3
        'Shape',                crs     ...     % 'Square root'
        );
end % IF ISEMPTY(HRT)
if isempty(hs)
    hs = comm.Scrambler( ...
        'CalculationBase',      csc,    ...     % 2
        'InitialConditions',    csi,    ...     % [0000000]
        'Polynomial',           csp     ...     % [10001001]
        );
end % IF ISEMPTY(HS)
% Local data preallocation
dfb = zeros(cub,1); %#ok<PREALL>
dfe = complex(zeros(prm.USRPFrameLength,1));
mtx = complex(zeros(prm.SpreadingRate,cub));
tmp = complex(zeros(prm.SpreadedFrameLength,1));
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
    mtx(1:prm.SpreadingRate,1:cub) = prm.SpreadingCode ...
        * dfb(1:cub).';
    tmp(1:prm.SpreadedFrameLength) = mtx(1:prm.SpreadedFrameLength);
    % Raised Cosine Transmit Filter (RCTF)
    dfe = step(hrt,tmp);
end % IF FT
end % FUNCTION DDD