function imageBW = lat(imageGray)
% Locally Adaptive Thresholding
  globalLevel = graythresh(imageGray);
  imageBW = im2bw(imageGray,globalLevel);

  [height, width] = size(imageGray);
  windowSize = round((height + width)/100);
  varianceThreshold = 100;
  maxExpandIter = 3;

  for y = 1:windowSize:(height-1)
    for x = 1:windowSize:(width-1)
      upperY = min(height, y + windowSize - 1);
      upperX = min(width, x + windowSize - 1);
      subImg = imageGray(y:upperY,x:upperX);
      subLevel = graythresh(subImg);
      variance = var(double(subImg(:)));
      
      expLowerY = y;
      expLowerX = x;
      expUpperY = upperY;
      expUpperX = upperX;
      i = 0;
      while (variance < varianceThreshold && i < maxExpandIter)
        expLowerY = max(1, expLowerY - windowSize);
        expUpperY = min(height, expUpperY + windowSize);
        expLowerX = max(1, expLowerX - windowSize);
        expUpperX = min(width, expUpperX + windowSize);
        expImg = imageGray(expLowerY:expUpperY,expLowerX:expUpperX);
        subLevel = graythresh(expImg);
        variance = var(double(expImg(:)));
        i = i + 1;
      end
      if (variance < varianceThreshold)
        subLevel = graythresh(imageGray);
      end
      subBin = im2bw(subImg,subLevel);
      imageBW(y:upperY,x:upperX) = subBin;
    end
  end
end

