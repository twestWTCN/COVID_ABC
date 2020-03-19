function sem = nansem(x)
% standard error of the mean (ignoring NaNs)
sem = nanstd(x)./sqrt(sum(~isnan(sum(x,1))));