function [dal,tim] = test202c()
dal = [];
din = complex(zeros(1408,1));
df0 = transceive202_mex(din,false);
rf0 = rffe(
nit = 2000;
tim = zeros(nit,1);
for ii = 1:nit
    tic;
    df1 = transceive202_mex(din,false);
    dal = [dal; df1];
    tim(ii) = toc;
end
df2 = transceive202_mex(din,true);
end