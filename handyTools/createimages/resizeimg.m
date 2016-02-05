function resizeimg(imgDir, imgExtension, numRows)
% clear; close all; clc;
% 
% %% Set Parameters
% imgDir = 'C:\Toolbox';
% imgDir = uigetdir(imgDir, 'Select an Image Directory');
% % Estension of the image files
% imgExtension = 'png';

%% Set default values
if ~exist('nRows', 'var')
    numRows = 720;
end

%% Get Images
[Images, imgDir] = getimg(imgDir, imgExtension);
nImages = length(Images);

%% Resize images
% numRows = 720;
resizedImages = Images;
for iImage = 1:nImages
    resizedImages(iImage).data = imresize(Images(iImage).data, [numRows NaN]);
    resizedImages(iImage).name = Images(iImage).name;
end

%% Gamma Correction
% for iImage = 1:nImages
%     gammaImages(iImage).data = gammacorrect(resizedImages(iImage).data);
%     gammaImages(iImage).name = resizedImages(iImage).name;
% end

%% Check Images
checkimg(resizedImages);

%% Save Images
key = 0;
while key ~= 1
    key = input('SAVE? (yes=1, no=0): ');
    if key == 1
        saveDir = uigetdir(imgDir, 'Select a Direcotry to Save Images');
        for iImage = 1:nImages
            imwrite(resizedImages(iImage).data, [saveDir filesep resizedImages(iImage).name]);
        end
    elseif key == 0
        break;
    else
        display('Please answer 0 or 1!');
    end
end