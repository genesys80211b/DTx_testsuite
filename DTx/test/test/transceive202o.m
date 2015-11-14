function [dr,ns] = transceive202o(d2s,ft)
persistent hrx htx; 
dr = zeros(1408,1);
ns = uint32(0);
if isempty(htx)
    htx = comm.SDRuTransmitter('CenterFrequency',1.85e9,'Gain',25, ...
        'InterpolationFactor',500,'IPAddress','192.168.20.2', ...
        'LocalOscillatorOffset',0);
end
if isempty(hrx)
    hrx = comm.SDRuReceiver('CenterFrequency',1.85e9, ...
        'DecimationFactor',500,'FrameLength',1408,'Gain',35, ...
        'IPAddress','192.168.20.2','OutputDataType','double', ...
        'SampleRate',2e5);
end
if (ft) 
    release(hrx);
    release(htx);
else
    if ~isempty(htx)
        step(htx,d2s);
    end
    if ~isempty(hrx)
        while (ns < uint32(1))
            [dr,ns] = step(hrx); 
        end
    end    
end
return;
end