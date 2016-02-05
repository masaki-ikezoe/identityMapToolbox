function checkUsbDeviceInputs(Devices, trig, res)
% Check inputs from USB-HID devices
% TODO: Get strings Not To Display
nDevices = length(Devices);

if nargin < 1
    if ~exist('trig', 'var')
        trig = 't';
    end
    if ~exist('res', 'var')
        res = '3#';
    end
end

% Initialise paramters
ProgKey.quit = KbName('q');
ProgKey.trig = KbName(trig);
ProgKey.res = KbName(res);

% Initiate keyboard
myKeyCheck;

% Check the input from the selected device
fprintf('#[%s] Check the input from the selected device\n', mfilename);
fprintf('deviceID, keyName, time\n');
deviceProg = 1;
while deviceProg
    % Select a device
    deviceId = input(sprintf('#Input Device ID (0 to %d; -1, all keyboards, -2, all keypads; -3, all keyboards and keypads): ', nDevices-1));
    
    % Get input from the device
    % TODO: save result ot a text file, 'fopen'
    fprintf('#Press keys to test; "%s" to quit\n', ProgKey.quit);
    iwait = 1;
    while iwait % wait for the specific key set by 'triggerKey'
        % WaitSecs(0.01); 
        % Added by MO, 10-12-2015
        [KeyIsDown, ~, KeyCode] = KbCheck(deviceId);
        if KeyIsDown
            keyStr = KbName(find(KeyCode));
            % Check Any Key Inputs
            % fprintf('%d, %s, %s\n', deviceId, keyStr, datestr(now,'HH:mm:ss.FFF'));
            
            % Check Specific keys
            if KeyCode(ProgKey.trig)
                fprintf('%d, %s, %s\n', deviceId, keyStr, datestr(now,'HH:mm:ss.FFF'));
            elseif KeyCode(ProgKey.res)
                fprintf('%d, %s, %s\n', deviceId, keyStr, datestr(now,'HH:mm:ss.FFF'));
            else
                %fprintf('%d, %s, %s\n', deviceId, keyStr, datestr(now,'HH:mm:ss.FFF'));
            end;
        end;
        
        % To exit
        [KeyIsDown, ~, KeyCode] = KbCheck(deviceId);
        if KeyIsDown && KeyCode(ProgKey.quit)
            iwait = 0;
        end
    end
    deviceProg = input('#Check another device? (Yes=1/No=0): ');
end

end