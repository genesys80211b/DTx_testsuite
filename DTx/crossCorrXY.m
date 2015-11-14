function f = crossCorrXY(a)
Hcorr = dsp.Crosscorrelator('Method','Fastest');
f= step(Hcorr,a,a);
end