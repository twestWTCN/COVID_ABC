function pStar = benHochFWER(p,fdr)
% Computes Benjammini Hochberg Family Wise Error Rate using specfied false
% discovery rate
[sPv sInd] = sort(p(:));
rank = 1:numel(p);
sRank = rank(sInd);
pStar = (p(:)')<(sRank./numel(p))*fdr;
pStar = reshape(pStar,size(p,1),size(p,2))