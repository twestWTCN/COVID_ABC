function saveMkPath(filename,varo)
[pathstr,~,~] = fileparts(filename);
if ~exist(filename, 'dir')
    mkdir(pathstr);
end
save(filename,'varo')
