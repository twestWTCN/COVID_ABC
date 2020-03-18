function R = getData(R)
load([R.root '\data\simulated_data\simdata.mat'])
R.data.feat_emp{1} = xdata(R.obs.datachan,:);