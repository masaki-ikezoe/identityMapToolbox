% compareimagefeatures.m
% 
% Programed by Masaki Ikezoe
% Fukushima Med. Univ. Sch. of Med.
% (Programmed at Dept. of Neuroscience)
%
% This program estimate image luminance,contrast,standard deviation,
% kurtosis,skewness in order to create box plot
% comparing image files between two or more subjects.
%
% 2016-02-03 First Version

% FIXME: Speed up

% Initialize
clear; close all; clc;

% Load experimental conditions
[filename, pathstr] = uigetfile('../../../../data/*.mat', 'Select a log file');
load([pathstr filename]);

% Load image data
stim = expConditions.stim;
nStims = height(stim);
filenames = stim.name;

% Stimulate image features

for iStim = 1:nStims 
    if strcmp(filenames{iStim}, 'blank')
        imgluminance(iStim) = 255;
        imgcontrast(iStim) = 0;
        imgstd(iStim) = 0;
        imgkurtosis(iStim) = 0;
        imgskewness(iStim) = 0;
        
    else
        data = im2double(imresize(imread(filenames{iStim}), [720 NaN]));
        luminance = 0.3*data(:, :, 1) + 0.59*data(:, :, 2) + 0.11*data(:, :, 3);
        imgluminance(iStim) = mean2(luminance);
        lmax = max(max(luminance));
        lmin = min(min(luminance));
        imgcontrast(iStim) = (lmax - lmin)/(lmax + lmin);
        imgstd(iStim) = std(data(:));
        imgkurtosis(iStim) = kurtosis(data(:));
        imgskewness(iStim) = skewness(data(:));
        
    end
end

stimInfo.name = filenames;
stimInfo.imgluminance = (num2cell(imgluminance)).';
stimInfo.imgcontrast = (num2cell(imgcontrast)).';
stimInfo.imgstd = (num2cell(imgstd)).';
stimInfo.imgkurtosis = (num2cell(imgkurtosis)).';
stimInfo.imgskewness = (num2cell(imgskewness)).';
[stimInfo.pathstr, stimInfo.filename, stimInfo.ext] = cellfun(@fileparts, stimInfo.name, 'UniformOutput', false); 

imgFeatures = struct2table(stimInfo);

% Delete blank cells
imgFeatures(strcmp(imgFeatures.name, 'blank'),:) = [];

% Rename pathstr % FIXME: Seletctable
imgFeatures.pathstr(strcmp(imgFeatures.pathstr, '/home/mokamoto/MATLAB/myToolbox/identityMap_dev/experiments/images/facebookProfPics/subject01/selectedImages02'),:) = cellstr('subject01');
imgFeatures.pathstr(strcmp(imgFeatures.pathstr, '/home/mokamoto/MATLAB/myToolbox/identityMap_dev/experiments/images/facebookProfPics/subject02/selectedImages01'),:) = cellstr('subject02');


imgFeatures.pathstr = categorical(imgFeatures.pathstr);

% Plot boxbar 
figure('Name','Image Features Compare Plot','NumberTitle','off');
subplot(2,3,1);
boxplot(cell2mat(imgFeatures.imgluminance), imgFeatures.pathstr);
title('Mean Luminance');

subplot(2,3,2);
boxplot(cell2mat(imgFeatures.imgcontrast), imgFeatures.pathstr);
title('Contrast');

subplot(2,3,3);
boxplot(cell2mat(imgFeatures.imgstd), imgFeatures.pathstr);
title('Standard Deviation');

subplot(2,3,4);
boxplot(cell2mat(imgFeatures.imgkurtosis), imgFeatures.pathstr);
title('Kurtosis');

subplot(2,3,5);
boxplot(cell2mat(imgFeatures.imgskewness), imgFeatures.pathstr);
title('Skewness');
