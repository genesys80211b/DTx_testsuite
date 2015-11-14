function [dal,tr] = test202d(cef)
if nargin < 1
    cef = 8;
end
dal = [];
din = complex(zeros(1408,1));
dou = complex(zeros(704,1));
transceive202(din,0);
nit = 2000;
tr  = zeros(nit,1);
for ii = 1:nit
    df1 = transceive202(din,1);
    tic;
    dou = rffe(df1,false,1,1408,cef);
    tr(ii) = toc;
    dal = [dal; dou];
end
transceive202(din,3);
rffe(df1,true,1,1408,cef);
clear transceive202 rffe
end