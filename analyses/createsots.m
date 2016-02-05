function onsets = createonsets(expConditions)
%% Extract stimulus table
stimTbl = expConditions.stim;

%% Substraction
StimulusOnsetTime = stimTbl.StimulusOnsetTime;
stimTbl.StimulusOnsetTime = StimulusOnsetTime - StimulusOnsetTime(1);

%% Extract unique indentities
identities = unique(stimTbl.name);
identities = identities(~strcmp(identities, 'blank'));
nIdentities = length(identities);

%% Make a sot array
onsets = cell(1, nIdentities);
for iIdentity = 1:nIdentities
    onsets{iIdentity} = stimTbl.StimulusOnsetTime(strcmp(stimTbl.name, identities(iIdentity)));
end
