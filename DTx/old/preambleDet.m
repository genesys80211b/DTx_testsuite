function [fpd,sd] = preambleDet(rb)
% PREAMBLEDET: Finds Sync in Rx Buffer; returns Sync Delay & Updated State
% Function Arguments: 
% fpd: Flag Preamble Detected: If true, move to decode header state
% rb:  Receive Buffer: Twice Length of USRP frame for Preamble Det (2816 samples)
% sd:  Synchronization Delay: Sample Number in USRP frame that designates
%      the start of data for this frame; found through Preamble Detection

% Persistent Data
% fnf: Flag Next Frame: Set true if preamble likely to be contained within
%      the next USRP frame
persistent fnf;
% lsd: Last Sync Delay: Value of sd on the last clock cycle, for comparison
%persistent lsd;
% ssb: Synchronization Signal bits, for comparison w/demodulated data
persistent ssb;
% sss: Synchronization Signal samples, for comparison against post-RCRF data
persistent sss;
% thr: Threshold for Correlation in Preamble Detection
persistent thr;

% Local Data
cra = double(zeros(21,1));
crv = double(zeros(2));
dfd = complex(zeros(128,1));
% ia:  Iterator Alternate: An integer to iterate through sda array
ia  = uint16(0); %#ok<NASGU>
% im:  Index with Maximum Correlation: Identifies index of best synch delay
im  = uint16(0); %#ok<NASGU>
% mtx: Matrix of Spread Samples: Temporary variable used for Despreading
mtx = complex(zeros(11,128));
% sd:  Synchronization Delay: Sample Number in USRP frame that designates
%      the start of data for this frame; found through Preamble Detection
sd  = uint16(0);
% sda: Synch Delay Alternates: An array of neighboring candidates for sd
sda = uint16(zeros(21,1));
% xcd: Cross-correlated data
xcd = zeros(2815,1);
% xcl: Cross-correlated lags
xcl = zeros(2815,1);
% xcm: Maximum value in cross-correlated data
xcm = double(0.0); %#ok<NASGU>
% xci: Index of maximum lag in cross-correlated data
xci = double(0); %#ok<NASGU>

% Initialize Persistent Data: Only on first call to PREAMBLEDET()
if isempty(fnf),    fnf = logical(false(1));    end
%if isempty(lsd),    lsd = uint16(0);            end 
if (isempty(ssb) || isempty(sss))
    % sds: Saved Data Structure: Contains Information about Expected Preamble
    sds = coder.load('transceiverData.mat','ss','ds');
    ssb = sds.ds;
    sss = sds.ss;
end
if isempty(thr),    thr = double(0.3);          end

% Phase 1: Coarse complex cross-correlation (CCXC)
%          Use xcorr function to get coarse estimate of synch delay, sd
xcd(1:2815) = abs(xcorr(rb, ss));
[xcm, xci] = max(xcd);
xcm = xcm/(norm(rb,2)*norm(ss,2));
if (fnf || (xcm > thr))
    sd = uint16(xcl(xci)+1);
    if ((sd+1407)>2816)
        fnf = true;
    elseif (sd>0)
        fnf = false;
        % Set flag to say that Preamble detected, so proceed to next state
        fpd = logical(true(1));
        % Phase 2: Demodulated Bitstream Windowed Correlation (DBWC)
        % Despread 1st 128 bits starting at Index sd
        mtx(1:11,1:128) = reshape(rb(sd:(sd+1407)),11,128); 
        dfd(1:128) = (mtx.'*[1;-1;1;1;-1;1;1;1;-1;-1;-1]);
        % Demodulation
        dfd(1:128) = demodnp(dfd(1:128));
        if ~isequal(dfd(1:128), sss(1:128))
            % If demodulated sequence is not the same as scrambled Sync, 
            % perform a fine-tuned Correlation to find the index at
            % which data is closest to start of sequence & readjust sd
            sda(1:21) = (sd-10):(sd+10);
            for ia = 1:21
                if ((sda(ia)>0) && ((sda(ia)+1408)<=2816))
                    % Despread 1st 128 bits starting at Index sda(ia)
                    mtx(1:11,1:128) = reshape(rb(sda(ia):(sda(ia)+1407)),11,128); 
                    dfd(1:128) = (mtx.'*[1;-1;1;1;-1;1;1;1;-1;-1;-1]);
                    % Demodulate 1st 128 bits starting at Index sda(ia)
                    dfd(1:128) = demodnp(dfd(1:128));
                    crv(1:2,1:2) = real(corrcoef(dfd,sss));
                    cra(ia) = crv(2,1);
                end % IF SDV>0 & SDV<RBLEN
            end % FOR SDI=1:WINLEN
            [~,im] = max(cra);
            sd = sda(im);
        end % IF DFD~=SSS
    end % IF SD+SYNCLEN>FRAMELEN
end % IF XCM>THRESH
% Retain this synchronization delay in memory
%lsd = uint16(sd);
return;
end % FUNCTION PREAMBLEDET

function y = demodnp(x)
% DEMODNP: Non-persistent Demodulation
% x: 128x1 complex double: Modulated Data
% y: 128x1 real double: Demodulated Data
d = real(zeros(128,1));
y = real(ones(128,1));
d(1:128) = mod(diff([mod(angle(x(1))+pi,2*pi);angle(x(1:128))]),(2*pi));
y(d<(pi/2)|d>(3*pi/2))=0;
return;
end % FUNCTION DEMODNP