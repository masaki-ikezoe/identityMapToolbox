function expConditions = presentstimulusforclassmate(ImageData, Params)
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
    nStim = length(ImageData);
  
  %------------------------------------------------------------------------------------------------------
  % Additional Function
  % Programmed by M.Ike at 2016-02-24
   
  % Select Menu of Scale-bar
  choice = menu('Choose a type of scale bar.', 'Conversation', 'Meal', 'Document', 'Travel', 'Club');
  
  % Read Image data of Scale-bar
  if choice == 1
      ImageDataForMultiselect = imread...
          ('./images/SelectBar/multiselectbar1.png');
  elseif choice == 2
      ImageDataForMultiselect = imread...
          ('./images/SelectBar/multiselectbar2.png');
  elseif choice == 3
      ImageDataForMultiselect = imread...
          ('./images/SelectBar/multiselectbar3.png');
  elseif choice == 4
      ImageDataForMultiselect = imread...
          ('./images/SelectBar/multiselectbar4.png');
  elseif choice == 5
      ImageDataForMultiselect = imread...
          ('./images/SelectBar/multiselectbar5.png');
  end

%   ImageDataForScalebar1 = imread...
%       ('./images/ratingscale1.jpg'); % Low <--> High
%      
%   ImageDataForScalebar2 = imread...
%       ('./images/ratingscale2.jpg'); % High <--> Low   
% 
%   % Randomize Selection of Scale-bar
%   Scalebar = zeros(nStim,1);
%   RandScalebar = zeros(1,nStim);
%  
%   for iRand = 1:nStim
%       RandScalebar(iRand) = rand();
%       if RandScalebar(iRand) < 0.5
%           Scalebar(iRand,1) = 1;   % Low <--> High
%       else
%           Scalebar(iRand,1) = 2;   % High <--> Low
%       end
%   end
%  
%   % For Get Mouse position 
%   MousePosition = zeros(nStim,1);
%   
%   % For Randomize Initial Mouse Position
%   InitMousePosition = zeros(1,nStim);
%   
%   for iMouse = 1:nStim
%       InitMousePosition(iMouse) = rand*550;
%       InitMousePosition(iMouse) = InitMousePosition(iMouse) + 680 ;
%   end
%   

  % For Get Selected button
  SelectedBtn = cell(nStim,2);
    
  % Ready for Fixation
  FixCr = ones(20, 20)*255;
  FixCr(10:11, :) = 0;
  FixCr(:, 10:11) = 0; 
   
  %-----------------------------------------------------------------------------
  
  
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
      
  screenNumber = max(Screen('Screens'));
  
  %full screen mode
  [windowPtr, rect] = Screen('OpenWindow', screenNumber, Params.bgColor);
  
%   %window mode
%   [windowPtr, rect] = Screen('OpenWindow', screenNumber, Params.bgColor, [50 50 500 350]); 

  HideCursor;
  
  % define center coordinate
  [cx, cy] = RectCenter(rect);
  
  % export data to texture
%   scalebar1 = Screen('MakeTexture', windowPtr, ImageDataForScalebar1);
%   scalebar2 = Screen('MakeTexture', windowPtr, ImageDataForScalebar2);
  multiselect = Screen('MakeTexture', windowPtr, ImageDataForMultiselect);  
  fixcross = Screen('MakeTexture',windowPtr, FixCr);

  %--------------------------------------------------------------------------------------
  
