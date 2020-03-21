clear; close all


%% Make your own 'my_paths.m' containing something like the following:
% addpath('C:\Users\Oliver\Documents\GitHub\ABC_Inference_Neural_Paper')
% projpath = 'C:\Users\Oliver\Documents\GitHub\COVID_ABC'; % change this to your working folder
%%
projpath = my_paths;

projcode = 'project_03172020'; % whatever you want to code your project by
R = ABCAddPaths(projpath,projcode);

%% Setup Structure
R.out.tag = 'simpleModComp';
R.plot.flag = 1;
R.SimAn.pOptList = {'.E0_par','.alpha','.beta','.gamma','.delta','.lambda0','.kappa0'};
R.SimAn.rep = 256; % Number of draws per round
R.SimAn.jitter = 1; % global rescaler of precison (1 is default)
R.SimAn.searchMax = 100; % max number of rounds
R.SimAn.pOptBound = [-12 12];
R.SimAn.pOptRange = -4:0.05:4;
R.IntP.intFx = @SEIQRDP_wrapper;
R.IntP.compFx = @compareData_100717;
R.obs.obsFx = @SEIRQRDP_dataObs;
R.obs.datachan = [3 5 6]; % simulated channels available in data;
R.data.datatype = 'time'; % for comparison tells which type of error to compute
% Not really needed (but needed to work!)
R.IntP.Utype = 'zero';
R.frqzfull = 500;
R.condnames = {'A'};
R.obs.glist = 1;

R.plot.outFeatFx = @simpleSEIRTS_plotter;
 R.plot.outFeatCiFx = @simpleSEIRTS_plotter_CI; % Plot with Bayesian confidence limits
R.plot.save = 0;
R.SimAn.convIt = 1e-3;

%%

% Setup time vector
R.IntP.dt = 0.1; % Time Step
t = 0:R.IntP.dt:365; % simulate a half year
R.tvec = t;
R.IntP.nt = numel(t);

% Specify data sources
R.data.srcCountry = 'China';
R.data.source = 'CSSEGIS'; % Real Data
% R.data.source = 'simulated'; % Real Data

% Get Data, now links to github database;
R = getData(R);

% Plot Data
simpleSEIRTS_plotter({R.data.feat_emp},{{NaN(3,1)}},R.data.feat_xscale,R)

% Now do a loop over models to fit parameters
for mod = 1:3
% Model Setup - this sets expectations on the priors (but not the priors
% themselves. For that see 'getModelPriors.m'
    if mod == 1
        R.model.type = 'SEIQRDP';
        R.out.dag = 'SEIQRDP_fixedE0'; %
        R.SimAn.pOptList = {'.alpha','.beta','.gamma','.delta','.lambda0','.kappa0'};
        [R pc m uc] = MS_model1(R);
    elseif mod == 2
        R.model.type = 'SEIQRDP';
        R.out.dag = 'SEIQRDP_varE0'; %
        R.SimAn.pOptList = {'.E0_par','.alpha','.beta','.gamma','.delta','.lambda0','.kappa0'};
        [R pc m uc] = MS_model1(R);
    elseif mod == 3
        R.model.type = 'SEIQRDP';
        R.out.dag = 'SEIQRDP_varE0_slowCure'; %
        R.SimAn.pOptList = {'.E0_par','.alpha','.beta','.gamma','.delta','.lambda0','.kappa0'};
        [R pc m uc] = MS_model1_slowCure(R);
    elseif mod == 4
        R.model.type = 'SEIQRDP_Q';
        R.out.dag = 'SEIQRDP_Q'; %
        R.SimAn.pOptList = {'.E0_par','.alpha','.beta','.gamma','.delta','.lambda0','.kappa0','.Q_Time'}; % extra Q parameter
        [R pc m uc] = MS_model1(R);
    end
    %   Availabile Models:
    %   'SEIQRDP'   - Description: 7 Stage structed model, with time dependent cure
    %               and mortality rates.
    %
    %   'SEIQRDP_Q' - Description: 7 Stage structed model, with time dependent cure
    %               and mortality rates. With rudimentary model of quarantine,
    %               via setting infection rate to a time delayed sigmoid
    %               function.
    
    % This is the main routine that does the fitting
    SimAn_ABC_220219b(R,pc,m);
end

%% This is the model comparison step:
R.comptype = 1; % standard model comparison
R.analysis.BAA.flag = 1;
modlist = {'SEIQRDP_fixedE0','SEIQRDP_varE0','SEIQRDP_varE0_slowCure','SEIQRDP_Q'}; % your model list
modID = modelCompMaster_210320(R,modlist,[]);

%% Plot the modComp results
R.modcomp.modN = modlist; %
R.modcompplot.NPDsel = {'SEIQRDP_fixedE0','SEIQRDP_varE0','SEIQRDP_varE0_slowCure','SEIQRDP_Q'}; % selection of models to plot (if you want a subset)
R.plot.confint = 'yes';
cmap = linspecer(numel(R.modcomp.modN));
cmap = cmap(end:-1:1,:);
close all
plotModComp_210320(R,cmap)


%% SCRIPT GRAVE -
% Old Time Definition- Now just use time from patient zero
% time1 = datetime(2019,12,01,0,0,0):R.IntP.dt:datetime(2020,09,01,0,0,0); %split up calendar
% N = numel(time1);
% t = [0:N-1].*R.IntP.dt; % time vector (days)

