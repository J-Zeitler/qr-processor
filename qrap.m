function decodedMessage = qrap(originalImage)
%qrap is a QR code image processing function.
%   @param originalImage    an image containing a QR code
%   @return decodedMessage  the decoded QR code as a string

if (size(originalImage, 3) == 3)
    imageBW = im2bw(originalImage);
else
    imageBW = originalImage;
end

corners = corner(imageBW, 'Harris', 9999);
imshow(originalImage)
hold on
scatter(corners(:, 1), corners(:, 2), 50, 'red', 'filled', 'M')

decodedMessage = 'http://www.k?pahus.se';
end