%   %-------get a frame rate-----------------------------------
%   monitorFlipInterval = Screen('GetFlipInterval', windowPtr);
%   FBlankFrames = round(FBlankSecs/monitorFlipInterval);
%   LBlankFrames = round(LBlankSecs/monitorFlipInterval);
%   %----------------------------------------------------------
  
  %--------set intervals by WaitSecs('UntilTime',whenSecs)--------------------------
  whenSecs4stim = zeros(1,nStim);
  for n = 1:nStim
      whenSecs4stim(n+1) = whenSecs4stim(n) + Params.stimDuration + Params.stimInterval + rand+0.5; % Jitter On
  end
  whenSecs4stim = whenSecs4stim + Params.FBlankSecs;
  whenSecs4blank = whenSecs4stim + Params.stimDuration;
  %--------------------------------------------------------------------------------  
    
  %--------diplay for start--------------------------------------------------------------------------------
  Screen('FillRect', windowPtr, Params.bgColor);
  Screen('TextSize', windowPtr, Params.fontSize);
  DrawFormattedText(windowPtr, double(Params.strPrompt), 'center', 'center', Params.fontColor);
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
  Screen('FillRect', windowPtr, Params.bgColor);
  [FBlank.VBLTimestamp, FBlank.StimulusOnsetTime, FBlank.FlipTimestamp, FBlank.Missed, FBlank.Beampos] ... 
      = Screen('Flip',windowPtr);
  
  StartTime = now;
  
  %Hide the mouse cursor
  HideCursor;
  
  %for key response
  KbQueueCreate(); % Creates the queue
  KbQueueStart(); % Starts delivering keyboard events from the specified device to the queue.
  
  % stimulus presentation
  for k = 1:nStim
            
      % k-th image is loaded.
      %imdata = Images(order(k)).data; 
           
      % export the image data to texture
      imagetex = Screen('MakeTexture', windowPtr, ImageData(k).data);   
      
      %  Obtains data about keypresses
      [pressed, firstPress] = KbQueueCheck();
      if pressed
          if firstPress(KbName('ESCAPE'))
              error('ESC key was pressed during the operation.\n');
          elseif firstPress(KbName(Params.resKeyCode))
              fprintf('\n%s', 'key 1');
              KeyPressCount = KeyPressCount + 1;
              Key(KeyPressCount).firstPress = firstPress(KbName(Params.resKeyCode));
          end
      end
      
      HideCursor;
      
%       % Move mouse pointer on the Scale-bar
%       SetMouse(InitMousePosition(k), cy+415, screenNumber);
      
      % drawing the image
      Screen('DrawTexture', windowPtr, imagetex);    
      
      % drawing the scale
      Screen('DrawTexture', windowPtr, multiselect, [0, 0, 715, 115], [cx-357.5, cy+385, cx+357.5, cy+500]);

%       %drawing  Scale-bar
%       if Scalebar(k) == 1
%           Screen('DrawTexture', windowPtr, scalebar1, [0,0,648,117], [cx-334, cy+383, cx+314, cy+500]);
%       elseif Scalebar(k) == 2
%           Screen('DrawTexture', windowPtr, scalebar2, [0,0,648,117], [cx-334, cy+383, cx+314, cy+500]);
%       end
%     
%       % drawing the Select-bar
%       Screen('DrawTexture', windowPtr, selectbar, [],[cx-1, cy+400, cx+1, cy+430]); 

      [Stim(k).VBLTimestamp, Stim(k).StimulusOnsetTime, Stim(k).FlipTimestamp, Stim(k).Missed, Stim(k).Beampos] ...
          = Screen('Flip', windowPtr, FBlank.VBLTimestamp + whenSecs4stim(k));
      
      % Check Button Input During Stimulation
      tstim = now; % Get Stimulus Start Time
      while now <= tstim + seconds(4.97)
          [PressButton,PressSecs,ButtonName] = KbCheck;
          if PressButton == 1 
              try
                  if ~any(KbName(ButtonName) == '5')    % Not Record Trigger('5%')
                      SelectedBtn(k,1) = cellstr(KbName(find(ButtonName)));
                      SelectedBtn(k,2) = num2cell(PressSecs);
                  end
              catch  % If two or more button pressed at once
                  SelectedBtn(k,1) = cellstr('Error');
                  SelectedBtn(k,2) = num2cell(0);
              end                
          end
      end
      
      if find(cellfun('isempty',SelectedBtn(k,1)))  % If No Button Pressed
          SelectedBtn(k,1) = cellstr('NoPress');
          SelectedBtn(k,2) = num2cell(0);
      end
      
      % displaying image info on the matlab console
      % fprintf('\n%s%s%s', num2str(k), ['/' num2str(stimNum) ': '], char(imgs(order(k)).name));
      
      %ShowCursor; % FIXME: Comment-out if you need to show cursor during stim. 
     
      Screen('DrawTexture', windowPtr, fixcross);
      [Blank(k).VBLTimestamp, Blank(k).StimulusOnsetTime, Blank(k).FlipTimestamp, Blank(k).Missed, Blank(k).Beampos] ...
              = Screen('Flip', windowPtr, FBlank.VBLTimestamp + whenSecs4blank(k));
          
      % close the image texture
      Screen('Close', imagetex); 

