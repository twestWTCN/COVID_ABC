function FTdata = spm2ft_concat(Ds)
        FTdata.label = Ds.chanlabels;  % cell-array containing strings, Nchan X 1
        
        FTdata.fsample = Ds.fsample; % sampling frequency in Hz, single number
        B = {reshape(Ds(:,:,:),size(Ds,1),size(Ds,2)*size(Ds,3))};
        FTdata.trial = B; % cell-array containing a data matrix for each trial (1 X Ntrial), each data matrix is    Nchan X Nsamples
        FTdata.time = {linspace(0,length(B{1})/Ds.fsample,length(B{1}))};   % cell-array containing a time axis for each trial (1 X Ntrial), each time axis is a 1 X Nsamples vector
%         FTdata.trialinfo = repmat([subnames{sub} '_Rest1_' condName{cond}],1,1); % this field is optional, but can be used to store trial-specific information, such as condition numbers, reaction times, correct responses etc. The dimensionality is N x M
end