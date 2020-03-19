function colgridplot(Z,R,Q,intres)
set(gcf,'color','w');
Xr = min(R):intres:max(R);
Xq = min(Q):intres:max(Q);
[X,Y] = meshgrid(Xr,Xq);
V = interp2(R,Q,Z,X,Y,'spline');
imagesc2(Xr,Xq,V)
set(gca,'XAxisLocation','bottom')
set(gca,'YDir','normal')
axis square
% c = colorbar;
