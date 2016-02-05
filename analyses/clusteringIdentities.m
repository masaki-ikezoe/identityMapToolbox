clear; close all; clc;

%% Initialize
driveName = 'C:';
dataDir = 'data';
projectDir = 'identityMap';
initPath = [driveName filesep dataDir filesep projectDir];

%% Load data
[dataFileName, dataPathName] = uigetfile([initPath filesep '*.mat'], 'Select a Data File');
load([dataPathName dataFileName]);

%% Load label
% labelpath = fileparts(mfilename('fullpath'));
% [labelfile, labelpath] = uigetfile(labelpath, 'Select a Label');
% labeltable = readtable([labelpath labelfile]);
labelTbl = ThetaResults.labelsTrain;
nLabels = height(labelTbl);

%% Choose voxels
voxelId = (ThetaResults.pval < 5E-10);

%% Create heirarchical tree by finding linkage between neighboring points
X = ThetaResults.theta(2:nLabels+1, voxelId);
% Use Wards linkage, euclidean distance metric
Z = linkage(X,'ward'); 

%% Create dendrogram
figure
dendrogram(Z, nLabels, 'Labels', labelTbl.identities)
xlabel('Observations')
ylabel('Distance')

%% Evaluate quality of hierarchical structure
Y = pdist(X);
c = cophenet(Z,Y);
fprintf('CPCC is: %f\n', c);

%% Cluster the linkage into 2 clusters
% grp = cluster(Z,'maxclust',2);

%% Interpret cluster grouping
% View the clusters by color
% figure
% dendrogram(Z,'ColorThreshold',9)
% 
% % Compare clusters to wine type (red/white)
% counts = crosstab(grp,wineinfo(idx));
% figure
% bar(counts,'stacked')
% legend(categories(wineinfo),'Location','EastOutside')
% xlabel('Cluster')

