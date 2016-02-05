%% Load head movement
[filename, pathstr] = uigetfile('C:\data\*.txt', 'Select a headmotion file');
headmotiondata = load([pathstr filename]);
nData = length(headmotiondata);

%% Load experimental conditions
[filename, pathstr] = uigetfile([pathstr '*.mat'], 'Select a log file');
load([pathstr filename]);

% Load image data
stim = expConditions.stim;
nStims = height(stim);
imgluminance = ones(nData, 1)*255;
imgcontrast = zeros(nData, 1);
imgluminance(1:nStims) = stim.imgluminance;
imgcontrast(1:nStims) = stim.imgcontrast;

%% Conbine data
R = [headmotiondata imgluminance imgcontrast];

%% Save 
save([pathstr 'multipleregressors.mat'], 'R');