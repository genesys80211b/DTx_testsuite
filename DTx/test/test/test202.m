function [dal,tim] = test202()
dal = [];
din = complex(zeros(1408,1));
df0 = transceive202(din,uint8(0));
nit = 2000;
tim = zeros(nit,1);
for ii = 1:nit
    tic;
    df1 = transceive202(din,uint8(1));
    dal = [dal; df1];
    tim(ii) = toc;
end
df2 = transceive202(din,uint8(2));
end