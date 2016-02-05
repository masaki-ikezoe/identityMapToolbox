function [GammaImg] = gammacorrect(img)
%　画像イメージのガンマ補正を行います。
%
%  [引数]
%  イメージデータ
%
%  [返り値]
%  ガンマ補正されたイメージデータ

%----------------------------------------
%  以下の変数を必要に応じて変更してください
%
% defaultPath = 'C:\MyPrograms\MATLAB\fMRI\PersonalFamiliarityPresentation';
% imgExtension = 'jpg';

%----　以下プログラム　---
%イメージデータの標準化
NormImg = double(img/255);

%輝度値への変換
GammaImg = NormImg.^2.2;

