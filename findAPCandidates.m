function aps = findAPCandidates(imageBW, toleranceFactor, ySpan, xSpan)
  if (toleranceFactor > 0 && toleranceFactor < 1)
    tolerance = [1-toleranceFactor, 1/(1-toleranceFactor)];
  else
    tolerance = [0.7, 1/0.7];
  end
  aps = [];

  for y = ySpan
    checkpoint = 0;
    patternSize = 0;
    counter = 0;
    for x = xSpan
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
              counter = 1;
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

