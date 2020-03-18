function r = randbetween(a,b,n1,n2)
if nargin < 4
    n2 = 1;
end
r = a+(b-a).*rand(n1,n2);
end