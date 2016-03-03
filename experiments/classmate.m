function expConditions = classmate()

[funcDir, expname] = fileparts(mfilename('fullpath'));
Params.expname = expname;

%% Load General Settings55
Params.settingFile = [funcDir filesep 'settings' filesep 'settingForClassmate.m'];
run(Params.settingFile);

% Get subject name
Params.subjectName = char(inputdlg('Subject Name: ', mfilename));


%% Load Specific Settings
% Set image directory
Params.imgDir = fullfile(funcDir, 'images', 'Classmate');

% Set image extension
Params.imgExtension = 'jpg';

% Set resized size
Params.rowSize = 720;

% Number of repetition of each face/house stimulus
Params.nRepitition = 1;

% Flag for continuity of stimuli (0, forbidding continuity; 1, permitting continuity)
% consecutive presentation of the blank is allowed instead of 'jitter'.
Params.continuity = 0;

% Probability of blanks
Params.pBlank = 0;

% Folder where a logfile is saved.
Params.stimlogFolder= [funcDir filesep 'logs' filesep 'logClassmate'];


%% Do Familiarity Localization
expConditions = doClassmate(Params);

end