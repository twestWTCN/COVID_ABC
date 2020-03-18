function closeMessageBoxes()
handles = allchild(0);
tags = get(handles,'Tag');
isMsg = strncmp(tags,'Msgbox_',7); % all message boxes have the tags in the format of Msgbox_*
delete(handles(isMsg));