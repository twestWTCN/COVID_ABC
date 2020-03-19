function b = rateHistogram(data,edges,duration)
ncount = histcounts(data,edges);
ncount = ncount/duration;
b = bar(edges(1:end-1),ncount,1);