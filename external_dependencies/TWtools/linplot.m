function [A p] = linplot(a,b,alpha)
if nargin<3
    alpha = 1;
end
a(isnan(b)) = []; b(isnan(b)) = [];

[r p] = corr(a,b,'Type','Spearman');
if p<alpha
    [yCalc ba Rsq] = linregress(a,b);
    %     [b1 stats] = robustfit(a,b)
    hold on; 
    A = plot(a,yCalc,'k-','LineWidth',2)
else
    A = gobjects(1);
end

