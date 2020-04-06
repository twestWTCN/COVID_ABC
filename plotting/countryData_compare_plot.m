cntrlist = {'US','Italy','China','Japan','United Kingdom'};

i = 0;
for cntry = cntrlist
    i = i + 1;
    R.data.srcCountry = cntry{1};
    R.out.tag = ['MC_' cntry{1}];
    
    % Specify data sources
    R.data.source = 'CSSEGIS'; % Real Data
    % R.data.source = 'simulated'; % Real Data
    
    % Get Data, now links to github database;
    R = getData(R);
    
    % Plot Data
    a(i) = simpleSEIRTS_plotter({R.data.feat_emp},{{NaN(3,1)}},R.data.feat_xscale,R)
end

for i = 1:3
    subplot(1,3,i)
    legend(cntrlist)
end