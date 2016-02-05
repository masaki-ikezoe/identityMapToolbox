function AllDevices = getUsbDevices
% Want: Check input from USB-HID devices

% Check USB-HID devices
LoadPsychHID;               % for the Error Message: Invalid MEX-file
AllDevices = PsychHID('Devices', 1);    % get all devices
nDevices = length(AllDevices);
if nDevices == 0, disp('No Devices'); return; end;

end


% 
% % Check the input from the selected device
% quitProgKey = KbName('q');
% checkDeviceProg = 1;
% while checkDeviceProg
%     % Select a device
%     deviceId = input(sprintf('Input Device ID (1 to %d): ', nDevices));
%     
%     % Get input from the device
%     disp('Press any key to test; ''q'' to quit');
%     iwait = 1;
%     while iwait % wait for the specific key set by 'triggerKey'
%         WaitSecs(0.01); 
%         % Added by MO, 5-15-2015
%         [exKeyIsDown, ~, exKeyCode] = PsychHID('KbCheck', deviceId);
%         if exKeyIsDown
%             str = KbName(find(exKeyCode));
%             if ischar(str), str = {str}; end
%             for ii = 1:length(str)
%                 % Display the input
%                 fprintf('''%s'' was pressed\n', str{ii});
%             end
%         end
%         [inKeyIsDown, ~, inKeyCode] = KbCheck();
%         if inKeyIsDown
%             if inKeyCode(quitProgKey)
%                 iwait = 0;
%                 %quitProg = 1;
%                 %break; % out of while loop
%             end;
%         end;
%     end
%     checkDeviceProg = input('Check another device? (Yes=1/No=0): ');
% end
