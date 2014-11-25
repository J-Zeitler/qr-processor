function decodedMessage = qrap(originalImage, windowTitle)
%qrap is a QR code image processing function.
%   @param originalImage    an image containing a QR code
%   @return decodedMessage  the decoded QR code as a string

  if nargin < 2
    windowTitle = '';
  end

  if (size(originalImage, 3) == 3)
      imageGray = rgb2gray(originalImage);
  else
      imageGray = originalImage;
  end

  level = graythresh(imageGray);
  imageBW = im2bw(imageGray, level);

  toleranceFactor = 0.3;

  [decodedMessage, succeeded] = extractMessage(imageBW, toleranceFactor, windowTitle);
  if ~succeeded
    % If message extraction with otsu's failed, try LAT
    imageBW = lat(imageGray);
    imshow(imageBW);
    decodedMessage = extractMessage(imageBW, toleranceFactor, windowTitle);
  end
end
