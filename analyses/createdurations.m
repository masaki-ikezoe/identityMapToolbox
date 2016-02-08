function durations = createdurations(expConditions, expName, expDuration)
%% Extract stimulus table
stimTbl = expConditions.stim;

%% Remove 'Blank'
stimTbl = stimTbl(~strcmp(stimTbl.name, 'blank'), :);

%% Separete "names" to path, name, and ext
[stimTbl.pathstr, stimTbl.filename, stimTbl.ext] = cellfun(@fileparts, stimTbl.name, 'UniformOutput', false);

%% Set durations for each conditions
% Set duration
if ~exist('expDuration', 'var')
    expDuration = expConditions.duration;
end

switch expName
    case 'identities'
        % Extract unique identities
        identities = unique(stimTbl.name);
        nIdentities = length(identities);
        durations = repmat({expDuration}, 1, nIdentities);
    case 'locFamil'
        % Familiarity areas are localised by 'Friend' vs. 'Not Friend'
        durations = cell(1, 2);
        % Friend and Non-friend faces are in the different directories
        dirId = unique(stimTbl.pathstr);
        % Friend condition
        durations{1} = repmat(expDuration, sum(strcmp(dirId{1}, stimTbl.pathstr)), 1); % for subject's fiends
        % Not-friend condition
        durations{2} = repmat(expDuration, sum(strcmp(dirId{2}, stimTbl.pathstr)), 1);
        
    case 'locFfa'
        % FFA is localized by 'Faces vs. Scrambled Faces'
        durations = cell(1, 2);
        % Faces condition
        durations{1} = repmat(expDuration, sum(~strncmp('scr_', stimTbl.name, 4)), 1);
        % Scrambled faces condition
        durations{2} = repmat(expDuration, sum(strncmp('scr_', stimTbl.name, 4)), 1);
end

end