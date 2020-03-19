function r = randnbetween(mu,std,n1,n2)
if nargin < 4
    n2 = 1;
end
r = mu+std.*randn(n1,n2);
end