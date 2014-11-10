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

FIPs = findFIPs(imageBW, toleranceFactor);
FIPColors = [1,0,0;1,1,0;0,1,0];

%APs = findAPs(imageBW, toleranceFactor);

if ~isempty(windowTitle)
  hold off;
  imshow(originalImage);
  set(gcf,'name',windowTitle,'NumberTitle','off');
  hold on;
  
  scatter(FIPs(:,2),FIPs(:,1),[],FIPColors);
  %scatter(APs(:,2),APs(:,1),'go');
end

decodedMessage = 'http://www.k?pahus.se';
end
