function [dal,tim] = test202o()
dal = [];
din = complex(zeros(1408,1));
df0 = transceive202o_mex(din,false);
nit = 2000;
tim = zeros(nit,1);
for ii = 1:nit
    tic;
    df1 = transceive202o_mex(din,false);
    tim(ii) = toc;
    dal = [dal; df1];
end
df2 = transceive202o_mex(din,true);
end