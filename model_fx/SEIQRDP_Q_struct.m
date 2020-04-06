function [S,E,I,Q,R,D,P] = SEIQRDP_Q_struct(alpha,beta,gamma,delta,lambda0,kappa0,Npop,Q_Time,E0,I0,Q0,R0,D0,t)
% [S,E,I,Q,R,D,P] = SEIQRDP(alpha,beta,gamma,delta,lambda,kappa,Npop,E0,I0,R0,D0,t)
% simulate the time-histories of an epidemic outbreak using a generalized
% SEIR model.
%
% Input
%
%   alpha: scalar [1x1]: fitted protection rate
%   beta: scalar [1x1]: fitted  infection rate
%   gamma: scalar [1x1]: fitted  Inverse of the average latent time
%   delta: scalar [1x1]: fitted  inverse of the average quarantine time
%   lambda: scalar [1x1]: fitted  cure rate
%   kappa: scalar [1x1]: fitted  mortality rate
%   Npop: scalar: Total population of the sample
%   Q_Time: scalar [1x1]: footed inverse of time until begining of
%   quarantine measurements.
%   E0: scalar [1x1]: Initial number of exposed cases
%   I0: scalar [1x1]: Initial number of infectious cases
%   Q0: scalar [1x1]: Initial number of quarantined cases
%   R0: scalar [1x1]: Initial number of recovered cases
%   D0: scalar [1x1]: Initial number of dead cases
%   t: vector [1xN] of time (double; it cannot be a datetime)
%
% Output
%   S: vector [1xN] of the target time-histories of the susceptible cases
%   E: vector [1xN] of the target time-histories of the exposed cases
%   I: vector [1xN] of the target time-histories of the infectious cases
%   Q: vector [1xN] of the target time-histories of the quarantinedcases
%   R: vector [1xN] of the target time-histories of the recovered cases
%   D: vector [1xN] of the target time-histories of the dead cases
%   P: vector [1xN] of the target time-histories of the insusceptible cases
%
% Author: E. Cheynet - UiB - last modified 16-03-2020
% Modified: O. West - Added varying infection rate (Sigmoidal onset of
% Quarantine) - last modified 19-03-2020
%
% see also fit_SEIQRDP.m

%% Initial conditions
%Split population, into young and old bins. [Obviously how this is done
%still requires some proper thought].
Split_Factor = 0.5;
NYpop = Npop/(1-Split_Factor);
EY0 = E0/(1-Split_Factor);
IY0 = I0/(1-Split_Factor);
QY0 = Q0/(1-Split_Factor);
RY0 = R0/(1-Split_Factor);
DY0 = D0/(1-Split_Factor);

NOpop = Npop/(Split_Factor);
EO0 = E0/(Split_Factor);
IO0 = I0/(Split_Factor);
QO0 = Q0/(Split_Factor);
RO0 = R0/(Split_Factor);
DO0 = D0/(Split_Factor);

%Intialize intial conditions. 
N = numel(t);
Y = zeros(14,N);
Y(1,1) = NYpop-QY0-EY0-RY0-DY0-IY0;
Y(2,1) = EY0;
Y(3,1) = IY0;
Y(4,1) = QY0;
Y(5,1) = RY0;
Y(6,1) = DY0;
Y(7,1) = NOpop-QO0-EO0-RO0-DO0-IO0;
Y(8,1) = EY0;
Y(9,1) = IY0;
Y(10,1) = QY0;
Y(11,1) = RY0;
Y(12,1) = DY0;

%Temp Holder Paramters
alphao = alpha(1);
alphay = alpha(2);
gammao = gamma(1);
gammay = gamma(2);
deltao =delta(1);
deltay =delta(2);

% if round(sum(Y(:,1))-Npop)~=0
%     error('the sum must be zero because the total population (including the deads) is assumed constant');
% end
%%
modelFun = @(Y,A,F) A*Y + F;
dt = median(diff(t));
% Q_Time
% ODE reYution
for ii=1:N-1
%     beta0
%     beta = beta0*abs(exp(-Q_Time + t(ii))/(exp(-Q_Time + t(ii)) + 1));
    betaoo = beta(1);
    betayy = beta(2);
    betaoy = beta(3);
    betayo = beta(4);
    
    lambday = lambda0(1)*(1-exp(-lambda0(2).*t(ii))); % I use these functions for illustrative purpose only
    kappay = kappa0(1)*exp(-kappa0(2).*t(ii)); % I use these functions for illustrative purpose only    
    
    lambdao = lambday;
    kappao = kappay;
    
    A = getA(alphay,gammay,deltay,lambday,kappay,alphao,gammao,deltao,lambdao,kappao);
    SIYoung = Y(1,ii)*Y(3,ii);
    SIOld = Y(7,ii)*Y(9,ii);
    F = zeros(14,1);
    F(1:2,1) = [((-betayy*SIYoung)-(betaoy*SIOld))/Npop;((betayy*SIYoung)+(betaoy*SIOld))/Npop];
    F(7:8,1) = [((-betaoo*SIYoung)-(betayo*SIOld))/Npop;((betaoo*SIYoung)+(betayo*SIOld))/Npop];
    Y(:,ii+1) = RK4(modelFun,Y(:,ii),A,F,dt);
end


S = Y([1 8],1:N);
E = Y([2 9],1:N);
I = Y([3 10],1:N);
Q = Y([4 11],1:N);
R = Y([5 12],1:N);
D = Y([6 13],1:N);
P = Y([7,14],1:N);



    function [A] = getA(alphay,gammay,deltay,lambday,kappay,alphao,gammao,deltao,lambdao,kappao)
        A = zeros(7);
        % S
        A(1,1) = -alphay;
        A(2,2) = -alphao;
        % E
        A(3,3) = -gammay;
        A(4,4) = -gammao;
        % I
        A(5,[3 5]) = [gammay,-deltay];
        A(6,[4 6]) = [gammao,-deltao];
        % Q
        A(7,[5 7]) = [deltay,-kappay-lambday];
        A(8,[6 8]) = [deltao,-kappao-lambdao];
        % R
        A(9,7) = lambday;
        A(10,8) = lambdao;
        % D
        A(11,7) = kappay;
        A(12,8) = kappao;
        % P
        A(13,1) = alphay;
        A(14,1) = alphao;
    end
    function [Y] = RK4(Fun,Y,A,F,dt)
        % Runge-Kutta of order 4
        k_1 = Fun(Y,A,F);
        k_2 = Fun(Y+0.5*dt*k_1,A,F);
        k_3 = Fun(Y+0.5*dt*k_2,A,F);
        k_4 = Fun(Y+k_3*dt,A,F);
        % output
        Y = Y + (1/6)*(k_1+2*k_2+2*k_3+k_4)*dt;
    end

end


