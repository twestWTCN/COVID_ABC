%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Pink Noise Generation with MATLAB Implementation   %
%                                                      %
% Author: M.Sc. Eng. Hristo Zhivomirov       07/30/13  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = anyNoise(N,Gx,Fx)

% function: y = pinknoise(N) 
% N - number of samples to be returned in row vector
% y - row vector of pink (flicker) noise samples

% The function generates a sequence of pink (flicker) noise samples. 
% Pink noise has equal energy in all octaves (or similar log bundles) of frequency.
% In terms of power at a constant bandwidth, pink noise falls off at 3 dB per octave. 

% difine the length of the vector
% ensure that the M is even
if rem(N,2)
    M = N+1;
else
    M = N;
end
nf = linspace(min(Fx),max(Fx),M/2);
X2 = interp1(Fx,Gx,nf).*sqrt(-1);
X2 = [X2 X2(end:-1:1)]
nf = [nf nf(end:-1:1)]
% generate white noise
x = randn(1, M);

% FFT
X = fft(x);

% IFFT
y = ifft(X);

% prepare output vector y
y = real(y(1, 1:N));

% ensure unity standard deviation and zero mean value
y = y - mean(y);
yrms = sqrt(mean(y.^2));
y = y/yrms;

end