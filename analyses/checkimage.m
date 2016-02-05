function checkimage(image, arrangecaxis)

if ~exist('arrangecaxis', 'var')
    arrangecaxis = 0;
end

switch arrangecaxis
    case 0
        % C-axis will be arranged in [0, 1]
        nSlices = size(image, 3);
        for iSlice = 1:nSlices
            pcolor(image(:, :, iSlice));
            caxis([0 1]); colorbar;
            pause;
        end
    case 1
        % C-axis will be arranged automatically
        nSlices = size(image, 3);
        cmin = min(min(min(image)));
        cmax = max(max(max(image)));
        for iSlice = 1:nSlices
            pcolor(image(:, :, iSlice));
            caxis([cmin cmax]); colorbar;
            pause;
        end
    otherwise
        error('"arrangecaxis shoud be 0 or 1!');
end

end