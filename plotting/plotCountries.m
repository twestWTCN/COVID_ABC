close all
k = 0;
cntrlist = {'US','Italy','China','United Kingdom'}; %

for cntry = cntrlist
    k = k+1;
    figure
    R.data.srcCountry = cntry{1};
    R.out.tag = ['MC_' cntry{1}];
    
    R = getData(R);
    
    %% Plot the modComp results
    R.modcomp.modN = modlist; %
    R.modcompplot.NPDsel = {'SEIQRDP_fixedE0','SEIQRDP_varE0','SEIQRDP_varE0_slowCure','SEIQRDP_varE0_fastCure_lowMortal'}; % selection of models to plot (if you want a subset)
    R.plot.confint = 'yes';
    cmap = linspecer(numel(R.modcomp.modN));
    cmap = cmap(end:-1:1,:);
    plotModComp_210320(R,cmap,k)
    
end


    
    R.data.srcCountry = cntrlist{4};
    R.out.tag = ['MC_' cntry{1}];
    
    % Specify data sources
    R.data.source = 'CSSEGIS'; % Real Data
    % R.data.source = 'simulated'; % Real Data
    
    % Get Data, now links to github database;
    R = getData(R);
R.data.day0 + days((1200)*R.IntP.dt)