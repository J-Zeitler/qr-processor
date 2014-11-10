function aps = findAPs(imageBW, toleranceFactor)
  if (toleranceFactor > 0 && toleranceFactor < 1)
    tolerance = [1-toleranceFactor, 1/(1-toleranceFactor)];
  else
    tolerance = [0.7, 1/0.7];
  end
  aps = [];

  height = size(imageBW,1);
  width = size(imageBW,2);

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
            if (ratio < tolerance(1))
              checkpoint = 1;
              patternSize = 1;
            else
              checkpoint = 3;
              counter = 1;
            end
          case 3
            counter = counter + 1;
            ratio = counter / patternSize;
            if (ratio > tolerance(2))
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
            if (ratio > tolerance(2))
              checkpoint = 0;
            end
          case 3
            ratio = counter / patternSize;
            if (ratio < tolerance(1))
              checkpoint = 2;
              patternSize = counter;
            else
              % WOOOW
              candidate = [y, round(x - patternSize * 1.5)];
              if (validateVerticalAP(imageBW, candidate, tolerance))
                aps = [aps; candidate];
              end
              checkpoint = 0;
            end
        end
      end
    end
  end


end

