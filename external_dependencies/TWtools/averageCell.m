function avStruc = averageCell(av)
a = [];
for i = 1:size(av,2)
    a(:,i) = spm_vec(av{i});
end

avStruc = spm_unvec(mean(a,2),av{1});