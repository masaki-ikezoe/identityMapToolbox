function myKeyCheck
% OSで共通のキ?[配置にする
KbName('UnifyKeyNames');

% いずれのキ?[も押されていない?�態にするため１秒ほど待つ
tic;
while toc < 1; end;

% 無効にするキ?[の?炎�化
DisableKeysForKbCheck([]);

% ?�榾押されるキ?[?�ｱ�を取得する
[ keyIsDown, secs, keyCode ] = KbCheck;

% ?�榾押されるキ?[があったら?Aそれを無効にする
if keyIsDown 
    fprintf('A key was invalidated: ');
    key=find(keyCode); % keyCodeの表示
    keyName=KbName(key); % キ?[の名前を表示
    DisableKeysForKbCheck(key);
    fprintf('"%s" key has been released.\n', keyName);
end