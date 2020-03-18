
            % Power
            cfg            = [];
            cfg.output     = 'powandcsd';
            cfg.method     = 'mtmfft';
            cfg.foilim     = R.FOI;
            cfg.taper = 'hanning';
            %         cfg.tapsmofrq  = 3;
            %         cfg.pad = 'nextpow2';
            cfg.keeptrials = 'no';
            freqPow    = ft_freqanalysis(cfg,FTdata.EpochedData);
            FTdata.freqPow = freqPow;
            
%             plot(FTdata.freqPow





function FTdata = spm2ft(Ds)
        FTdata.label = Ds.chanlabels;  % cell-array containing strings, Nchan X 1
        
        FTdata.fsample = Ds.fsample; % sampling frequency in Hz, single number
        [m n t] = size(Ds(:,:,:));
        B= squeeze(mat2cell(Ds(:,:,:), m, n, ones(1,t)))';
        FTdata.trial = B; % cell-array containing a data matrix for each trial (1 X Ntrial), each data matrix is    Nchan X Nsamples
        FTdata.time = repmat({repmat(Ds.time,size(Ds,1),1)},1,size(Ds,3));   % cell-array containing a time axis for each trial (1 X Ntrial), each time axis is a 1 X Nsamples vector
%         FTdata.trialinfo = repmat([subnames{sub} '_Rest1_' condName{cond}],1,1); % this field is optional, but can be used to store trial-specific information, such as condition numbers, reaction times, correct responses etc. The dimensionality is N x M
end