function [conditions] = createconditions02(expName, dataDir, flag)

%% Initialize parameters
if ~exist('dataDir', 'var')
    dataDir = fullfile('../../../../data');
else
    if isempty(dataDir)
        dataDir = fullfile('../../../../data');
    end
end

%% Select File
[FileName, PathName] = uigetfile(dataDir, 'Select a log file', 'MultiSelect', 'off');

%% Create conditions
% Load Stimulus 
load([PathName FileName]);
% Create names
names = createnames(expConditions, expName, flag);
% Create sots
onsets = createonsets(expConditions, expName, flag, names);
% Create durations
durations = createdurations(expConditions, expName, 0, flag);

conditions.names = names;
conditions.onsets = onsets;
conditions.durations = durations;

%% Sove Conditions
save([PathName 'conditions04.mat'], 'names', 'onsets', 'durations');

end