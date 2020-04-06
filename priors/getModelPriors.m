function pQ = getModelPriors(R)
switch R.data.srcCountry 
    case 'United Kingdom'
        pQ.E0_par = 200;
        pQ.alpha = 0.08; % protection rate
        pQ.beta = 0.9;  % infection rate
        pQ.gamma = 1/2; % inverse of average latent time
        pQ.delta = 1/8; % inverse of average quarantine time
        pQ.lambda0 = [0.03 0.05]; % cure rate (time dependant)
        pQ.kappa0 = [0.03 0.05]; % mortality rate (time dependant)
        pQ.Npop = 66.4e6; % population of 60M
        
        %SEIQRDP_Q Model Parameters:
        pQ.Q_Time = 1/45; %inverse of time until begining of quarantine measurements.[O.West]
    case 'China'
        pQ.E0_par = 5;
        pQ.I0_par = 5;
        pQ.D0_par = 5;
        pQ.alpha = 0.08; % protection rate
        pQ.beta = 0.9;  % infection rate
        pQ.gamma = 1/2; % inverse of average latent time
        pQ.delta = 1/8; % inverse of average quarantine time
        pQ.lambda0 = [0.03 0.05]; % cure rate (time dependant)
        pQ.kappa0 = [0.03 0.05]; % mortality rate (time dependant)
        pQ.Npop = 1.4e9; % population of 1.4 Billion
        pQ.hidlist = 0.8; % Proportion of infected cases that are reported
        %SEIQRDP_Q Model Parameters:
        pQ.Q_Time = 1/40; %inverse of time until begining of quarantine measurements.[O.West]
    case 'Italy'
        pQ.E0_par = 200;
        pQ.alpha = 0.08; % protection rate
        pQ.beta = 0.9;  % infection rate
        pQ.gamma = 1/2; % inverse of average latent time
        pQ.delta = 1/8; % inverse of average quarantine time
        pQ.lambda0 = [0.03 0.05]; % cure rate (time dependant)
        pQ.kappa0 = [0.03 0.05]; % mortality rate (time dependant)
        pQ.Npop = 60.4e6; % population of 60M 
        
        %SEIQRDP_Q Model Parameters:
        pQ.Q_Time = 1/45; %inverse of time until begining of quarantine measurements.[O.West]
    case 'Korea, South'
        pQ.E0_par = 200;
        pQ.alpha = 0.08; % protection rate
        pQ.beta = 0.9;  % infection rate
        pQ.gamma = 1/2; % inverse of average latent time
        pQ.delta = 1/8; % inverse of average quarantine time
        pQ.lambda0 = [0.03 0.05]; % cure rate (time dependant)
        pQ.kappa0 = [0.03 0.05]; % mortality rate (time dependant)
        pQ.Npop = 51.47e6; % population of 60M
        
        %SEIQRDP_Q Model Parameters:
        pQ.Q_Time = 1/45; %inverse of time until begining of quarantine measurements.[O.West]
        
    case 'US'
        pQ.E0_par = 200;
        pQ.alpha = 0.08; % protection rate
        pQ.beta = 0.9;  % infection rate
        pQ.gamma = 1/2; % inverse of average latent time
        pQ.delta = 1/8; % inverse of average quarantine time
        pQ.lambda0 = [0.03 0.05]; % cure rate (time dependant)
        pQ.kappa0 = [0.03 0.05]; % mortality rate (time dependant)
        pQ.Npop = 327.2e6; % population of 60M 
        
        %SEIQRDP_Q Model Parameters:
        pQ.Q_Time = 1/45; %inverse of time until begining of quarantine measurements.[O.West]
        
        
end