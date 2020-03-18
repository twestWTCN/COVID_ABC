function [xsims_gl,R,wflag] =SEIRQRDP_dataObs(xsims,m,p,R)
wflag = 0;
xsims_gl{1} = xsims(R.obs.datachan,:);
