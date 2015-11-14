function kplot(varargin)
nbars = (nargin - 1);
xl    = varargin{1};
mu    = zeros(nbars,1);
sig   = zeros(nbars,1);
for ii = 1:nbars
    data = 1e3*varargin{ii+1};
    mu(ii) = mean(data);
    sig(ii) = std(data);
end
bar(mu);
hold on;
errorbar(mu,sig);
if isnumeric(xl)
    set(gca,'XTickLabel',cellstr(num2str(xl(:))));
elseif ischar(xl)
    set(gca,'XTickLabel',cellstr(xl));
elseif iscell(xl)
    set(gca,'XTickLabel',xl);
end
xlabel('Frequency Resolution (Hz)');
ylabel('Time for RFFE Block (ms)');
title('RFFE Block Timing - (1) Interpreted MATLAB');
legend('Mean (\mu)','Std Dev (\sigma)');
return;
end % FUNCTION KPLOT