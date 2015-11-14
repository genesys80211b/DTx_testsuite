function [fpd, sd] = preambleDet(prm,rb)
% PREAMBLEDET: Finds Sync in Rx Buffer; returns Sync Delay & Updated State
% Function Arguments: 
% fpd: Flag Preamble Detected: If true, move to decode header state
% prm: DBPSK Transceiver Parameter Structure
% rb:  Receive Buffer: Twice Length of USRP frame for Preamble Det (2816 samples)
% sd:  Synchronization Delay: Sample Number in USRP frame that designates
%      the start of data for this frame; found through Preamble Detection

% Persistent Data
% fnf: Flag Next Frame: Set true if preamble likely to be contained within
%      the next USRP frame
persistent fnf;
% lsd: Last Sync Delay: Value of sd on the last clock cycle, for comparison
persistent lsd;
% ss:  Synchronization Signal, for comparison against post-RCRF data
persistent ss;
% sss: Scrambled Synchronization Signal, compare w/demodulated data
persistent sss;
% Local Data
cra = double(zeros(prm.PreambleDetDBWCWindow*2+1,1));
crv = double(zeros(2));
dfd = complex(zeros(prm.NumSYNCBits,1));
mtx = complex(zeros(prm.SpreadingRate,prm.NumSYNCBits));
sd  = uint16(0);
sda = uint16(zeros(prm.PreambleDetDBWCWindow*2+1,1));
sdi = uint16(0); %#ok<NASGU>
sdm = uint16(0); %#ok<NASGU>
% sds: Saved Data Structure: Contains Information about Expected Preamble
sds = coder.load('transceiverData.mat','ss','ds');
% xcd: Cross-correlated data
xcd = zeros(prm.ReceiveBufferLength-1,1);
% xcl: Cross-correlated lags
xcl = zeros(prm.ReceiveBufferLength-1,1);
% xcm: Maximum value in cross-correlated data
xcm = double(0.0); %#ok<NASGU>
% xci: Index of maximum lag in cross-correlated data
xci = double(0); %#ok<NASGU>
% Initialize Persistent Data: Only on first call to PREAMBLEDET()
if isempty(fnf),    fnf = logical(false(1));    end
if isempty(lsd),    lsd = uint16(0);            end %#ok<NASGU>
if isempty(ss),     ss  = sds.ds;               end
if isempty(sss),    sss = sds.ss;               end

% Phase 1: Coarse complex cross-correlation (CCXC)
xcd(1:prm.ReceiveBufferLength-1) = abs(xcorr(rb, ss));
[xcm, xci] = max(xcd);
xcm = xcm / (norm(rb,2)*norm(ss,2));
if (fnf || (xcm > prm.PreambleDetCorrThreshold))
    sd = uint16(xcl(xci)+1);
    if ((sd+prm.NumSYNCSpreadBits)>prm.ReceiveBufferLength)
        fnf = true;
    elseif (sd>0)
        fnf = false;
        % Set flag to say that Preamble detected, so proceed to next state
        fpd = logical(true(1));
        % Phase 2: Demodulated Bitstream Windowed Correlation (DBWC)
        % Despreading 
        mtx(1:prm.SpreadingRate,1:prm.NumUSRPFrameBits) = reshape( ...
            rb(sd:(sd+prm.NumSYNCSpreadBits)), prm.SpreadingRate, ...
            prm.NumSYNCBits); 
        dfd(1:prm.NumSYNCBits) = (mtx.' * prm.SpreadingCode);
        % Demodulation
        dfd(1:prm.NumSYNCBits) = demodnp(dfd(1:prm.NumSYNCBits));
        if ~isequal(dfd(1:prm.NumSYNCBits), sss(1:prm.NumSYNCBits))
            % If demodulated sequence is not the same as scrambled Sync, 
            % perform a fine-tuned Correlation to find the index at
            % which data is closest to start of sequence & readjust sd
            sda(1:(prm.PreambleDetDBWCWindow*2+1)) = (sd- ...
                prm.PreambleDetDBWCWindow):(sd+prm.PreambleDetDBWCWindow);
            for sdi = 1:(2*prm.PreambleDetDBWCWindow+1)
                if (sda(sdi)>0) && ((sda(sdi)+prm.NumSYNCSpreadBits)<=prm.ReceiveBufferLength)
                    % Despreading
                    mtx(1:prm.SpreadingRate,1:prm.NumUSRPFrameBits) = reshape( ...
                        rb(sda(sdi):(sda(sdi)+prm.NumSYNCSpreadBits)), ...
                        prm.SpreadingRate, prm.NumSYNCBits); 
                    dfd(1:prm.NumSYNCBits) = (mtx.' * prm.SpreadingCode);
                    % Demodulation
                    dfd(1:prm.NumSYNCBits) = demodnp(dfd(1:prm.NumSYNCBits));
                    crv(1:2,1:2) = real(corrcoef(dfd,sss));
                    cra(sdi) = crv(2,1);
                end % IF SDV>0 & SDV<RBLEN
            end % FOR SDI=1:WINLEN
            [~,sdm] = max(cra);
            sd = sda(sdm);
        end % IF DFD~=SSS
    end % IF SD+SYNCLEN>FRAMELEN
end % IF XCM>THRESH
% Retain this synchronization delay in memory
lsd = uint16(sd);
end % FUNCTION PREAMBLEDET