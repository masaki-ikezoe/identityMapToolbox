function myKeyCheck
% OS�ŋ��ʂ̃L?[�z�u�ɂ���
KbName('UnifyKeyNames');

% ������̃L?[��������Ă��Ȃ�?�Ԃɂ��邽�߂P�b�قǑ҂�
tic;
while toc < 1; end;

% �����ɂ���L?[��?�����
DisableKeysForKbCheck([]);

% ?��ɉ������L?[?�����擾����
[ keyIsDown, secs, keyCode ] = KbCheck;

% ?��ɉ������L?[����������?A����𖳌��ɂ���
if keyIsDown 
    fprintf('A key was invalidated: ');
    key=find(keyCode); % keyCode�̕\��
    keyName=KbName(key); % �L?[�̖��O��\��
    DisableKeysForKbCheck(key);
    fprintf('"%s" key has been released.\n', keyName);
end