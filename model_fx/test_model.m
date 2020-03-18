R.IntP.dt = 0.1; % Time Step

% Time definition
time1 = datetime(2019,12,01,0,0,0):R.IntP.dt:datetime(2020,09,01,0,0,0);
N = numel(time1);
t = [0:N-1].*R.IntP.dt;
R.tvec = t;

% Parameters
pc.alpha = 0;
pc.beta = 0;
pc.gamma = 0;
pc.delta = 0;
pc.lambda0 = 0;
pc.kappa0 = 0;
pc.Npop = 0;

% Intial Conditions
E0 = 0; % Initial number of exposed
Q0 = 200; % Initial number of infectious that have bee quanrantined
I0 = Q0; % Initial number of infectious cases non-quarantined
R0 = 0; % Initial number of recovereds
D0 = 1; % Initial number of deads
% Setup Vector
x(1) = E0;
x(2) = I0;
x(3) = Q0;
x(4) = R0;
x(5) = D0;

uc = nan;
m = nan;
[xstore,tvec,wflag] = SEIQRDP_wrapper(R,x,uc,pc,m);