function onsets = createonsets(expConditions, expName)
%% Extract stimulus table
stimTbl = expConditions.stim;

%% Substraction
stimTbl.VBLTimestamp = stimTbl.VBLTimestamp - stimTbl.VBLTimestamp(1);
stimTbl.StimulusOnsetTime = stimTbl.StimulusOnsetTime - stimTbl.StimulusOnsetTime(1);
stimTbl.FlipTimestamp = stimTbl.FlipTimestamp - stimTbl.FlipTimestamp(1);

%% Remove 'Blank'
stimTbl = stimTbl(~strcmp(stimTbl.name, 'blank'), :);

%% Separete "names" to path, name, and ext
[stimTbl.pathstr, stimTbl.filename, stimTbl.ext] = cellfun(@fileparts, stimTbl.name, 'UniformOutput', false);

%% Extract onsets for each condition
switch expName
    case 'identities'
        % Extract unique identities
        identities = unique(stimTbl.name);
        nIdentities = length(identities);
        % create an onset array
        onsets = cell(1, nIdentities);
        for iIdentity = 1:nIdentities
            onsets{iIdentity} = stimTbl.StimulusOnsetTime(strcmp(stimTbl.name, identities(iIdentity)));
        end
        
    case 'locFamil'
        % Familiarity areas are localised by 'Friend' vs. 'Not Friend'
        onsets = cell(1, 2);
        % Friend and Non-friend faces are in the different directories
        dirId = unique(stimTbl.pathstr);
        % Friend condition
        onsets{1} = stimTbl.StimulusOnsetTime(strcmp(dirId{1}, stimTbl.pathstr)); % for subject's fiends
        % Not-friend condition
        onsets{2} = stimTbl.StimulusOnsetTime(strcmp(dirId{2}, stimTbl.pathstr));
        
    case 'locFfa'
        % FFA is localized by 'Faces vs. Scrambled Faces'
        onsets = cell(1, 2);
        % Faces condition
        onsets{1} = stimTbl.StimulusOnsetTime(~strncmp('scr_', stimTbl.name, 4));
        % Scrambled faces condition
        onsets{2} = stimTbl.StimulusOnsetTime(strncmp('scr_', stimTbl.name, 4));
end

end
