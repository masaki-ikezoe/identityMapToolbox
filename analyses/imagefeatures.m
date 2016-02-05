%% Load Head Movement
[filename, pathstr] = uigetfile('/home/mokamoto/data/*.txt', 'Select a headmotion file');
headmotiondata = load([pathstr filename]);
nData = length(headmotiondata);

%% Load experimental conditions
[filename, pathstr] = uigetfile('/home/mokamoto/data/*.mat', 'Select a log file');
load([pathstr filename]);

% Load image data
stim = expConditions.stim;
nStims = height(stim);
filenames = stim.name;
imgluminance = ones(nData, 1)*255;
imgcontrast = zeros(nData, 1);
for iStim = 1:nStims
    if strcmp(filenames{iStim}, 'blank')
        imgluminance(iStim) = 255;
        imgcontrast(iStim) = 0;
    else
        data = im2double(imresize(imread(filenames{iStim}), [720 NaN]));
        luminance = 0.3*data(:, :, 1) + 0.59*data(:, :, 2)+0.11*data(:, :, 3);
        imgluminance(iStim) = mean2(luminance);
        lmax = max(max(luminance));
        lmin = min(min(luminance));
        imgcontrast(iStim) = (lmax - lmin)/(lmax + lmin);
        
    end
end

% stim.imgluminance = imgluminance;
% stim.contrast = imgcontrast;

% expConditions.stim = stim;

% save('20160203T1432_new.mat', 'expConditions');

%% Conbine data
R = [headmotiondata imgluminance imgcontrast];

%% Save 
save([pathstr 'multipleregressors.mat'], 'R');