clear; close all; clc;
%% Set scaling factor
labelDir = 'C:\Toolbox';
[filename, pathname] = ...
    uigetfile([labelDir filesep], 'Select a Label', [labelDir filesep '*.xls']);
identityLabels = readtable([pathname filename]);
imgLabels = identityLabels(:, {'species', 'gender', 'age'});
[uniqueLabels, iImgLabels, iUniqueLabels] = unique(imgLabels);
uniqueLabels = sortrows(uniqueLabels, {'species', 'gender', 'age'});
uniqueLabels.scale =...
    [...
    0.38852361
    0.298864316
    0.298864316
    0.870890616
    0.961147639
    0.921697549
    0.569037657
    0.800956366
    0.471010161
    0.866706515
    0.895995218
    1
    0.569635386
    0.795576808
    ];
uniqueLabels.grp = (1:height(uniqueLabels))';

jointLabels = join(imgLabels, uniqueLabels);

jointLabels.Properties.RowNames = identityLabels.imageID;

%% Scale images
% Set Parameters
imgPath = pathname; % 'C:\MyPrograms\MATLAB\fMRI\PersonalFamiliarityPresentation\images08';
imgPath = uigetdir(imgPath, 'Select a Original Image Directory');
% Estension of the image files
imgExtension = 'png';

% Get Images
[Images, imgDir] = getimg(imgPath, imgExtension);
nImages = length(Images);

% Resize images
maxHeight = 720; % in pixcels
numRows = jointLabels.scale;
resizedImages = Images;
for iImage = 1:nImages
    resizedImages(iImage).data = imresize(Images(iImage).data, [maxHeight*numRows(iImage) NaN]);
    resizedImages(iImage).name = Images(iImage).name;
end

% Check Images
checkimg(resizedImages);

% Save Images
key = 0;
while key ~= 1
    key = input('SAVE? (yes=1, no=0): ');
    if key == 1
        saveDir = uigetdir(imgPath, 'Select a Direcotry to Save Images');
        for iImage = 1:nImages
            imwrite(resizedImages(iImage).data, [saveDir filesep resizedImages(iImage).name]);
        end
    elseif key == 0
        break;
    else
        display('Please answer 0 or 1!');
    end
end