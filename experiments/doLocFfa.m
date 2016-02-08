function expConditions = doLocFfa(Params)
% Present images (JPEG format) on a screen.
% Supported by Psychophysics Toolbox Version 3 (PTB-3).
%
% <Syntax> stimlogName = PFpresentation02
% 
% <Description>
% stimlogName = PFpresentation02 displays images in a folder selected by
% user. It opens a uigetfile dialog for user to select a setup file,
% where parameters for presentation is defined. Please read description in
% the setup file for the details of those parameters. At the end of the
% program, PFpresentation02 saves some variables as a logfile, which is
% automatically named 'yyyymmddTHHMMSS.mat' standing for the Date/Time when
% the logfile was saved.

% Get images
Images = getimg(Params.imgDir, Params.imgExtension, Params.nSelectImages);

% Scramble images
scrambledImagesOut = scrambleImages(Images, Params.numTiles);

% Randomization of the images
sortedImages = sortimg([Images, scrambledImagesOut], Params.nRepitition, Params.pBlank, Params.continuity);

%resize images
resizedImages = resizeimages(sortedImages, Params.rowSize);

% Compute mean luminance
resizedImages = computeimagefeatures(resizedImages);

% Start Presentation
expConditions = presentstimulus(resizedImages, Params);