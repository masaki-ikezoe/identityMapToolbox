clear; close all; clc;
startPath = '/home/mokamoto/stim/ImageDB/JPG/';
%% Load Images
% Select a source directory
srcDir = uigetdir(startPath, 'Select a Source Directory');

% Select a destination directory
destDir = uigetdir(startPath, 'Select a Destination Directory');

% Select image files
ImageFiles = dir([srcDir filesep '*.jpg']);
nFiles = length(ImageFiles);

for iImage = 1:nFiles
    % Load images
    imageData = imread([srcDir filesep ImageFiles(iImage).name]);
    
    % Scramble them
    scrambledImage = imscramble(imageData,10);
    
    % Save the scrambled images
    imwrite(scrambledImage,[destDir filesep  ImageFiles(iImage).name], 'jpg');
end