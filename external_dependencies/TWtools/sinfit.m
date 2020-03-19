function [xq yq R2] = sinfit(x,y,xn,plotop)
x(isnan(y)) = []; x(isnan(x)) = [];
y(isnan(x)) = []; y(isnan(y)) = [];

% Eliminate outliers
olc = 2.5.*std(y);
x(y>olc) = []; y(y>olc) =[];

yu = max(y);
yl = min(y);
% yr = (yu-yl);                               % Range of ‘y’
yr = std(y);
yz = y-yu+(yr/2);
zx = x(yz .* circshift(yz,[0 1]) <= 0);     % Find zero-crossings
per = 2*mean(diff(zx));                     % Estimate period
ym = mean(y);                               % Estimate offset
fit = @(b,x)  b(1).*(sin(2*pi*x./b(2) + 2*pi/b(3))) + b(4);    % Function to fit

fcn = @(b) sum((fit(b,x) - y).^2);                              % Least-Squares cost function
options = optimset('MaxFunEvals',1e8);
option.TolX = 1e-05;
[s,fval,ef,tp] = fminsearchcon(fcn, [yr;  pi;  per;  ym],[0.5*yr; 2.*pi; -2.*pi; -50],[2.*yr; 2.*pi; pi; 10],[],[],[],options)       ;                % Minimise Least-Squares
% [s] = fminsearch(fcn, [yr;  pi;  per;  ym]); %

yfit = fit(s,x);
xq = linspace(min(x),max(x),xn);
yq = fit(s,xq);

if plotop == 1
    hold on
    plot(xq,yq, 'r')
    plot(x,y,'b',  xq,yq, 'r')
    grid
end
SSres = (y-yfit).^2;
SStot = (y-mean(y)).^2; % total sum of squares (variance)
R2 = sum(SSres)/sum(SStot);


