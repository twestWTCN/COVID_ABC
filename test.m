

t = 1:0.01:100;

        E0 = 5; %[5 8];
        I0 = 5; %[5 8];
        Q0 = 0;
        R0 = 0;
        D0 = 0; %[5 8];
        alpha = [0.08 0.01]; % protection rate
        beta0 = [0.9 0.7 0.3 0.3];  % infection rate
        gamma = [1/2 1/2]; % inverse of average latent time
        delta = [1/8 1/8]; % inverse of average quarantine time
        lambda0 = [0.03 0.05]; % cure rate (time dependant)
        kappa0 = [0.03 0.05]; % mortality rate (time dependant)
        Npop = 1.4e9; % population of 1.4 Billion
        hidlist = 0.8; % Proportion of infected cases that are reported
        %SEIQRDP_Q Model Parameters:
        Q_Time = 1/40; %inverse of time until begining of quarantine measurements.[O.West]

        

[S,E,I,Q,R,D,P] = SEIQRDP_Q_struct(alpha,beta0,gamma,delta,lambda0,kappa0,Npop,Q_Time,E0,I0,Q0,R0,D0,t)