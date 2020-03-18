function xshuff = vectorShuff(x,winsize)
nbox = floor(size(x,2)/winsize); % divide into boxes
xbox = reshape(x(1:nbox*winsize),nbox,winsize); % reshape
xshuff = xbox(randperm(nbox),:); % reorder rows
xshuff = xshuff(:)';