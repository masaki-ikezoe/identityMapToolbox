function checkimg(Images)
% Present an image (PNG format) on a screen for confirmation.
% Supported by Psychophysics Toolbox Version 3 (PTB-3).
%
% <Syntax> CHECIIMG(Images)
% 
% <Description>
% CHECKIMG displays images. It is used for
% confirmation of the images, such as size, color etc.

% set up parameters
% back ground color
bgColor = [255 255 255];
% font size for messages
fontSize = 30;
% fot color for message
fontColor = [1 1 1]; 
% Number of images
nImages = length(Images);

%----start program---
try
  %---------------initiation for psychtoolbox-----------------------------------------------
  AssertOpenGL;
  
  Screen('Preference', 'SkipSyncTests', 1)
  
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
  HideCursor;
    
  screenNumber = max(Screen('Screens'));
  %full screen mode
  windowPtr = Screen('OpenWindow', screenNumber, bgColor);
  %window mode
  %windowPtr = Screen('OpenWindow', screenNumber, bgColor, [50 50 500 350]);
  %--------------------------------------------------------------------------------------
  
  %--------diplay for start------------------------------------------------------------------------
  Screen('FillRect', windowPtr, bgColor);
  Screen('TextSize', windowPtr, fontSize);
  DrawFormattedText(windowPtr, double('Press Any Key To Start.'), 'center', 'center', fontColor);
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
    
  % stimulus presentation
  for k = 1:nImages
      
      while KbCheck; end; %If any kes is pressed, KbCheck returns 1.
      
      % k-th image is loaded.
      imdata = Images(k).data;
      
      % export the image data to texture
      imagetex = Screen('MakeTexture', windowPtr, imdata);
      
      % drawing the image
      Screen('DrawTexture', windowPtr, imagetex);
      Screen('Flip', windowPtr);
      
      % displaying image info on the matlab console
      fprintf('\n%s%s%s', num2str(k), ['/' num2str(nImages) ': '], char(Images(k).name));
      
      while 1 %start by pressing "5"
      [keyIsDown, ~, keyCode] = KbCheck;
      if keyIsDown
          if keyCode(KbName('ESCAPE'))
              break; %error('ESC key was pressed');
          end
          break;
      end;
      end;
      
      % close the image texture
      Screen('Close', imagetex);
      
  end
  
%   % Draw a message "LBlankSecs [s]" after the onset of the last stimulus
%   DrawFormattedText(windowPtr, double('Session has been completed.'), 'center', 'center', fontColor);
%   [LBlank.VBLTimestamp, LBlank.StimulusOnsetTime, LBlank.FlipTimestamp, LBlank.Missed, LBlank.Beampos] ...
%       = Screen('Flip', windowPtr, FBlank.VBLTimestamp + whenSecs4stim(stimNum) + LBlankSecs);

  %KbWait([],3);
  
  sca;
  ShowCursor;
  %ListenChar(0);  %Enablet to transmission of keypresses to Matlab.
    
catch
  sca;
  %ListenChar(0);  %Enable to tranmission of keypresses to Matlab
  psychrethrow(psychlasterror);
end
