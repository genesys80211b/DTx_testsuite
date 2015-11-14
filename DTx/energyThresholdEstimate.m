function [ energyThreshold ] = energyThresholdEstimate(usrpFrameLength, txGain, rxGain, centerFreqTx, centerFreqRx, intFactor, decFactor)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% aip: IP Address for USRP attached to this machine as a 3-Digit uint8
%      (as of 2/19/15, valid values for N210's in Lab are 102, 103, or 202)
aip = getipa();
% Function Handle to transceive() function for this IP Address
trx = eval(sprintf('@transceive%3d_mex',aip));
% ft:  Terminal Flag to release System objects
ft  = logical(false(1));
% db:  Blank Data: For putting on Transmit Buffer while in a Rx Major State
db  = complex(zeros(usrpFrameLength,1));

% Compute energy across 5 USRP packet lengths
for i= 1:7
    df = trx(db,ft,txGain,rxGain,centerFreqTx,centerFreqRx,intFactor,decFactor);
    E(i) = sum(abs(df).^2);
end

% Sort the energy values in ascending order.
% Drop the largest value to suppress the outlier energy value.
% Pick a threshold that's like 4 times the noise floor
E = sort(E);
energyThreshold = 4*E(end-2);

% Release the handles to Tx/Rx system object
trx(db,logical(true(1)),txGain,rxGain,centerFreqTx,centerFreqRx,intFactor,decFactor);


end