function [b r2] = rateLogNScatter(data,edges,duration,cmap)
% Both data and edges should be in logspace!

ncount = histcounts(data,edges);
ncount = ncount/duration;
b(1) = scatter(edges(1:end-1),ncount,'filled'); hold on
b(1).CData = cmap;

[f G] = fit(edges(1:end-1)',ncount','gauss1');
r2 = G.rsquare;
ci = confint(f);
x = linspace(edges(1),edges(end),128);
b(2) = plot(x,f(x),'k-') ;
b(2).Color = cmap;
for i = 1:2
    f.a1 = ci(i,1);
    f.b1 = ci(i,2);
    f.c1 = ci(i,3);
    b(2+i) = plot(x,f(x),'k--') ;
    b(2+i).Color = cmap;
end
