function out = resizeimages(ImageData, rowSize)
% clear; close all; clc;
% 
% %% Set Parameters
% imgDir = 'C:\Toolbox';
% imgDir = uigetdir(imgDir, 'Select an Image Directory');
% % Estension of the image files
% imgExtension = 'png';

%% Set default values
if ~exist('rowSize', 'var')
    rowSize = 720;
end

nImages = length(ImageData);

%% Resize images
for iImage = 1:nImages
    out(iImage).data = imresize(ImageData(iImage).data, [rowSize NaN]);
    out(iImage).name = ImageData(iImage).name;
end

end