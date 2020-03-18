function R = getData(R)

switch R.data.source
    case 'simulated'
        load([R.root '\data\simulated_data\simdata.mat'])
        dat = xdata(R.obs.datachan,:);
        N = size(dat,2);
        t = [0:N-1].*R.IntP.dt;
        
    case 'CSSEGIS'
        datapath = [R.root '\data\CSSEGIS\'];
        
        % TimeScale
        Te = importCSSEGISTimeData([datapath 'Dead.csv']);
        Te_dt = mode(days(diff(table2array(Te(1,5:end)))));
        N = numel(table2array(Te(1,5:end)));
        t = [0:N-1].*Te_dt; % time vector (days)
        
        % Infected
        I = importCSSEGISdata([datapath 'Confirmed.csv']);
        I = I(strcmp(I.CountryRegion, R.data.srcCountry),5:end);
        I = sum(table2array(I),1);
        
        % Recovered
        Re = importCSSEGISdata([datapath 'Recovered.csv']);
        Re = Re(strcmp(Re.CountryRegion, R.data.srcCountry),5:end);
        Re = sum(table2array(Re),1);
        
        % Dead
        D = importCSSEGISdata([datapath 'Dead.csv']);
        D = D(strcmp(D.CountryRegion, R.data.srcCountry),5:end);
        D = sum(table2array(D),1);
        
        % Format for ABC
        dat(1,:) = I;
        dat(2,:) = Re;
        dat(3,:) = D;
        
end

% Interpolate to sim scale
R.data.feat_xscale = t;
xdata = interp1(R.data.feat_xscale,dat',R.tvec,'linear',NaN)';
R.data.feat_emp{1} = xdata;
R.data.feat_xscale = R.tvec;

