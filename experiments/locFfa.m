function expConditions = locFfa()

[funcDir, expname] = fileparts(mfilename('fullpath'));
Params.expname = expname;

%% Load General Settings
Params.settingFile = [funcDir filesep 'settings' filesep 'setting01.m'];
run(Params.settingFile);

% Get subject name
Params.subjectName = char(inputdlg('Subject Name: ', mfilename));


%% Load Specific Settings
% Set image directory
Params.imgDir{1} = fullfile(Params.startPath, 'stim', 'ImageDB', 'JPG', 'jpgfaces', 'child');
Params.imgDir{2} = fullfile(Params.startPath, 'stim', 'ImageDB', 'JPG', 'jpgfaces', 'man');
Params.imgDir{3} = fullfile(Params.startPath, 'stim', 'ImageDB', 'JPG', 'jpgfaces', 'woman');

% Set image extension
Params.imgExtension = 'jpg';

% Set resized size
Params.rowSize = 720;

% Set number of tiles
Params.numTiles = 10;

% Set the number of images to be selected
Params.nSelectImages = 8; % TODO: you can modify the number

% Number of repetition of each face/house stimulus
Params.nRepitition = 1;

% Flag for continuity of stimuli (0, forbidding continuity; 1, permitting continuity)
% consecutive presentation of the blank is allowed instead of 'jitter'.
Params.continuity = 0;

% Probability of the blanks
Params.pBlank = 0.3;

% back ground color
% Params.bgColor = [128 128 128]; % TODO: Change to gray color, if you want

% Folder where a logfile is saved.
Params.stimlogFolder= fullfile(Params.startPath, 'logs', 'logLocFfa');

%% Do Familiarity Localization
expConditions = doLocFfa(Params);

end