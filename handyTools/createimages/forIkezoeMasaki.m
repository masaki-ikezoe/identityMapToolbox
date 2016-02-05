% For Images selected by Ikezoe Masaki
clear; close all; clc;

%% Display Images
pathstr = uigetdir;
imgExtension = 'jpg';
[Imags, imgDir] = getimg(pathstr, imgExtension);
checkimg(Imags);

%% Resize Images
resizeimg(imgDir, imgExtension, 720);
