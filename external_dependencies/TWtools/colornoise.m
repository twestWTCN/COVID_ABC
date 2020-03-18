function [W,t]= colornoise(a,b,T,N)
%  randn('state',100);      %fixing the state of generator
 dt=T/N;
 dW=sqrt(dt)*randn(1,N);

 R=1;                      %fixed for this computation
 L=N/R;
 Xem=zeros(1,L);
 Xzero=0;
 Xtemp=Xzero;
 Dt=R*dt;

 for j=1:L
    Winc=sum(dW(R*(j-1)+1:R*j));
    Xtemp=Xtemp+a*Dt*Xtemp+b*Winc;
    Xem(j)=Xtemp;
 end

 W=[Xem'];
 t=[0:Dt:T];