function names = createnames(expConditions, expName)

switch expName
    case 'identities'
        % Extract a stimulus table
        stimTbl = expConditions.stim;
        % Extract unique indentities
        identities = unique(stimTbl.filename);
        identities = identities(~strcmp(identities, 'blank'));
        [~, names_tmp, ~] = cellfun(@fileparts, identities, 'UniformOutput', false);
        names = names_tmp';
        
    case 'locFamil'
        names = {'Friend', 'Not Friend'};
        
    case 'locFfa'
        names = {'Faces', 'Scrambled Faces'};
end