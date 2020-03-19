function out = pareval(evalstat,target,subject,input)
eval(['target' subject '= input']);
out = eval('target');
