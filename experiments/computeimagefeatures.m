function imageStructIn = computeimagefeatures(imageStructIn)
nImages = length(imageStructIn);
for iImage = 1:nImages
    data = im2double(imageStructIn(iImage).data);
    luminance = 0.3*data(:, :, 1) + 0.59*data(:, :, 2) + 0.11*data(:, :, 3);
    imageStructIn(iImage).imgluminance = mean2(luminance);
    lmax = max(max(luminance));
    lmin = min(min(luminance));
    imageStructIn(iImage).imgcontrast = (lmax-lmin)/(lmax+lmin); 
end
end