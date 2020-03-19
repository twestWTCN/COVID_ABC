function [xCalc yCalc b Rsq] = linregress_zerocept(X,Y)
        Y(isnan(X)) = []; X(isnan(X)) = []; 
        X(isnan(Y)) = []; Y(isnan(Y)) = []; 
        if zerocept ==1
        X = X;
        else
            
        b = X\Y;
        yCalc = X*b;
        Rsq = 1 - sum((Y - yCalc).^2)/sum((Y - mean(Y)).^2);
        xCalc = X(:,1);