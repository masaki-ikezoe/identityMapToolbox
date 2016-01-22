function [reshapedBeta, imageLoc] = readbeta()
% Select image files
imageFiles = spm_select(Inf, 'image');

% Get header information for images
Volumes = spm_vol(imageFiles);

% Read in entire image volumes
[imageVols, imageLoc] = spm_read_vols(Volumes);

% Check an image
% image = imageVols(:,:,20,50);
% pcolor(image);

[nX,nY,nZ,nBeta] = size(imageVols);

reshapedBeta = reshape(imageVols,nX*nY*nZ,nBeta)';
