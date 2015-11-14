function [dr,ns] = transceive(d2s,ft,prm,cip,cfl,csr)
% Function Arguments: 
% dr:  Data Received: Raw data taken from USRP Rx Buffer
% d2s: Data To Send: Raw data placed onto USRP Tx Buffer
% ft:  Flag Terminal: If true, specifies to release System objects
% ns:  Number of Samples: Length of Data Received, in raw samples
% prm: DBPSK Transceiver Parameter Structure
% Function Constants
% cip: CONSTANT IP Address for this node (either DTx=10.2 or DRx=20.2)
% cfl: CONSTANT Frame Length for USRP receiver (constant 1408 samples)
% csr: CONSTANT Sample Rate for receiver (constant 200kHz)
% Local data preallocation
dr = complex(zeros(cfl,1));
ns = uint32(zeros(1));

% !!! START THREAD #0 !!!
% Persistent Data: Maintained between function calls to TRANSCEIVE()
% hr: Handle to Software-Defined Radio USRP Receiver System object
persistent hr;
% Initialize Persistent Data: Only on first call to TRANSCEIVE()
if isempty(hr)
    hr = comm.SDRuReceiver( ...
        'CenterFrequency',  prm.USRPCenterFrequency, ...
        'DecimationFactor', prm.USRPDecimation, ...
        'FrameLength',      cfl, ...
        'Gain',             prm.USRPRxGain, ...
        'IPAddress',        cip, ...
        'OutputDataType',   'double', ... 
        'SampleRate',       csr ...
        );
end
if ft
    % Release System objects: only on final call to TRANSCEIVE()
    release(hr);
    %clear('hr'); %Not supported for code generation
else
    while (ns < 1)
        % Receive Data through USRP
        [dr, ns] = step(hr);
    end % WHILE NS<1
end % IF FT
% !!! STOP THREAD #0 !!!

% !!! START THREAD #1 !!!
% Persistent Data: Maintained between function calls to TRANSCEIVE()
% ht: Handle to Software-Defined Radio USRP Transmitter System object
persistent ht;
if isempty(ht)
    ht = comm.SDRuTransmitter( ...
        'CenterFrequency',      prm.USRPCenterFrequency, ...
        'Gain',                 prm.USRPTxGain, ...
        'InterpolationFactor',  prm.USRPInterpolation, ...
        'IPAddress',            cip, ...
        'LocalOscillatorOffset',prm.USRPLOOffset ...
        );
end
if ft
    % Release System objects: only on final call to TRANSCEIVE()
    release(ht);
    %clear('ht'); %Not supported for code generation
else
    % Send Data through USRP
    step(ht, d2s);
end % IF FT
% !!! STOP THREAD #1 !!!

end % FUNCTION TRANSCEIVE