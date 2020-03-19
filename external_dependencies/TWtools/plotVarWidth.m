function hg = plotVarWidth(x,y,S,cmap,resFac,ip)
if nargin<6
    ip = 0;
end
% x = 25:.1:200;
% y = sin(x);
% S = logspace(-1,2,size(y,2))./10;
% resFac = 1.5;
% Resample (for smoothness)
cOrg =  1:numel(x); cRes = linspace(cOrg(1),cOrg(end),numel(x).*resFac);
xRes = interp1(cOrg,x,cRes,'pchip');
yRes = interp1(cOrg,y,cRes,'pchip');
SRes = interp1(cOrg,S,cRes,'pchip');

ind = 1:numel(xRes);
indT = [ind(2:end) NaN ];
IND = [ind;indT];
IND(:,end) = []; % remove last segment
for i = 1:size(IND,2)
    g(i) = plot(xRes(IND(:,i)),yRes(IND(:,i)),'color',cmap,'LineWidth',SRes(IND(2,i)));
    hold on
end
hg = hggroup;
set(g(:),'Parent',hg);
    ip = ip+1;
if ip<2
    plotVarWidth(x,y,S,cmap,resFac+(ip*0.2),ip)
end

% widthrange = maxwidth-minwidth;
% width = ((c ./ max(c))*widthrange) + minwidth;
% h = surface(...
%   'XData',[x(:) x(:)],...
%   'YData',[y(:)-(width/2) y(:)+(width/2)],...
%   'ZData',zeros(length(x(:)),2),...
%   'CData',[c(:) c(:)],...
%   'FaceColor','interp',...
%   'EdgeColor','interp',...
%   'Marker','none');


% scatter(CMDscaled{multiStart}(1:3:end,1),CMDscaled{multiStart}(1:3:end,3),(15.^szvec)*250
