function dfr = rffe(df,ft,cas,cau,cef)
% RFFE: Radio Freq Front End: AGC's, Freq Compensates, & RCRF's Input Data
% Function Arguments: 
% cas: Constant AGC Step Size (fixed at 1.0)
% cau: Constant AGC Update Rate (fixed at 1408)
% cef: Constant Frequency Offset Estimation Freq Resolution (~4.0 Hz)
% df:  This Data Frame: Raw data taken from USRP Rx Buffer (length 1408)
% dfr: This Data Frame Recovered: Data after AGC, FOC & RCRF (length 704)
% ft:  Flag Terminal: If true, specifies to release all System objects

% ha: Handle to Automatic Gain Control (AGC) System object
persistent ha;
% he: Handle to Coarse Frequency Estimator (CFE) System object
persistent he;
% hf: Handle to Frequency Offset Compensator (FOC) System object
persistent hf;
% hrr: Handle to Raised Cosine Receive Filter (RCRF) System object
persistent hrr;
% Initialize Persistent Data: Only on first call to RFFE()
if isempty(ha)
    ha = comm.AGC('DetectorMethod','Rectifier','LoopMethod','Logarithmic', ...
        'MaximumGain',30,'StepSize',cas,'UpdatePeriod',cau);
end % END IF ISEMPTY(HA)
if isempty(he)
    he = comm.PSKCoarseFrequencyEstimator('Algorithm','FFT-based', ...
        'FrequencyResolution',cef,'ModulationOrder',2,'SampleRate',1e5);         
end % END IF ISEMPTY(HC)
if isempty(hf)
    hf = comm.PhaseFrequencyOffset('PhaseOffset',0, ...
        'FrequencyOffsetSource','Input port','SampleRate',1e5);
end % END IF ISEMPTY(HF)
if isempty(hrr)
    hrr = comm.RaisedCosineReceiveFilter('DecimationFactor',2,...
        'DecimationOffset',0,'FilterSpanInSymbols',8,'Gain',1,...
        'InputSamplesPerSymbol',2,'RolloffFactor',0.3,'Shape','Square root');
end % IF ISEMPTY(HRR)
% Local data preallocation
dfr = complex(zeros(704,1));
ofs = double(0.0); %#ok<NASGU>
tmp = complex(zeros(1408,1)); %#ok<NASGU>
if ft
    % Release System objects: only on final call to RFFE()
    release(ha);
    release(he);
    release(hf);
    release(hrr);
    %clear('ha','he','hf','hrr'); %Not supported for code generation
else
    % Automatic Gain Control (AGC)
    tmp = step(ha,df);
    % Coarse Frequency Offset Estimation (CFE)
    ofs = step(he,tmp);
    % Frequency Offset Compensation (FOC)
    tmp = step(hf,tmp,-ofs);
    % Raised Cosine Receive Filtration (RCRF)
    dfr = step(hrr,tmp);
end % IF FT
end % FUNCTION RFFE