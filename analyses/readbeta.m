function selectedBeta = readbeta(roi, c, nSessions, pathstr)

if ~exist('pathstr', 'var')
    pathstr = pwd;
end

%% read beta
% Select image files
spmBeta_image = spm_select(Inf, 'image', 'Select Beta of the "identities" task', {}, pathstr, 'beta_*.*');

% Get header information for images
spmBeta_header = spm_vol(spmBeta_image);

% Read in entire image volumes
[spmBeta_vols, spmBeta_loc] = spm_read_vols(spmBeta_header);

% Check an image
% image = imageVols(:,:,20,50);
% pcolor(image);

[nX, nY, nZ, nBeta] = size(spmBeta_vols);

% Select beta in ROI
selectedBeta = [];
for iBeta = 1:nBeta
    tmp = spmBeta_vols(:, :, :, iBeta);
    tmp = tmp(:);
    selectedBeta = [selectedBeta, tmp(logical(roi(:)))];
end

% Select beta according to contrast
if exist('c', 'var')
    c = logical(c);
    selectedBeta = selectedBeta(:, c);
end

end
