function st = dtx_MAC_Layer(st,frt)
% DTX_MAC_Layer Wait DIFS between rx of ACK and tx of next DATA frame
% persistent cd;
% persistent nd;
% if isempty(cd), cd = uint8(0); end
% if isempty(nd), nd = uint8(10); end
% cd = cd + uint8(1);
% if (cd>=nd)

%%%*********!!!!!Added 3rd June '15**********!!!!!
global usrpFrameLength DIFS cMin energyThreshold txGain rxGain aip ...
    centerFreqTx centerFreqRx intFactor decFactor energySamples

persistent k;
if isempty(k),    k = uint8(1);                 end


%Random Backoff time
if frt
    k=uint8(min(k+1,10));
else
    k=uint8(1);
end
trb = randi((2^(k))-1)*cMin;


% hft: Function Handle to transceive() function for this IP Address
trx = eval(sprintf('@transceive%3d_mex',aip));

if (st==uint8(111))
    
    %Frame Ready; Start Timer for DIFS
%     fprintf('Entering DIFS state..\n')
    tic; t = 0;
    
    %Wait for DIFS
    while t < DIFS
        t=toc;
        % ft:  Terminal Flag to release System objects
        ft  = logical(false(1));
        % db:  Blank Data: For putting on Transmit Buffer while in a Rx Major State
        db  = complex(zeros(usrpFrameLength,1));
        df = trx(db,ft,txGain,rxGain,centerFreqTx,centerFreqRx,intFactor,decFactor);
        if (sum(abs(df).^2)> energyThreshold)
            fprintf('Energy detected in DIFS state, Backing off!!\n')
            tic;
        end
    end
%     fprintf('...DIFS ends.\n')
end

%Reset Timer for Random Backoff
% fprintf('Entering Random Backoff state..\n')
tic; t = 0;

%Random Backoff
ft=logical(false(1));
tstop_rb = 0; %Backoff epoch
while t < trb
    t=toc;
    % db:  Blank Data: For putting on Transmit Buffer while in a Rx Major State
    db  = complex(zeros(usrpFrameLength,1));
    df = trx(db,ft,txGain,rxGain,centerFreqTx,centerFreqRx,intFactor,decFactor);
    % energySamples = [energySamples sum(abs(df).^2)];
    if (sum(abs(df).^2)> energyThreshold)
        fprintf('Energy detected in Random Backoff state, Backing off!!\n')
        tstop_rb=toc;
        tic; t=0;
        trb=trb-tstop_rb;
    end
end
% fprintf('...Random Backoff ends.\n')


st = uint8(121); %prm.DTxStateTransmitHeader;
%     cd = uint8(0);
% end % END IF CD==DIFS
end