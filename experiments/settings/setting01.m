% This is a setup file for parameters in PFpresentation

%---------------Parameters for getting image files-------------------------
% Absolute path where the image files are located
Params.startPath = fullfile('/', 'home', 'mokamoto');
%--------------------------------------------------------------------------

%---------------Parameters for presentation of the images------------------
% Duration of stimulus presentation [s]
Params.stimDuration = 1.500;
Params.stimInterval = 1.500;
%--------------------------------------------------------------------------

%---------------Parameters for KbCheck-------------------------------------
% a key for starting the program
startKey = '5';
Params.startKeyCode = KbName(startKey);
% a key for subject to response
resKey = '3';   % for right-handed 
Params.resKeyCode = KbName(resKey);
Params.strPrompt = sprintf('Press "%s" key to start.\nPress "%s" key to quit.\nPress "%s" key to response.', startKey, 'Esc', resKey);
%--------------------------------------------------------------------------

% Duration from pressing the start key to presentaion of the first
% stimulus [s]
Params.FBlankSecs = 12.0;
% Duration from dissapering the last stimulus to the message informing the
% end of the experiment [s]
Params.LBlankSecs = 12.0;

% back ground color
Params.bgColor = [255 255 255];
% font size for messages
Params.fontSize = 30;
% fot color for message
Params.fontColor = [1 1 1]; 
