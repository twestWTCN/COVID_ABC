function FTdata = spm2ft_conservetrials(Ds)
        FTdata.label = Ds.channels;  % cell-array containing strings, Nchan X 1
        
        FTdata.fsample = Ds.Fsample; % sampling frequency in Hz, single number
        B = reshape(Ds.data(:,:,:),size(Ds.data,1),size(Ds.data,2),size(Ds.data,3));
        for i=1:size(B,3)
            C{i} = squeeze(B(:,:,i));
            T{i} = linspace(0,length(C{i})/Ds.Fsample,length(C{1}));
        end
        FTdata.trial = B; % cell-array containing a data matrix for each trial (1 X Ntrial), each data matrix is    Nchan X Nsamples
        FTdata.time = T;   % cell-array containing a time axis for each trial (1 X Ntrial), each time axis is a 1 X Nsamples vector
%         FTdata.trialinfo = repmat([subnames{sub} '_Rest1_' condName{cond}],1,1); % this field is optional, but can be used to store trial-specific information, such as condition numbers, reaction times, correct responses etc. The dimensionality is N x M
end