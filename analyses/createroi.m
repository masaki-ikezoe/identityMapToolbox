function roi_masked = createroi(tVal, pathstr)

if ~exist('pathstr', 'var')
    pathstr = pwd;
end

%% Load a spmT image
% Select a spmT image file
spmT_image = spm_select(1, 'image', 'Select a spmT image for ROI', {}, pathstr, 'spmT*.*');
% Get header information
spmT_header = spm_vol(spmT_image);
% Read the Volume
[spmT_vols, spmT_loc] = spm_read_vols(spmT_header);
% % Check the Image
% checkimage(spmT_vols, 1);

%% Apply a threshold on the spmT
roi = spmT_vols > tVal;
% % Check the ROI
% checkimage(roi, 0);

%% Load a Mask image
% Set a mask image
mask_image = [fileparts(spmT_image) filesep 'mask.nii,1'];
% Get header information
mask_header = spm_vol(mask_image);
% Read the Mask
[mask_vols, mask_loc] = spm_read_vols(mask_header);
% % Check the Mask
% checkimage(mask_vols);

%% Create a ROI
roi_masked = roi .* mask_vols;
% % Check the created ROI
% checkimage(roi_new, 0);
end