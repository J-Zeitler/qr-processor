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
AP = findAP(imageBW, 0.3, FIPs);
corners = getCorners(FIPs, AP);

qr = extractQR(imageBW, FIPs, AP);

if ~isempty(windowTitle)
  hold off;
  imshow(originalImage);
  set(gcf,'name',windowTitle,'NumberTitle','off');
  hold on;
  
  scatter(FIPs(:,2),FIPs(:,1),[],[1,0,0;1,1,0;0,1,0]);
  scatter(AP(2),AP(1),[],[0,0,1]);
  scatter(corners(:,2),corners(:,1),[],[0,1,1]);
  
  figure;
  imshow(qr);
end

decodedMessage = 'http://www.k?pahus.se';
end
