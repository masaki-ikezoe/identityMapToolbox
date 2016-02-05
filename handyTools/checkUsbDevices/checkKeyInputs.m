function checkKeyInputs(quitKeyName)

if nargin < 1
    if ~exist('quitKey', 'var')
        quitKeyName = 'q';
    end
end

quitKeyCode = KbName(quitKeyName);
key = 1;
while key ~= quitKeyCode
    [ keyIsDown, secs, keyCode ] = KbCheck;
    if keyIsDown 
        key=find(keyCode); % keyCodeの表示
        keyName=KbName(key); % キ?[の名前を表示
        fprintf('"%s" key was pressed at %s.\n', keyName, datestr(now, 'HH:MM:SS.FFF'));
    end
end