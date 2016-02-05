%% Initialize paramters
clear; close all; clc;
startPath = fullfile('/home/mokamoto/data');

%% Create ROI based on a localizer task
tVal = 5.00; % TODO: You have to change this value; 3.14 for FFA, 3.15 for Familiarity
roiPath = startPath;
roi = createroi(tVal, roiPath);

%% Select Beta of the "identities" task
nBetaOneSession = 53; % TODO: You have to change this value
nSessions = 6; % TODO: Change it, if you need.
c = repmat([ones(1, nBetaOneSession), zeros(1, 6)], 1, nSessions);
betaPath = startPath;
spmBeta = readbeta(roi, c, nSessions, betaPath)'; % beta in rows; voxels in columns
% Exclude columns with NaN
isNanColumn = logical(isnan(sum(spmBeta)));
spmBeta = spmBeta(:, ~isNanColumn);
% Average Beta over Sessions
[nBetaAllSessions, nVoxels] = size(spmBeta);
tmp = zeros(nBetaOneSession, nVoxels);
for iSession = 1:nSessions
    tmp = tmp + spmBeta(1+(iSession-1)*nBetaOneSession:iSession*nBetaOneSession, :); 
end
spmBeta = tmp/nSessions;

%% Dendrogram
% Agglomerative hierarchical cluster tree
Z = linkage(spmBeta, 'single'); % variables in columns, observations in rows
% Add label to each entries (i.e. identities)
[conditionfile, conditionpath] = uigetfile(startPath, 'Select a Condition file', 'MultiSelect', 'on');
load([conditionpath, conditionfile], 'names');
% Dendrogram
figure; nLabels = length(names);
dendrogram(Z, nLabels, 'Labels', names)
xlabel('identities'); ylabel('Distance');

%% Perform PCA decomposition
% PCA: scrs = spmBeta * pcs
X = spmBeta'; % spmBeta: beta (indivuduals) in rows, voxels in columns
[pcs, scrs, vexp] = pca(X);

%% Percent variance explained
pexp = 100*vexp/sum(vexp);
explained = cumsum(pexp');

%% Visualize variance explained with Pareto chart
figure
pareto(vexp);
xlabel('Principal Component');
ylabel('Variance Explained (%)');

%% Visualize first 3 principal components with biplot
figure
subplot(2,2,1)
biplot(pcs(:,1:3)) 
xlabel('Component 1')
ylabel('Component 2')
zlabel('Component 3')

subplot(2,2,2)
biplot(pcs(:,[1,3]))
xlabel('Component 1')
ylabel('Component 3')

subplot(2,2,3)
biplot(pcs(:,[2,3])) 
xlabel('Component 2')
ylabel('Component 3')

subplot(2,2,4)
biplot(pcs(:,[1,2])) 
xlabel('Component 1')
ylabel('Component 2')

%% Visualize with variable names on plot
figure
biplot(pcs(:,1:3),'VarLabels',names);

%% Visualize PCA coefficients of each variable with heatmap
figure
imagesc(abs(pcs(:,1:3)))
colorbar
ax = gca;
ax.YTick = 1:53;
ax.YTickLabel = names;
ax.XTick = 1:3;
xlabel('Principal Component')
ylabel('Variable')

%% Visualize pca scores with parallel coordinates plot
facebooklistTbl = readtable('facebooklist.xlsx');
missIdx = ismissing(facebooklistTbl);
idLabels = facebooklistTbl.Category(missIdx(:, 10) & facebooklistTbl.selectedImage02 == 1);
idLabels = categorical(facebooklistTbl.Category);

figure
parallelcoords(scrs, 'Quantile', 0.25);
%parallelcoords(scrs,'Group',qclabel,'Quantile',0.25)   

%% Visualize pca scores from original data with parallel coordinates plot
figure
parallelcoords(X, 'Standardize', 'PCA', 'Quantile', 0.25);
%parallelcoords(measurements,'Group',qclabel,'Standardize','PCA','Quantile',0.25)
