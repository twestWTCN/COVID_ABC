function [diagInd diagData] = getDiagInd(Z)
diagInd = 1:size(Z,1)+1:numel(Z);
diagData = Z(diagInd);