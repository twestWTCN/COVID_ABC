function R = getData(R)

switch R.data.source
    case 'simulated'
        load([R.root '\data\simulated_data\simdata.mat'])
        dat = xdata(R.obs.datachan,:);
        N = size(dat,2);
        t = [0:N-1].*R.IntP.dt;
        R.data.day0 = date;
    case 'CSSEGIS'
        datapath = [R.root '\data\CSSEGIS\'];
        
        % TimeScale
        Te = importCSSEGISTimeData([datapath 'Dead.csv']);
        dateList = table2array(Te(1,5:end));
        Te_dt = mode(days(diff(dateList)));
        
        % Infected
        I = importCSSEGISdata([datapath 'Confirmed.csv']);
        I = I(strcmp(I.CountryRegion, R.data.srcCountry),5:end);
        I = sum(table2array(I),1);
        
        % find Day0
        samp0 = find(I>0,1);
        R.data.day0 = dateList(samp0);
        I = I(samp0:end);
        N = numel(I);
        t = [0:N-1].*Te_dt; % time vector (days)
       
        % Recovered
        Re = importCSSEGISdata([datapath 'Recovered.csv']);
        Re = Re(strcmp(Re.CountryRegion, R.data.srcCountry),5:end);
        Re = sum(table2array(Re),1);
        Re = Re(samp0:end);
        
        % Dead
        D = importCSSEGISdata([datapath 'Dead.csv']);
        D = D(strcmp(D.CountryRegion, R.data.srcCountry),5:end);
        D = sum(table2array(D),1);
        D = D(samp0:end);
        
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

% Interpolate Time Scale
R.tvec_date = R.data.day0+days(R.tvec);
R.data.feat_xscale = R.tvec_date;
