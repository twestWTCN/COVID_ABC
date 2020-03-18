function savefigure_v2(pathna,namer,n,format,res) 
if isempty(n) || nargin<3
    handles=findall(0,'type','figure');
    for i = 1:length(handles)
        n(i) = handles(i).Number;
    end
end

if isempty(format) || nargin<4
    format = '-dtiff';
end

if isempty(res) || nargin<5
    res = '-200'; % DPI
end

if ~exist(pathna, 'dir')
    mkdir(pathna);
end

for N = 1:length(n)
    figure(n(N))
    print([pathna namer '_' num2str(n(N))],'-dtiff','-r300')
end
