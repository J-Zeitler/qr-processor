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

midpoints = [];

level = graythresh(imageGray);
imageBW = im2bw(imageGray, level);

height = size(imageGray,1);
width = size(imageGray,2);

ratioLimit = [0.7,1.4286];

for y = 1:height
  checkpoint = 0;
  patternSize = 0;
  counter = 0;
  for x = 1:width
    pxl = imageBW(y,x);
    if (pxl == 0)
      % black
      switch checkpoint
        case 0
          patternSize = 1;
          checkpoint = 1;
        case 1
          patternSize = patternSize + 1;
        case 2
          ratio = counter/patternSize;
          if (ratio < ratioLimit(1))
            checkpoint = 1;
            patternSize = 1;
          else
            checkpoint = 3;
            counter = 1;
          end
        case 3
          counter = counter + 1;
          ratio = counter / (patternSize * 3);
          if (ratio > ratioLimit(2))
            checkpoint = 1;
            patternSize = counter;
          end
        case 4
          ratio = counter/patternSize;
          if (ratio > ratioLimit(1) && ratio < ratioLimit(2))
            checkpoint = 5;
            counter = 1;
          else
            checkpoint = 1;
            patternSize = 1;
          end
        case 5
          counter = counter + 1;
          ratio = counter / patternSize;
          if (ratio > ratioLimit(2))
            checkpoint = 1;
            patternSize = counter;
          end
      end
    else
      % white
      switch checkpoint
        case 1
          checkpoint = 2;
          counter = 1;
        case 2
          counter = counter + 1;
          ratio = counter / patternSize;
          if (ratio > ratioLimit(2))
            checkpoint = 0;
          end
        case 3
          ratio = counter / (patternSize * 3);
          if (ratio < ratioLimit(1))
            checkpoint = 2;
            patternSize = counter;
            counter = 1;
          else
            checkpoint = 4;
            counter = 1;
          end
        case 4
          counter = counter + 1;
          ratio = counter / patternSize;
          if (ratio > ratioLimit(2))
            checkpoint = 2;
            patternSize = patternSize * 3;
          end
        case 5
          ratio = counter / patternSize;
          if (ratio < ratioLimit(1))
            checkpoint = 2;
            patternSize = counter;
          else
            % WOOOW
            candidate = [y, round(x - patternSize * 3.5)];
            if (validateY(imageBW, candidate, ratioLimit))
              midpoints = [midpoints; candidate];
            end
            checkpoint = 0;
          end
      end
    end
  end
end


if ~isempty(windowTitle)
  hold off;
  imshow(originalImage);
  set(gcf,'name',windowTitle,'NumberTitle','off');
  hold on;
  scatter(midpoints(:,2),midpoints(:,1),'ro');
end

decodedMessage = 'http://www.k?pahus.se';
end
