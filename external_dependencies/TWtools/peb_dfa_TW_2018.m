function [bmod win evi alpha] = peb_dfa_TW_2018(dphdiff,DFAP,BF_r,sfig)
set(0, 'DefaultFigurePosition', [100         100        500        500]);
set(0,'DefaultAxesFontSize',18)
set(0,'DefaultlineLineWidth',1)
set(0,'DefaultLineMarkerSize',9)
% define DFA params;

fsamp = DFAP(1); minBS = DFAP(2); maxBS = DFAP(3); itrs = DFAP(4); fig =DFAP(5);
% DFAparam = [fsamp minBS*fsamp 8];
[lns lF m pfit alpha intercep r2]=dfaData4TW(dphdiff',fsamp,[minBS,maxBS],itrs,fig,[]);

N = length(lns); n = lns';
y1 = lF;
%% Define Models and test
% Linear
clear C P
D1 = [ones(N,1) n];
P{1}.X = D1;
P{1}.C = {eye(N)};
[C,P,F(1)] = spm_PEB(y1,P,0);

if sfig == 1
    figure
    subplot(3,3,1)
    plot(lns,lF')
    hold on
    p = full(C{2}.E);
    Y = p(1) + p(2).*n;
    plot(n,Y,'r')
    ylim([min(Y) max(Y)]); xlim([min(lns) max(lns)]);
    title({['Alpha = ' num2str(alpha)]; [' Linear F=' num2str(F(1))]})
end

% Quadratic
clear C P
D2 = [ones(N,1) n n.^2];
P{1}.X = D2;
P{1}.C = {eye(N)};
[C,P,F(2)] = spm_PEB(y1,P,0);

if sfig == 1
    subplot(3,3,2)
    plot(lns,lF')
    hold on
    p = full(C{2}.E);
    Y = p(1) + p(2).*n + p(3).*n.^2;
    plot(n,Y,'r')
    ylim([min(Y) max(Y)]); xlim([min(lns) max(lns)]);
    title(['Quadratic F=' num2str(F(2))])
end

% Cubic
clear C P
D3 = [ones(N,1) n n.^2 n.^3];
P{1}.X = D3;
P{1}.C = {eye(N)};
[C,P,F(3)] = spm_PEB(y1,P,0);

if sfig == 1
    subplot(3,3,3)
    plot(lns,lF')
    hold on
    p = full(C{2}.E);
    Y = p(1) + p(2).*n + p(3).*n.^2 + p(4).*n.^3;
    plot(n,Y,'r')
    ylim([min(Y) max(Y)]); xlim([min(lns) max(lns)]);
    title(['Cubic F=' num2str(F(3))])
end

% Quartic
clear C P
D4 = [ones(N,1) n n.^2 n.^3 n.^4];
P{1}.X = D4;
P{1}.C = {eye(N)};
[C,P,F(4)] = spm_PEB(y1,P,0);

if sfig == 1
    subplot(3,3,4)
    plot(lns,lF')
    hold on
    p = full(C{2}.E);
    Y = p(1) + p(2).*n + p(3).*n.^2 + p(4).*n.^3 + p(5).*n.^4;
    plot(n,Y,'r')
    ylim([min(Y) max(Y)]); xlim([min(lns) max(lns)]);
    title(['Quartic F=' num2str(F(4))])
end

% Quintic
clear C P
D5 = [ones(N,1) n n.^2 n.^3 n.^4 n.^5];
P{1}.X = D5;
P{1}.C = {eye(N)};
[C,P,F(5)] = spm_PEB(y1,P,0);

if sfig == 1
    subplot(3,3,5)
    plot(lns,lF')
    hold on
    p = full(C{2}.E);
    Y = p(1) + p(2).*n + p(3).*n.^2 + p(4).*n.^3 + p(5).*n.^4 + p(6).*n.^5;
    plot(n,Y,'r')
    ylim([min(Y) max(Y)]); xlim([min(lns) max(lns)]);
    title(['Quintic F=' num2str(F(5))])
end

% Square root
clear C P
D6 = [ones(N,1) n.^(1/2)];
P{1}.X = D6;
P{1}.C = {eye(N)};
[C,P,F(6)] = spm_PEB(y1,P,0);

if sfig == 1
    subplot(3,3,6)
    plot(lns,lF')
    hold on
    p = full(C{2}.E);
    Y = p(1) + p(2).*n.^(1/2);
    plot(n,Y,'r')
    ylim([min(Y) max(Y)]); xlim([min(lns) max(lns)]);
    title(['Square root F=' num2str(F(6))])
end

% Cube root
clear C P
D7 = [ones(N,1) n.^(1/3)];
P{1}.X = D7;
P{1}.C = {eye(N)};
[C,P,F(7)] = spm_PEB(y1,P,0);

if sfig == 1
    subplot(3,3,7)
    plot(lns,lF')
    hold on
    p = full(C{2}.E);
    Y = p(1) + p(2).*n.^(1/3);
    plot(n,Y,'r')
    ylim([min(Y) max(Y)]); xlim([min(lns) max(lns)]);
    title(['Cube root F=' num2str(F(7))])
end

% Log
clear C P
D8 = [ones(N,1) log(n)];
P{1}.X = D8;
P{1}.C = {eye(N)};
[C,P,F(8)] = spm_PEB(y1,P,0);

if sfig == 1
    subplot(3,3,8)
    plot(lns,lF')
    hold on
    p = full(C{2}.E);
    Y = p(1) + p(2).*log(n);
    plot(n,Y,'r')
    ylim([min(Y) max(Y)]); xlim([min(lns) max(lns)]);
    title(['Log F=' num2str(F(8))])
end

% Exp
clear C P
D9 = [ones(N,1) exp(n)];
P{1}.X = D9;
P{1}.C = {eye(N)};
[C,P,F(9)] = spm_PEB(y1,P,0);

if sfig == 1
    subplot(3,3,9)
    plot(lns,lF')
    hold on
    p = full(C{2}.E);
    Y = p(1) + p(2).*exp(n);
    plot(n,Y,'r')
    ylim([min(Y) max(Y)]); xlim([min(lns) max(lns)]);
    title(['Exp F=' num2str(F(9))])
end
% Is Linear F max of set?
sFev = sort(F,'descend');

if F(1) == max(F)
    evi = [2*log(F(1)-sFev(2))];
else
    % Linear loses
    evi = [-2*log(sFev(1)-F(1))];
end

% if  evi(1)==0 && abs(evi(2)) > BF_r CHANGED
if  evi < BF_r 
    rej = 1;
else
    rej = 0;
end

mods = {'Linear','Quadratic','Cubic','Quintic','Quartic','Square-Root','Cube-root','Log','Exp'};
win = find(F == max(F));
bmod = mods{win};
end