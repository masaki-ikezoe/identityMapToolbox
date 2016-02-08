function logName = showIdentities()
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

%----start program---
try
  currentDir = fileparts(mfilename('fullpath'));
  
  %get subject name
  subjectName = char(inputdlg('Subject Name: ', mfilename));
  
  %get a setting file
  [settingFile, settingFilePath] = ...
      uigetfile([currentDir filesep 'settings' filesep '*.m'],'Pick a setting file');
  run([settingFilePath settingFile]);
  
  %set an image directory
  % imgDir = [currentDir filesep 'images' filesep 'sazaePic' filesep 'scaling'];
  
  %get images
  [Images, imgDir] = getimg(imgDir, imgExtension);
  
  %randomization of the images
  sortedImages = sortimg(Images, nRepitition, pBlank, continuity);
  nStim = length(sortedImages);
  str = datestr(seconds(FBlankSecs + nStim*(stimDuration+stimInterval) + LBlankSecs), 'HH:MM:SS.FFF');
  fprintf('It will take %s\n', str);
    
  %-------------------for increasing in speed------------------------------------------
  field1 = 'VBLTimestamp';          value1 = zeros(1, nStim);
  field2 = 'StimulusOnsetTime';     value2 = zeros(1, nStim);
  field3 = 'FlipTimestamp';         value3 = zeros(1, nStim);
  field4 = 'Missed';                value4 = zeros(1, nStim);
  field5 = 'Beampos';               value5 = zeros(1, nStim);
  Stim = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5);
  Blank = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5);
  
  Key = struct('firstPress', zeros(1,nStim));
  KeyPressCount = 0;
  %-------------------------------------------------------------------------------------
    
%   %-------For debuggin mode---------
%   Screen('Preference', 'SkipSyncTests', 1);
  
  %---------------initiation for psychtoolbox-----------------------------------------------
  AssertOpenGL;
  
  % Setting for the synchronizing test
  maxStddev = 0.001;  % [s],  defualt = 0.001 [s]
  minSamples = 50;    % #,    defualt = 50
  maxDeviation = 0.1; %       defualt = 0.1
  maxDuration = 5;    % [s],  defualt = 5
  Screen('Preference','SyncTestSettings', maxStddev, minSamples, maxDeviation, maxDuration);

  KbName('UnifyKeyNames'); %trying to use a mostly shared name mapping
  
%   ListenChar(2); %Disable transmission of keypresses to Matlab.
%   If your script should abort and your keyboad is dead, press CTRL+C to reenable keybord input. 
%   ListenChar(0); shoud be added to the end of your script to enable transmission of
%   keypresses to Matlab.
  
  myKeyCheck;
  
  %Do dummy calls to GetSecs, WaitSecs, KbCheck to make sure
  %they are loaded and ready when we need them - without delays
  %in the wrong moment:
  KbCheck;
  WaitSecs(0.1);
  GetSecs;
  
  %Hide the mouse cursor
  HideCursor([0],[])t;
    
  screenNumber = max(Screen('Screens'));
  windowPtr = Screen('OpenWindow', screenNumber, bgColor);                  %full screen mode
  %windowPtr = Screen('OpenWindow', screenNumber, bgColor, [50 50 500 350]); %window mode
  %--------------------------------------------------------------------------------------
  
