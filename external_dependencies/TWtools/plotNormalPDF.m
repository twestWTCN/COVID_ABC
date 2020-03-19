function pln = plotNormalPDF(xrange,mu,sig,ls,cmap)
p = normpdf(xrange,mu,sig);
pln = plot(xrange,p,ls,'color',cmap,'LineWidth',2);
hold on