clear; close all
<<<<<<< HEAD
addpath('C:\Users\Oliver\Documents\GitHub\ABC_Inference_Neural_Paper')
R = ABCAddPaths('C:\Users\Oliver\Documents\GitHub\COVID_ABC','project_03172020');
=======
addpath('D:\GITHUB\ABC_Inference_Neural_Paper')
projpath = 'D:\Projects\COVID\COVID_ABC'; % change this to your working folder
projcode = 'project_03172020'; % whatever you want to code your project by
R = ABCAddPaths(projpath,projcode);
<<<<<<< HEAD
>>>>>>> 77a2bde91d071ff309c541389de2f6ff5bcbe34d
=======
>>>>>>> 77a2bde91d071ff309c541389de2f6ff5bcbe34d

%% Setup Structure
R.out.dag = 'firstRun'; % 
R.out.tag = '1';
 R.plot.flag = 1;
R.SimAn.pOptList = {'.E0_par','.alpha','.beta','.gamma','.delta','.lambda0','.kappa0'};
R.SimAn.rep = 256; % Number of draws per round
R.SimAn.jitter = 2; % global rescaler of precison (1 is default)
R.SimAn.searchMax = 100; % max number of rounds
R.SimAn.pOptBound = [-12 12];
R.SimAn.pOptRange = -4:0.05:4;
R.IntP.intFx = @SEIQRDP_wrapper_Q;
R.IntP.compFx = @compareData_100717;
R.obs.obsFx = @SEIRQRDP_dataObs;
R.obs.datachan = [3 5 6]; % simulated channels available in data;
R.data.datatype = 'time'; % for comparison tells which type of error to compute
% Not really needed (but needed to work!)
R.IntP.Utype = 'zero';
R.frqzfull = 500;
R.condnames = {'A'};
R.obs.glist = 1;

%%Note: Modified test model at:  
%@SEIQRDP_wrapper_Q;
%@SEIQRDP_wrapper;
%Worth adding switch case, for more models.

R.plot.outFeatFx = @simpleSEIRTS_plotter;
R.plot.save = 0;
R.SimAn.convIt = 1e-3;

%%


% Setup time vector
R.IntP.dt = 0.1; % Time Step
t = 0:R.IntP.dt:365; % simulate a half year
R.tvec = t;
R.IntP.nt = numel(t);

<<<<<<< HEAD
<<<<<<< HEAD
R.data.srcCountry = 'China';
R.data.source = 'CSSEGIS'; % Real Data
% R.data.source = 'simulated'; % Real Data
=======
% Specify data sourceds
R.data.srcCountry = 'Korea, South'; % 'China'; 'Italy'; 'United Kingdom'
R.data.source = 'CSSEGIS'; % Real Data; simulated'; % simulated set
>>>>>>> 77a2bde91d071ff309c541389de2f6ff5bcbe34d
=======
% Specify data sourceds
R.data.srcCountry = 'Korea, South'; % 'China'; 'Italy'; 'United Kingdom'
R.data.source = 'CSSEGIS'; % Real Data; simulated'; % simulated set
>>>>>>> 77a2bde91d071ff309c541389de2f6ff5bcbe34d

% Model Setup - this sets expectations on the priors (but not the priors
% themselves. For that see 'getModelPriors.m'
[R pc m uc] = MS_model1(R);

% Get Data, not setup to link to database yet, but job for future.
 R = getData(R); 
 
 % Plot Data
 simpleSEIRTS_plotter({R.data.feat_emp},{{NaN(3,1)}},R.data.feat_xscale,R)
 
 % This is the main routine that does the fitting
[p] = SimAn_ABC_220219b(R,pc,m);



%% SCRIPT GRAVE -
% Old Time Definition- Now just use time from patient zero
% time1 = datetime(2019,12,01,0,0,0):R.IntP.dt:datetime(2020,09,01,0,0,0); %split up calendar
% N = numel(time1); 
% t = [0:N-1].*R.IntP.dt; % time vector (days)

