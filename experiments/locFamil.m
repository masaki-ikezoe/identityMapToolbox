function expConditions = locFamil()

[funcDir, expname] = fileparts(mfilename('fullpath'));
Params.expname = expname;

%% Load General Settings
Params.settingFile = [funcDir filesep 'settings' filesep 'setting01.m'];
run(Params.settingFile);

% Get subject name
Params.subjectName = char(inputdlg('Subject Name: ', mfilename));


%% Load Specific Settings
% Set image directory
Params.imgDir{1} = fullfile(funcDir, 'images', 'facebookProfPics', 'subject01', 'selectedImages02');
Params.imgDir{2} = fullfile(funcDir, 'images', 'facebookProfPics', 'subject02', 'selectedImages01');

% Set image extension
Params.imgExtension = 'jpg';

% Set the number of images to be selected in each directory
Params.nSelectImages = 53; % TODO: you can modify the number

% Set resized size
Params.rowSize = 720;

% Number of repetition of each face/house stimulus
Params.nRepitition = 1;

% Flag for continuity of stimuli (0, forbidding continuity; 1, permitting continuity)
% consecutive presentation of the blank is allowed instead of 'jitter'.
Params.continuity = 0;

% Probability of blanks
Params.pBlank = 0.3;

% Folder where a logfile is saved.
Params.stimlogFolder= [funcDir filesep 'logs' filesep 'logLocFamil'];


%% Do Familiarity Localization
expConditions = doLocFamil(Params);

end