function [xstore,tvec,wflag] = SEIQRDP_wrapper(R,x,uc,pc,m)
wflag = 0; % error flag
p = pc;
% Time scale
tvec = R.tvec;

% Parameters
%   alpha: scalar [1x1]: fitted protection rate
%   beta: scalar [1x1]: fitted  infection rate
%   gamma: scalar [1x1]: fitted  Inverse of the average latent time
%   delta: scalar [1x1]: fitted  inverse of the average quarantine time
%   lambda: scalar [1x1]: fitted  cure rate
%   kappa: scalar [1x1]: fitted  mortality rate
%   Npop: scalar: Total population of the sample

    % Retrieve Priors
    pQ = getModelPriors(R);
    
    % get expectations from log scaling parameters
    E0_par = pQ.E0_par.*exp(p.E0_par);
    I0_par = pQ.I0_par.*exp(p.I0_par);    
    D0_par = pQ.D0_par.*exp(p.D0_par);
    alpha = pQ.alpha.*exp(p.alpha);
    beta = pQ.beta.*exp(p.beta);
    gamma = pQ.gamma.*exp(p.gamma); 
    delta = pQ.delta.*exp(p.delta);
    lambda0 = pQ.lambda0.*exp(p.lambda0);
    kappa0 = pQ.kappa0.*exp(p.kappa0);
    Npop = pQ.Npop.*exp(p.Npop);
    Q_Time = pQ.Q_Time.*exp(p.Q_Time);
    hidlist = pQ.hidlist.*exp(p.hidlist); 
% Intial Conditions
%   E0: scalar [1x1]: Initial number of exposed cases
%   I0: scalar [1x1]: Initial number of infectious cases
%   Q0: scalar [1x1]: Initial number of quarantined cases
%   R0: scalar [1x1]: Initial number of recovered cases
%   D0: scalar [1x1]: Initial number of dead cases
E0 = E0_par;
I0 = I0_par;
Q0 = x(3);
R0 = x(4);
D0 = D0_par;


%Switch for models.
switch R.model.type
    case 'SEIQRDP'
        [S,E,I,Q,R,D,P] = SEIQRDP(alpha,beta,gamma,delta,lambda0,kappa0,Npop,E0,I0,Q0,R0,D0,tvec);
    case 'SEIQRDP_Q'
        [S,E,I,Q,R,D,P] = SEIQRDP_Q(alpha,beta,gamma,delta,lambda0,kappa0,Npop,Q_Time,E0,I0,Q0,R0,D0,tvec);
     case 'SEIQRDP_generic'
        [S,E,I,Q,R,D,P] = SEIQRDP_generic(alpha,beta,gamma,delta,lambda0,kappa0,Npop,Q_Time,E0,I0,Q0,R0,D0,tvec,R.IntP.TDlist,hidlist);
end
% Output
%   S: vector [1xN] of the target time-histories of the susceptible cases
%   E: vector [1xN] of the target time-histories of the exposed cases
%   I: vector [1xN] of the target time-histories of the infectious cases
%   Q: vector [1xN] of the target time-histories of the quarantinedcases
%   R: vector [1xN] of the target time-histories of the recovered cases
%   D: vector [1xN] of the target time-histories of the dead cases
%   P: vector [1xN] of the target time-histories of the insusceptible cases

xstore = [S; E; I; Q; R; D; P];

% I = xstore(3,:); R = xstore(5,:); D = xstore(6,:);
% save('simdata','I','R','D')
% catch
%     wflag= 1;
% end