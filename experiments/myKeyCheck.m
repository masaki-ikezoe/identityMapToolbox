function myKeyCheck
% OSで共通のキ?[配置にする
KbName('UnifyKeyNames');

% いずれのキ?[も押されていない?ﾔにするため１秒ほど待つ
tic;
while toc < 1; end;

% 無効にするキ?[の?炎匀ｻ
DisableKeysForKbCheck([]);

% ?墲ﾉ押されるキ?[?﨣謫ｾする
[ keyIsDown, secs, keyCode ] = KbCheck;

% ?墲ﾉ押されるキ?[があったら?Aそれを無効にする
if keyIsDown 
    fprintf('A key was invalidated: ');
    key=find(keyCode); % keyCodeの表示
    keyName=KbName(key); % キ?[の名前を表示
    DisableKeysForKbCheck(key);
    fprintf('"%s" key has been released.\n', keyName);
end