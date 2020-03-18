function pQ = getModelPriors(R)
switch R.data.srcCountry 
    case 'UK'
        pQ.alpha = 0.08; % protection rate
        pQ.beta = 0.9;  % infection rate
        pQ.gamma = 1/2; % inverse of average latent time
        pQ.delta = 1/8; % inverse of average quarantine time
        pQ.lambda0 = [0.03 0.05]; % cure rate (time dependant)
        pQ.kappa0 = [0.03 0.05]; % mortality rate (time dependant)
        pQ.Npop = 60e6; % population of 60M
    case 'China'
        pQ.alpha = 0.08; % protection rate
        pQ.beta = 0.9;  % infection rate
        pQ.gamma = 1/2; % inverse of average latent time
        pQ.delta = 1/8; % inverse of average quarantine time
        pQ.lambda0 = [0.03 0.05]; % cure rate (time dependant)
        pQ.kappa0 = [0.03 0.05]; % mortality rate (time dependant)
        pQ.Npop = 1e9; % population of 60M
end