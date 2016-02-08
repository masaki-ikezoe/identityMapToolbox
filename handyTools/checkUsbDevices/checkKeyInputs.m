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
        key=find(keyCode); % keyCode�̕\��
        keyName=KbName(key); % �L?[�̖��O��\��
        fprintf('"%s" key was pressed at %s.\n', keyName, datestr(now, 'HH:MM:SS.FFF'));
    end
end