%   %-------get a frame rate-----------------------------
%   monitorFlipInterval = Screen('GetFlipInterval', windowPtr);
%   FBlankFrames = round(FBlankSecs/monitorFlipInterval);
%   LBlankFrames = round(LBlankSecs/monitorFlipInterval);
%   %----------------------------------------------------------
  
  %--------set intervals by WaitSecs('UntilTime',whenSecs)------
  whenSecs4stim = zeros(1,nStim);
  for n = 1:nStim
      whenSecs4stim(n+1) = whenSecs4stim(n) + stimDuration + stimInterval + rand;
  end
  whenSecs4stim = whenSecs4stim + FBlankSecs;
  whenSecs4blank = whenSecs4stim + stimDuration;
  %--------------------------------------------------------------------------------  
    
  %--------diplay for start------------------------------------------------------------------------
  Screen('FillRect', windowPtr, bgColor);
  Screen('TextSize', windowPtr, fontSize);
  DrawFormattedText(windowPtr, double(strPrompt), 'center', 'center', fontColor);
  Screen('Flip', windowPtr);
  
  while KbCheck; end; %If any kes is pressed, KbCheck returns 1.
  
  while 1 %start by pressing "5"
      [keyIsDown, ~, keyCode] = KbCheck;
      
      if keyIsDown
          if keyCode(KbName('ESCAPE'))
              error('ESC key was pressed');
          end
          break;
      end;
  end;
  %----------------------------------------------------------------------------------------------------------
  
  %------start presentation----------------------------------------------------------------------------------
  % blank screen
  Screen('FillRect', windowPtr, bgColor);
  [FBlank.VBLTimestamp, FBlank.StimulusOnsetTime, FBlank.FlipTimestamp, FBlank.Missed, FBlank.Beampos] = Screen('Flip',windowPtr);
  StartTime = now;
  
  % for key response
  KbQueueCreate(); % Creates the queue
  KbQueueStart(); % Starts delivering keyboard events from the specified device to the queue.
  
  % stimulus presentation
  for k = 1:nStim
      % k-th image is loaded.
      %imdata = Images(order(k)).data;
      
      % export the image data to texture
      imagetex = Screen('MakeTexture', windowPtr, sortedImages(k).data);
      
      %  Obtains data about keypresses
      [pressed, firstPress] = KbQueueCheck();
      if pressed
          if firstPress(KbName('ESCAPE'))
              error('ESC key was pressed during the operation.\n');
          elseif firstPress(KbName(ResKeyCode))
              fprintf('\n%s', 'key 1');
              KeyPressCount = KeyPressCount + 1;
              Key(KeyPressCount).firstPress = firstPress(KbName(ResKeyCode));
          end
      end
      
      % drawing the image
      Screen('DrawTexture', windowPtr, imagetex);
      [Stim(k).VBLTimestamp, Stim(k).StimulusOnsetTime, Stim(k).FlipTimestamp, Stim(k).Missed, Stim(k).Beampos] ...
          = Screen('Flip', windowPtr, FBlank.VBLTimestamp + whenSecs4stim(k));
      
      % displaying image info on the matlab console
      % fprintf('\n%s%s%s', num2str(k), ['/' num2str(stimNum) ': '], char(imgs(order(k)).name));
      
      % blank screen for inter-stimulus interval
      Screen('FillRect', windowPtr, bgColor);
      [Blank(k).VBLTimestamp, Blank(k).StimulusOnsetTime, Blank(k).FlipTimestamp, Blank(k).Missed, Blank(k).Beampos] ...
          = Screen('Flip', windowPtr, FBlank.VBLTimestamp + whenSecs4blank(k));
      
      % close the image texture
      Screen('Close', imagetex);
      
  end
  
  % Draw a message "LBlankSecs [s]" after the last trial
  DrawFormattedText(windowPtr, double('Session has been completed.'), 'center', 'center', fontColor);
  [LBlank.VBLTimestamp, LBlank.StimulusOnsetTime, LBlank.FlipTimestamp, LBlank.Missed, LBlank.Beampos] ...
      = Screen('Flip', windowPtr, FBlank.VBLTimestamp + whenSecs4stim(nStim) + stimDuration + stimInterval + LBlankSecs);
  EndTime = now;
  
  % Obtains data about keypresses
  [pressed, firstPress] = KbQueueCheck();
  if pressed
    if firstPress(KbName(ResKeyCode))
        % fprintf('\n%s', 'key 1');
        KeyPressCount = KeyPressCount + 1;
        Key(KeyPressCount).firstPress = firstPress(KbName(ResKeyCode));
    end
  end
  KbQueueStop(); % Stops delivery of new keyboard events from the specified device to the queue.
  KbQueueRelease(); % Releases queue-associated resources.

  %KbWait([],3);
  
  sca;
  ShowCursor;
  %ListenChar(0);  %Enablet to transmission of keypresses to Matlab.
  
  %--------for log file-------
  stimInfo = struct2table(Stim);
  sortedImagesTbl = struct2table(sortedImages);
  stimInfo.name = sortedImagesTbl.name;
  expDuration = EndTime - StartTime;
  
  logDate = datestr(StartTime, 'yyyymmddTHHMM');
  logName = [logDate '.mat'];
  
  expConditions.subject = subjectName;
  expConditions.settingfile = [settingFilePath settingFile];
  expConditions.imgDir = imgDir;
  expConditions.logfile = [stimlogFolder filesep logName];
  expConditions.duration = stimDuration;
  expConditions.interval = stimInterval;
  expConditions.expduration = expDuration;
  expConditions.expstart = FBlank;
  expConditions.stim = stimInfo;
  
  save([stimlogFolder filesep logName], 'expConditions');
  
  fprintf('\n\n%s%s%s\n','The experiment was finished; It took ',datestr(expDuration,'HH:MM:SS.FFF'),'.');
  fprintf('\n%s%s%s\n','A log file was successfully saved in ',stimlogFolder,'.');
  %-----------------------------
  
catch
% clean up if error occurred
    Screen('CloseAll');  ShowCursor;
    warning('Error occured or ESC Pressed.');
%   %ListenChar(0);  %Enable to tranmission of keypresses to Matlab
%   psychrethrow(psychlasterror);
end
