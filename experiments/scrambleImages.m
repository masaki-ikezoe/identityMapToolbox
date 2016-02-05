function ImageStructOut =  scrambleImages(ImageStruct, numTiles)

  nImages = length(ImageStruct);
  for iImage = 1:nImages
      ImageStructOut(iImage).data = imscramble(ImageStruct(iImage).data, numTiles);
      ImageStructOut(iImage).name = ['scr_' ImageStruct(iImage).name];
  end
end