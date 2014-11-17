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
imshow(imageBW);
imageBW = lat(imageGray);
figure;
imshow(imageBW);
pause;
figure;

toleranceFactor = 0.3;

FIPs = findFIPs(imageBW, toleranceFactor);
AP = findAP(imageBW, 0.3, FIPs);
if (size(FIPs,1) == 3 && size(AP,1) == 1)
  corners = getCorners(FIPs, AP);

  bits = extractBits(imageBW, corners);

  decodedMessage = readBits(bits);

  if ~isempty(windowTitle)
    hold off;
    imshow(originalImage);
    set(gcf,'name',windowTitle,'NumberTitle','off');
    hold on;

    scatter(FIPs(:,2),FIPs(:,1),[],[1,0,0;1,0,0;1,0,0]);
    scatter(AP(2),AP(1),[],[0,0.8,1]);
    scatter(corners(:,2),corners(:,1),[],[0,1,0]);
  end
else
  disp('Search for control points was unsuccessful');
  decodedMessage = '';
end
end
