function [conditions] = createconditions(expName, dataDir)

%% Initialize parameters
if ~exist('dataDir', 'var')
    dataDir = fullfile('/home/mokamoto/data');
end

%% Select File
[FileName, PathName] = uigetfile(dataDir, 'Select a log file', 'MultiSelect', 'off');

%% Create conditions
% Load Stimulus 
load([PathName FileName]);
% Create names
names = createnames(expConditions, expName);
% Create sots
onsets = createonsets(expConditions, expName);
% Create durations
durations = createdurations(expConditions, expName, 0);

conditions.names = names;
conditions.onsets = onsets;
conditions.durations = durations;

%% Sove Conditions
save([PathName 'conditions.mat'], 'names', 'onsets', 'durations');

end