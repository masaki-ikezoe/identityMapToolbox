function Devices = checkUsbDevices(Devices)
% Check if the devices are internal or not.

nDevices = length(Devices);
Devices(nDevices).internal = [];
% List the devices
fprintf('[%s]: Check USB Devices [DeviceID: Product, Manufacturer, Transport]: \n', mfilename);
for n = 1:nDevices,
    fprintf(1,'   Device %d: %s, %s, %s: ',n , Devices(n).product, Devices(n).manufacturer, Devices(n).transport);
    try
        % Define external devices in advance
        internal = 0;
        if strcmpi(Devices(n).usageName, 'slave keyboard') % For Let's Note
            internal = 1;
        elseif strcmpi(Devices(n).usageName, 'slave pointer') % For Let's Note
            internal = 1;
        elseif strcmpi(Devices(n).usageName, 'master pointer') % For ZBook G14
            internal = 1;
        end;

        if internal
           fprintf('Internal\n');
           Devices(n).internal = true;
        else % we assume it is an internal device
           fprintf('External\n');
           Devices(n).internal = false;
        end;       
    catch ME
        warning(ME.identifier, ME.message);
    end;
end

end 