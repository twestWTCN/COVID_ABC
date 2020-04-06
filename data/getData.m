function R = getData(R)

switch R.data.source
    case 'simulated'
        load([R.root '\data\simulated_data\simdata.mat'])
        dat = xdata(R.obs.datachan,:);
        N = size(dat,2);
        t = [0:N-1].*R.IntP.dt;
        R.data.day0 = date;
    case 'CSSEGIS'
        
        [D_Table_Git_D, D_Table_Git_B, D_Table_Git_R, Te] = Git_retrieve_GSSEGIS(R);
                
        % TimeScale
        dateList = Te(1,5:end);
        Te_dt = mode(days(diff(dateList)));
        
        % Infected
        I = D_Table_Git_B;
        I = I(strcmp(I.('Country/Region'), R.data.srcCountry),5:end);
        I = sum(table2array(I),1);
        I = I(1:end-1);
        % find Day0
        samp0 = find(I>0,1);
        R.data.day0 = dateList(samp0);
        I = I(samp0:end);
        N = numel(I);
        t = [0:N-1].*Te_dt; % time vector (days)
       
        % Recovered
        Re = D_Table_Git_R;
        Re = Re(strcmp(Re.('Country/Region'), R.data.srcCountry),5:end);
        Re = sum(table2array(Re),1);
        Re = Re(samp0:end);
        Re = Re(1:end-1);
        % Dead
        D = D_Table_Git_D;
        D = D(strcmp(D.('Country/Region'), R.data.srcCountry),5:end);
        D = sum(table2array(D),1);
        D = D(samp0:end);
        D = D(1:end-1);
        % Format for ABC
        dat(1,:) = I - Re;
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
