function [GammaImg] = gammacorrect(img)
%�@�摜�C���[�W�̃K���}�␳���s���܂��B
%
%  [����]
%  �C���[�W�f�[�^
%
%  [�Ԃ�l]
%  �K���}�␳���ꂽ�C���[�W�f�[�^

%----------------------------------------
%  �ȉ��̕ϐ���K�v�ɉ����ĕύX���Ă�������
%
% defaultPath = 'C:\MyPrograms\MATLAB\fMRI\PersonalFamiliarityPresentation';
% imgExtension = 'jpg';

%----�@�ȉ��v���O�����@---
%�C���[�W�f�[�^�̕W����
NormImg = double(img/255);

%�P�x�l�ւ̕ϊ�
GammaImg = NormImg.^2.2;

