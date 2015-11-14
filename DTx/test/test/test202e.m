function [dal,tr] = test202e(cef,fum)
if nargin < 2
    fum = true;
    if nargin < 1
        cef = 8;
    end
end
dal = [];
din = complex(zeros(1408,1));
dou = complex(zeros(704,1));
transceive202_mex(din,false);
nit = 2000;
tr  = zeros(nit,1);
for ii = 1:nit
    df1 = transceive202_mex(din,false);
    if fum && (cef==1)
        tic; dou = rffe_mex1(df1,false,1,1408,cef);  tr(ii) = toc;
    elseif fum && (cef==2)
        tic; dou = rffe_mex2(df1,false,1,1408,cef); tr(ii) = toc;
    elseif fum && (cef==4)
        tic; dou = rffe_mex4(df1,false,1,1408,cef); tr(ii) = toc;
    elseif fum && (cef==8)
        tic; dou = rffe_mex8(df1,false,1,1408,cef); tr(ii) = toc;
    elseif fum && (cef==16)
        tic; dou = rffe_mex16(df1,false,1,1408,cef); tr(ii) = toc;
    end
    dal = [dal; dou];
end
transceive202_mex(din,true);
if fum && (cef==1.0)
    rffe_mex(df1,true,1,1408,cef);
    clear rffe_mex
elseif fum && (cef==2.0)
    rffe_mex2(df1,true,1,1408,cef);
    clear rffe_mex2
elseif fum && (cef==4.0)
    rffe_mex4(df1,true,1,1408,cef);
    clear rffe_mex4
elseif fum && (cef==8.0)
    rffe_mex8(df1,true,1,1408,cef);
    clear rffe_mex8
elseif fum && (cef==16.0)
    rffe_mex16(df1,true,1,1408,cef);
    clear rffe_mex16
else
    rffe(df1,true,1,1408,cef);
    clear rffe
end
clear transceive202_mex
end