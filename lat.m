function imageBW = lat(imageGray)
% Locally Adaptive Thresholding
  globalLevel = graythresh(imageGray);
  imageBW = im2bw(imageGray,globalLevel);

  [height, width] = size(imageGray);
  windowSize = round((height + width)/100);

  for y = 1:windowSize:(height-1)
    for x = 1:windowSize:(width-1)
      upperY = y + windowSize - 1;
      if (upperY > height) upperY = height; end
      upperX = x + windowSize - 1;
      if (upperX > width) upperX = width; end
      subImg = imageGray(y:upperY,x:upperX);
      variance = var(double(subImg(:)));
      if (variance > 50)
          subLevel = graythresh(subImg);
      else
          subLevel = globalLevel;
      end
      subBin = im2bw(subImg,subLevel);
      imageBW(y:upperY,x:upperX) = subBin;
    end
  end
end

