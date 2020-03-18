function [f csd] = synthspec_250117(tarfreq,precs)
PARAMS = {'G','T','L'};
J      = [3];                % indices of hidden states producing outputs
Np     = 1; %length(J);
% Model specification
%==========================================================================
Nc    = 1;
Ns    = 1;
options.spatial  = 'LFP';
options.model    = 'CMC';
M.dipfit.model = options.model;
M.dipfit.type  = options.spatial;
M.dipfit.Nc    = Nc;
M.dipfit.Ns    = Ns;
M.J            = J;
M.Hz           = 4:120;

% get priors
%--------------------------------------------------------------------------
[pE pC] = spm_dcm_neural_priors({0 0 0},{},1,options.model);
[pE pC] = spm_L_priors(M.dipfit,pE,pC);
[pE pC] = spm_ssr_priors(pE,pC);
[x,f]   = spm_dcm_x_neural(pE,options.model);

% suppress measurement noise
%--------------------------------------------------------------------------
pE.a(2) =      - 2;
pE.b    = pE.b - 16;
pE.c    = pE.c - 16;

s(:,1) = -[precs]'   + 1j*2*pi*[tarfreq]';
% s(:,2) = -[16]' + 1j*2*pi*[12]';

% a target data
%--------------------------------------------------------------------------
Gu    = spm_csd_mtf_gu(pE,M.Hz);
for i = 1
    csd(:,i,i) = 512*full(Gu.*sum(spm_s2csd(s(:,i),M.Hz),2));
end

f = M.Hz;