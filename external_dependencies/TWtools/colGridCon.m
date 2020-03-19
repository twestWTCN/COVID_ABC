function colGridCon(X,Y,Z,nC)
h = imagesc(X,Y,Z);
set(h, 'AlphaData', ~isnan(Z))
hold on
[C h] = contour(X,Y,Z,nC);
h.LineWidth = 1
h.LineColor = [0 0 0]

CL =clabel(C,h,'FontWeight','bold')


set(gca,'XAxisLocation','bottom')
set(gca,'YDir','normal')
axis square
% colorbar ;% caxis([3.5 5])
