function [imgs] = getimg(pathName,extension,nSelect)

try
    if ~exist('nSelect', 'var') % Select All
        if ischar(pathName)
           imgFileList = dir([pathName filesep '*.' extension]);
           imgNum = size(imgFileList, 1);
           
           for k = 1:imgNum
               imgFileName = [pathName filesep char(imgFileList(k).name)];
               imgs(k).data = imread(imgFileName);
               imgs(k).name = imgFileName;
           end
        elseif iscell(pathName)
            nDirs = length(pathName);
            for iDir = 1:nDirs
                imgDir = pathName{iDir};
                imgFileList = dir([imgDir filesep '*.' extension]);
                imgNum = size(imgFileList, 1);
                for k = 1:imgNum
                    imgFileName = [imgDir filesep imgFileList(k).name];
                    imgs(k + (iDir - 1) * imgNum).data = imread(imgFileName);
                    imgs(k + (iDir - 1) * imgNum).name = imgFileName;
                end
            end
        end
 
    elseif exist('nSelect', 'var') % Select a part of images at random
        if ischar(pathName)
           imgFileList = dir([pathName filesep '*.' extension]);
           imgNum = size(imgFileList, 1);
           imgOrder = randperm(imgNum);
           for k = 1:nSelect
               imgFileName = [pathName filesep char(imgFileList(imgOrder(k)).name)];
               imgs(k).data = imread(imgFileName);
               imgs(k).name = imgFileName;
           end
        elseif iscell(pathName)
            nDirs = length(pathName);
            for iDir = 1:nDirs
                imgDir = pathName{iDir};
                imgFileList = dir([imgDir filesep '*.' extension]);
                imgNum = size(imgFileList, 1);
                imgOrder = randperm(imgNum);
                for k = 1:nSelect
                    imgFileName = [imgDir filesep imgFileList(imgOrder(k)).name];
                    imgs(k + (iDir - 1) * nSelect).data = imread(imgFileName);
                    imgs(k + (iDir - 1) * nSelect).name = imgFileName;
                end
            end
        end
    end
    
catch
    
end
end