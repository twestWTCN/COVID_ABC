function pln = plotKSPDF(xrange,xf,r,bwid,ls,cmap)
x1 = ksdensity(xf,r,'function','icdf','width',bwid);
[x1,f] = ksdensity(x1,xrange);
pln = plot(f,x1,ls,'color',cmap,'LineWidth',2);
hold on



