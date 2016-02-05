function [imgs,imgDir] = getimg(pathName,extension)
%  ImgGet�͎w�肳�ꂽ�t�H���_���̉摜�t�@�C����imread���g���ēǂݍ��ފ֐��ł��B
%  �摜�̃C���[�W�f�[�^��'data'�t�B�[���h���Ɋi�[����܂��B
%
%  ��F
%  �P�j�t�H���_�p�X
%  �Q�j�摜�t�@�C���̊g���q
%
%  �Ԃ�l:
%  ���ꂼ��̉摜�t�@�C���̃C���[�W�f�[�^��v�f�Ƃ���\���̔z���Ԃ��܂��B

%----�ȉ��v���O����-------
try
    %�摜���X�g���쐬���܂��B
    %�����v���O������ۑ����Ă���t�H���_����images�Ƃ������O�̃t�H���_��������
    %�摜��images�t�H���_�ɕۑ����Ă������ƁB
    imgDir = [pathName filesep];
    imgFileList = dir([imgDir '*.' extension]);
    imgNum = size(imgFileList, 1); % �t�H���_���̉摜�̖���

    %�摜�̓ǂݍ��݁ik�Ԗڂ̉摜��ǂݍ��݂܂��j
    for k = 1:imgNum
        imgFileName = char(imgFileList(k).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
        imgFileName2 = [imgDir imgFileName]; % �摜�̃t�@�C�����i�t�H���_��񂠂�j
        imgs(k).data = imread(imgFileName2);
        imgs(k).name = imgFileName;
    end    
catch
end
