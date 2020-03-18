function SEIR_fx
S = X(1);
E = X(2);
I = X(3);
R = X(4);

% Get parameters
dS = ((beta*S*I)/N); % Susceptible Population
dE = ((beta*S*I)/N) -   (sigma*E); % Exposed Population
dI = (sigma*E)  -   (gamma*I); % Infected Population
dR = (gamma*I); % Recovered Population

