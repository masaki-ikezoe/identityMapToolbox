function imageStructIn = computeimagefeatures(imageStructIn)
nImages = length(imageStructIn);
for iImage = 1:nImages
    data = im2double(imageStructIn(iImage).data);
    if size(data,3) == 3
        luminance = 0.3*data(:, :, 1) + 0.59*data(:, :, 2) + 0.11*data(:, :, 3);
    elseif size(data,3) == 1
        luminance = data;
    end
    imageStructIn(iImage).imgluminance = mean2(luminance);
    lmax = max(max(luminance));
    lmin = min(min(luminance));
    imageStructIn(iImage).imgcontrast = (lmax-lmin)/(lmax+lmin); 
end
end