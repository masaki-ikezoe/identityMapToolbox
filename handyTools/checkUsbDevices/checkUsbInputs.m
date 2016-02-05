clear; close all; clc;
diary off;

%% Get USB Devices
Devices = getUsbDevices;

%% Check USB Devices
Devices = checkUsbDevices(Devices);

%% Check Imput From USB Devices
filename = ['log' filesep mfilename datestr(now, 'yyyymmddHHMM') '.txt'];

diary(filename);
checkUsbDeviceInputs(Devices, 't', '3#');
diary off;

%% Read Result
% TODO: Underconstruction
% data = readtable(filename, ...
%     'Format', '%f%q%f',...
%     'CommentStyle', '#',...
%     'Delimiter', ',',...
%     'ReadVariableNames', true);
% 

%% Figure

