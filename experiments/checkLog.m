function [SOAs,table_sorted] = CheckLog
% PFpresentationの実行で生成されたlogファイルの内容をチェックします。
% [table, SOAs] = ChecLog;
%
% 返り値"SOAs"の要素はシリアルな日付番号です。
% datestr関数などを使って、通常の時間表記にすることができます。
% 例: >> datestr(SOAs, 'HH:MM:SS.FFF');
% また、以下のようにして平均SOAを求めることができます。
% 例：>> averageSOA = datestr(mean(SOAs), 'HH:MM:SS.FFF');

clear all;
%---------以下プログラム--------

%-----logファイルの読み込み------
[logFile, logFolder] = uigetfile('C:\DATA\fMRI\log\PFpresentation\*.mat','Pick a log file');
load([logFolder logFile]);

Ntrials = size(Stim, 2);

%----出現頻度のチェック------
% 画像ファイルのカテゴリを呈示された順番に読み込みます。
categories = imgFileNames(:,1:4);

% 画像ファイルの出現頻度を各カテゴリーごとに示します。
table = tabulate(categories);
[~, idx] = sort(table(:,1));
table_sorted = table(idx,:);
figure; subplot(2,2,1); bar(cell2mat(table_sorted(:,2)));
title('Category');
%----------------------------

%----時間（SOA）のチェック-----
StimOnsets = zeros(1, Ntrials);
for k = 1:Ntrials
    StimOnsets(k) = Stim(k).StimulusOnsetTime;
end
SOAs = diff(StimOnsets);
subplot(2,2,2); hist(SOAs);
title('SOA');
%-----------------------------

%----誤差のチェック------------
errors = SOAs - (durationSecs + intervalSecs);
subplot(2,2,3); hist(errors);
title('errors of SOA');
%-----------------------------

%---durationのチェック---------
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