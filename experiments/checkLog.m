function [SOAs,table_sorted] = CheckLog
% PFpresentation�̎��s�Ő������ꂽlog�t�@�C���̓��e���`�F�b�N���܂��B
% [table, SOAs] = ChecLog;
%
% �Ԃ�l"SOAs"�̗v�f�̓V���A���ȓ��t�ԍ��ł��B
% datestr�֐��Ȃǂ��g���āA�ʏ�̎��ԕ\�L�ɂ��邱�Ƃ��ł��܂��B
% ��: >> datestr(SOAs, 'HH:MM:SS.FFF');
% �܂��A�ȉ��̂悤�ɂ��ĕ���SOA�����߂邱�Ƃ��ł��܂��B
% ��F>> averageSOA = datestr(mean(SOAs), 'HH:MM:SS.FFF');

clear all;
%---------�ȉ��v���O����--------

%-----log�t�@�C���̓ǂݍ���------
[logFile, logFolder] = uigetfile('C:\DATA\fMRI\log\PFpresentation\*.mat','Pick a log file');
load([logFolder logFile]);

Ntrials = size(Stim, 2);

%----�o���p�x�̃`�F�b�N------
% �摜�t�@�C���̃J�e�S����掦���ꂽ���Ԃɓǂݍ��݂܂��B
categories = imgFileNames(:,1:4);

% �摜�t�@�C���̏o���p�x���e�J�e�S���[���ƂɎ����܂��B
table = tabulate(categories);
[~, idx] = sort(table(:,1));
table_sorted = table(idx,:);
figure; subplot(2,2,1); bar(cell2mat(table_sorted(:,2)));
title('Category');
%----------------------------

%----���ԁiSOA�j�̃`�F�b�N-----
StimOnsets = zeros(1, Ntrials);
for k = 1:Ntrials
    StimOnsets(k) = Stim(k).StimulusOnsetTime;
end
SOAs = diff(StimOnsets);
subplot(2,2,2); hist(SOAs);
title('SOA');
%-----------------------------

%----�덷�̃`�F�b�N------------
errors = SOAs - (durationSecs + intervalSecs);
subplot(2,2,3); hist(errors);
title('errors of SOA');
%-----------------------------

%---duration�̃`�F�b�N---------
StimDurations = zeros(1, Ntrials);
for k = 1:Ntrials
    StimDurations(k) = Blank(k).StimulusOnsetTime - Stim(k).StimulusOnsetTime;
end
subplot(2,2,4); hist(StimDurations);
title('stimulus duration');
%-----------------------------

%------Parameters for Multiple condisions (SPM)-------------
% Three parameters, names, onsets, and durations, are required for the SPM
% analysis.

% for 'names'; names = cell(1, Nimages); names{2} = '0102_Father.jpg'
% get image names from an image folder and create list of the names
imgFileListStruct = dir([imgFolderName '*.jpg']); % Data type is structure; Fields are name, date, bytes, isdir, datenum.
imgFileListCell = struct2cell(imgFileListStruct); % The output cell is a 5*Nimages array.
names = imgFileListCell(1, :);
Nstim = size(names, 2);

% for 'onsets'; onsets = cell(1, Nimages); onsets{2} = [85 122 145 267 279]
StimCell = struct2cell(Stim); % The output is a 5*1*Ntrials array.
VBLtimestamps = reshape(cell2mat(StimCell(1, 1, :)), 1, size(StimCell, 3));
onsets = cell(1, Nstim);
for k = 1:Nstim
    LogicInd = strncmp(names(k), imgFileNames, length(char(names(k))));
    onsets{1, k} = round(VBLtimestamps(LogicInd) - VBLtimestamps(1));
end

% for 'durations'; durations = cell(1, Nimages); durations{2} = [0.5 0.5 0.5 0.5 0.5]
durations = cell(1, Nstim);
for k = 1:Nstim
    durations{k} = repmat(round(durationSecs*100)/100, 1, size(onsets{k}, 2));
end

% for additional imformations
% source file (logfile) name
srcfile = [logFolder logFile];

% output file
output = strrep(logFile, '.mat', 'info.mat');

% save the info file
[outputFileName, outputPathName] = uiputfile('*.mat', 'Save an information file', ['C:\DATA\fMRI\log\PFpresentation\' output]); % default folder = current folder
outputfile = [outputPathName outputFileName];
save(outputfile, 'names', 'onsets', 'durations', 'srcfile', 'outputfile', 'expDuration');

fprintf('\n%s%s%s%s\n', outputFileName, ' was successfully saved in ', outputPathName, '.');