function sortedImages = sortimg(Images, num_repitition, p_blank, continuity)
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
num_stimuli = length(Images);
num_blanks = round((p_blank * num_stimuli * num_repitition) / (1 - p_blank));

%--�ȉ��v���O����---
try
    %�掦�����̐ݒ�i����j
    initOrder = [repmat(1:1:num_stimuli, 1, num_repitition) num_stimuli+1:1:num_stimuli+num_blanks];
    idx = randperm(length(initOrder)); % �C���f�b�N�X���V���b�t��
    shuffledOrder = initOrder(idx); %�@�h���̏��Ԃ��V���b�t��
    
    % Shuffle indecies
    switch continuity
        case 1
            %�V���b�t���������ʂ����̂܂ܕԂ��܂�
            order = shuffledOrder;
        case 0
            %�A���J��Ԃ����Ȃ��Ȃ�܂ŃV���b�t�����J��Ԃ�
            while any(diff(shuffledOrder)==0)
                idx = randperm(length(initOrder)); % �C���f�b�N�X���V���b�t��
                shuffledOrder = shuffledOrder(idx); %�@�h���̏��Ԃ��V���b�t��
            end
            order = shuffledOrder;
        otherwise
            error('Wrong number of input arguments');
    end
    
    % Re-order the images, with a blank stimulus
    for ii = 1:length(order)
        if order(ii) <= num_stimuli
            sortedImages(ii).data = Images(order(ii)).data;
            sortedImages(ii).name = Images(order(ii)).name;
        else
            sortedImages(ii).data = ones(10, 10, 3) * 255; % TODO: change the color if you need.
            sortedImages(ii).name = 'blank';
        end
    end
    
catch
end