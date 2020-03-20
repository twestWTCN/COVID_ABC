function [D_Table_Git_D, D_Table_Git_B, D_Table_Git_R] = Git_retrieve_GSSEGIS()
%%%% Function to retrieve CSSEGIS data. Reliant on callingsystem functions
%%%%(Notably 'curl'). Should function on all OS's, but yet to be tested.
%%%% May also be issues, with URL stability.
% D_Table_Git_D: Table of daily deaths, for each region/country.
% D_Table_Git_B: Table of daily confirmed infections, for each region/country.
% D_Table_Git_R: Table of daily recovery's, for each region/country.
%------------- 20/03/20------------------
%%%%%%%%%%%%%%@Oliver West%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Git String Definititions. [Note: Unsure on stability of this url]
Git_Add_Str = 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-';
Git_Select_str = ["Deaths", "Confirmed", "Recovered"];
Git_csv_str = '.csv';

%String to CSV paramters. [Matlab refusing to read csv format, at the
%above URL]
T_passed = today - 737812;
C_head_Col = '%q%q%f%f';
C_head_t = repmat('%d', [1, T_passed]);
C_head = strcat(C_head_Col,C_head_t);

%Array to table, header names.
T_head_col = ["Province/State","Country/Region","Lat","Long"]; 
T_head_t = string(datetime(2020,01,22,0,0,0):datetime(2020,01,22,0,0,0) + caldays(T_passed));
T_head = [T_head_col,T_head_t];

%Loop for ["Deaths", "Confirmed", "Recovered"].
for ii = 1:3
    try
        %Select relevant string.
        Git_String = strcat(Git_Add_Str,Git_Select_str(ii),Git_csv_str);
        
        %Call the system, to excute a curl fetch from the above Git
        %repository. 'curl' should work on all OS's but only tested on
        %windows.
        [~,Data_String] = system(strcat('curl',{' -s '},Git_String));
        Data_Array = textscan(Data_String(1,:),C_head,'Delimiter',',','HeaderLines',1);
        
        %Create data table from the data.
        D_Table_Git_DBR = array2table(Data_Array{1},'VariableNames', T_head(1));
        for ij = 2:T_passed+4
            D_Table_Git_DBR = [D_Table_Git_DBR array2table(Data_Array{ij},'VariableNames', T_head(ij))];
        end
        
        %Switch to save table seperatly at each iteration.
        switch ii
            case 1
                D_Table_Git_D = D_Table_Git_DBR;
            case 2
                D_Table_Git_B = D_Table_Git_DBR;
            case 3
                D_Table_Git_R = D_Table_Git_DBR;
        end
              
    catch
        %Read in failure. Double check url.
        disp('Error, reading in webdata - Double Check Url');
    end
end