function [dr,ns] = transceive202(d2s,cuc,cud,cug,cui,cul,cuo,cur,cus,cut)
% Function Arguments: 
% dr:  Data Received: Raw data taken from USRP Rx Buffer
% d2s: Data To Send: Raw data placed onto USRP Tx Buffer
% ft:  Flag Terminal: If true, specifies to release System objects
% ns:  Number of Samples: Length of Data Received, in raw samples
% prm: DBPSK Transceiver Parameter Structure
% Function Constants
% cuc: CONSTANT USRP Center Frequency (1.85 GHz)
% cud: CONSTANT USRP Decimation(Rx)/Interpolation(Tx) Rate (500)
% cug: CONSTANT USRP Rx Gain (35 dB)
% cui: CONSTANT USRP IPv4 Address for this node (DRx: 192.168.20.2)
% cul: CONSTANT USRP Local Oscillator Offset (0 Hz)
% cuo: CONSTANT USRP Output Data Type ('double')
% cur: CONSTANT USRP Sample Rate in Hertz (constant 200,000)
% cus: CONSTANT USRP Frame Lengthin Samples (constant 1408)
% cut: CONSTANT USRP Tx Gain (25 dB)

% Persistent Data: Maintained between function calls to TRANSCEIVE()
% hrx: Handle to Software-Defined Radio USRP Receiver System object
persistent hrx;
% htx: Handle to Software-Defined Radio USRP Transmitter System object
persistent htx; 
% Local data preallocation
dr = complex(zeros(cus,1));
ns = uint32(0);
% Initialize Persistent Data: Only on first call to TRANSCEIVE()
if isempty(hrx)
    hrx = comm.SDRuReceiver( ...
        'CenterFrequency',  cuc, ...
        'DecimationFactor', cud, ...
        'FrameLength',      cus, ...
        'Gain',             cug, ...
        'IPAddress',        cui, ...
        'OutputDataType',   cuo, ... 
        'SampleRate',       cur ...
        );
end
if isempty(htx)
    htx = comm.SDRuTransmitter( ...
        'CenterFrequency',      cuc, ...
        'Gain',                 cut, ...
        'InterpolationFactor',  cud, ...
        'IPAddress',            cui, ...
        'LocalOscillatorOffset',cul ...
        );
end % END IF ISEMPTY
% !!! START THREAD #0 !!!
% Send Data through USRP
step(htx, d2s);
% !!! STOP THREAD #0 !!!
% !!! START THREAD #1 !!!
while (ns < 1)
    % Receive Data through USRP
    [dr, ns] = step(hrx);
end % END WHILE NS<1
% !!! STOP THREAD #1 !!!
end % END FUNCTION TRANSCEIVE