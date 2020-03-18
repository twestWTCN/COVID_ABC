function [normV] = normaliseV(vector)
% normalise
vmin = min(vector'); vmax = max(vector'); xc = size(vector);
if size(vector,1)>1
    vector = num2cell(vector,2);
    A = @(x,y) (x-vmin(y)) / (vmax(y) - vmin(y));
    normV = cellfun(A, vector',{1,2},'UniformOutput',0);
    normV = reshape(cell2mat(normV),[],xc(1))';
else
    normV = (vector-mean(vector))/(std(vector));
end