function [r,lags] = my_xcorr(x1,x2,lags)
% lags = -256:1:256;
for i = 1:numel(lags)
    rx = corrcoef(x1,circshift(x2,lags(i)));
    r(i) = rx(2);
end


