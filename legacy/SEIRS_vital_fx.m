function SEIRS_vital_fx


% Get parameters
dS = (mu*N) -   ((beta*S*I)/N)  + (zeta*R)  - (v*S);
dE = ((beta*S*I)/N) -   (sigma*E)   -   (v*E);
dI = (sigma*E)  -   (gamma*I)   -   (v*I);
dR = (gamma*I)  -   (zeta*R)    - (v*R);
