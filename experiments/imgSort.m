function order = imgSort(num_stimuli, num_control, rpt_stimuli, rpt_control, continuity)
%  ImgSort�͉摜��掦���鏇�������߂�֐��ł��B
%
%  ��F
%  �P�j�����摜
%  �Q�j�R���g���[���摜���A
%  �R�j�����摜�̌J��Ԃ��񐔁i�摜�P��������j
%  �S�j�R���g���[���摜�̌J��Ԃ��񐔁i�摜�P��������j�A
%  �T�j�A���J��Ԃ��m����(1)�E�Ȃ�(0)�n
%
%  �Ԃ�l�F
%  �摜�̒掦�����i�C���f�b�N�X�\���j

%--�p�����[�^�ݒ�----
% num_face = 24;
% num_control = 1;
% rpt_face = 10;
% rpt_control= 21;
% continuity = 0; % 1, permit continuity; 0, forbit continuity

%--�ȉ��v���O����---
try
    %�掦�����̐ݒ�i����j
    InitOrder = [repmat(1:1:num_stimuli, 1, rpt_stimuli) repmat(num_stimuli+1:1:num_stimuli+num_control ,1, rpt_control)];
    %InitOrder = [repmat(1:1:num_stimuli, 1, rpt_stimuli) num_stimuli+1:1:num_stimuli+rpt_control];
    idx = randperm(length(InitOrder)); % �C���f�b�N�X���V���b�t��
    ShuffledOrder = InitOrder(idx); %�@�h���̏��Ԃ��V���b�t��
    
    switch continuity
        case 1
            %�V���b�t���������ʂ����̂܂ܕԂ��܂�
            order = ShuffledOrder;
        case 0
            %�A���J��Ԃ����Ȃ��Ȃ�܂ŃV���b�t�����J��Ԃ�
            while any(diff(ShuffledOrder)==0)
                idx = randperm(length(InitOrder)); % �C���f�b�N�X���V���b�t��
                ShuffledOrder = ShuffledOrder(idx); %�@�h���̏��Ԃ��V���b�t��
            end
            order = ShuffledOrder;
        otherwise
            error('Wrong number of input arguments');
    end
    
catch
end