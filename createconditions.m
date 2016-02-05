% This is a test comment.
clear; close all; clc;

%% Select File
[FileName,PathName] = uigetfile('MultiSelect', 'off');

%% Create conditions
% Load Stimulus 
load([PathName FileName]);
% Create names
names = createnames(expConditions);
% Create sots
onsets = createonsets(expConditions);
% Create durations
durations = createdurations(expConditions, 0);

%% Sove Conditions
save([PathName 'conditions.mat'], 'names', 'onsets', 'durations');
