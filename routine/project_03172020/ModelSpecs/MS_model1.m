function [R p m uc] = MS_model1(R)

%% Parameter Expectations
p.E0_par = 0; % Initial Exposures
p.alpha = 0; % protection rate
p.beta = 0;  % infection rate
p.gamma = 0; % inverse of average latent time
p.delta = 0; % inverse of average quarantine time
p.lambda0 = 0; % cure rate (time dependant)
p.kappa0 = 0; % mortality rate (time dependant)
p.Npop = 0; % population of 60M

%% Parameter Precisions
p.E0_par_s = 2; % Initial Exposures
p.alpha_s = 1/4; % protection rate
p.beta_s = 1/4;  % infection rate
p.gamma_s = 1/4; % inverse of average latent time
p.delta_s = 1/4; % inverse of average quarantine time
p.lambda0_s = 1/4; % cure rate (time dependant)
p.kappa0_s = 1/4; % mortality rate (time dependant)
p.Npop_s = 1/128; % population of 60M

% Observer parameters
p.obs.LF = 0;

% Intial Conditions
E0 = 200; % Initial number of exposed
Q0 = 0; % Initial number of infectious that have been quanrantined
I0 = Q0; % Initial number of infectious cases non-quarantined
R0 = 0; % Initial number of recovereds
D0 = 1; % Initial number of deads
% Setup Vector
m.x(1) = E0;
m.x(2) = I0;
m.x(3) = Q0;
m.x(4) = R0;
m.x(5) = D0;
m.m = 1;
uc = nan;
