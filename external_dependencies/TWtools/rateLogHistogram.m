function b = rateLogHistogram(data,edges,duration)
ncount = histcounts(log10(data),edges);
ncount = ncount/duration;
b = bar(edges(1:end-1),ncount,1);