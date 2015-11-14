function [xcm, xci] = xcorrfft(drb, SSS)

DRB=fft(drb,5631);
Cross_corr_FFT=ifft(conj(DRB).*SSS);
[xcm,xci]=max(abs(Cross_corr_FFT));
xci=8448-xci;