%       % Get final mouse position
%       [finx,~,~] = GetMouse;   
%       MousePosition(k) = finx; 
%       
%       % Hide Cursor at Last Blank
%       if k == nStim
%           HideCursor;
%       end
 
      % Continue to Show Fixation until MRI working (for Jitter)
      if k == nStim  
          while now < StartTime + seconds(Params.FBlankSecs + (6.5*nStim) + Params.LBlankSecs)
              [keyIsDown, ~, keyCode] = KbCheck;
              if keyIsDown
                  if keyCode(KbName('ESCAPE'))  % If ESC pressed, finish showing fixation
                  break;
                  end
              end
          end
      end
        
  end
  
  % Draw a message "LBlankSecs [s]" after the last trial
  DrawFormattedText(windowPtr, double('Session has been completed.'), 'center', 'center', Params.fontColor);
  [LBlank.VBLTimestamp, LBlank.StimulusOnsetTime, LBlank.FlipTimestamp, LBlank.Missed, LBlank.Beampos] ...
      = Screen('Flip', windowPtr, FBlank.VBLTimestamp + whenSecs4blank(nStim) + Params.stimInterval + Params.LBlankSecs);
  EndTime = now;
  
  % Obtains data about keypresses
  [pressed, firstPress] = KbQueueCheck();
  if pressed
    if firstPress(KbName(Params.resKeyCode))
        % fprintf('\n%s', 'key 1');
        KeyPressCount = KeyPressCount + 1;
        Key(KeyPressCount).firstPress = firstPress(KbName(Params.resKeyCode));
    end
  end
  KbQueueStop(); % Stops delivery of new keyboard events from the specified device to the queue.
  KbQueueRelease(); % Releases queue-associated resources.

  %KbWait([],3);
  
  WaitSecs(2.5); 
  
  ShowCursor;
  sca;
  
  %ListenChar(0);  %Enablet to transmission of keypresses to Matlab.
  
  %--------for log file----------------------------------------------------------------------------------------------
  stimInfo = struct2table(Stim);
  sortedImagesTbl = struct2table(ImageData);
  stimInfo.name = sortedImagesTbl.name;
  stimInfo.imgluminance = sortedImagesTbl.imgluminance;
  stimInfo.imgcontrast = sortedImagesTbl.imgcontrast;
  [stimInfo.pathstr, stimInfo.filename, stimInfo.ext] = cellfun(@fileparts, stimInfo.name, 'UniformOutput', false); 
  stimInfo.selectedbutton = SelectedBtn(:,1);
  stimInfo.selectedtime = cell2mat(SelectedBtn(:,2));
%   stimInfo.scalebar = Scalebar;
%   stimInfo.scaleposition = MousePosition - 680; % 680 is light edge of Scale-bar
  expDuration = EndTime - StartTime; % FIXME: make the variable "duration"
  logDate = datestr(StartTime, 'yyyymmddTHHMM');
  logName = [logDate '.mat'];
  
  if choice == 1
      Selectbar = 'Conversation';
  elseif choice == 2
      Selectbar = 'Meal';
  elseif choice == 3
      Selectbar = 'Document';
  elseif choice == 4
      Selectbar = 'Travel';
  elseif choice == 5
      Selectbar = 'Club';
  end
  
  expConditions.subject = Params.subjectName;
  expConditions.settingfile = Params.settingFile;
  expConditions.imgDir = Params.imgDir;
  expConditions.logfile = [Params.stimlogFolder filesep logName];
  expConditions.duration = Params.stimDuration;
  expConditions.interval = Params.stimInterval;
  expConditions.expduration = expDuration;
  expConditions.expstart = FBlank;
  expConditions.selectbar = Selectbar;
  expConditions.stim = stimInfo;
  
%   % Set First StimulusOnsetTime is zero and calculate
%   expConditions.stim.StimulusOnsetTime = expConditions.stim.StimulusOnsetTime - expConditions.stim.StimulusOnsetTime(1);
  
  save([Params.stimlogFolder filesep logName], 'expConditions');
  
  fprintf('\n\n%s%s%s\n','The experiment was finished; It took ',datestr(expDuration,'HH:MM:SS.FFF'),'.');
  fprintf('\n%s%s%s\n','A log file was successfully saved in ',Params.stimlogFolder,'.');
  %-------------------------------------------------------------------------------------------------------------------
  
catch err
    expConditions = []; %#ok<NASGU>
    
    %clean up if error occurred
    sca; setGamma(0); Priority(0); ShowCursor;
%    warning('Error occured or ESC Pressed.');
    rethrow(err);
    
%   %ListenChar(0);  %Enable to tranmission of keypresses to Matlab
%   psychrethrow(psychlasterror);
end
