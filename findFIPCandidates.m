function candidates = findFIPCandidates(imageBW, toleranceFactor)
  if (toleranceFactor > 0 && toleranceFactor < 1)
    tolerance = [1-toleranceFactor, 1/(1-toleranceFactor)];
  else
    tolerance = [0.7, 1/0.7];
  end
  candidates = [];

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
            ratio = counter / (patternSize * 3);
            if (ratio > tolerance(2))
              checkpoint = 1;
              patternSize = counter;
            end
          case 4
            ratio = counter/patternSize;
            if (ratio > tolerance(1) && ratio < tolerance(2))
              checkpoint = 5;
              counter = 1;
            else
              checkpoint = 1;
              patternSize = 1;
            end
          case 5
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
            ratio = counter / (patternSize * 3);
            if (ratio < tolerance(1))
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
            if (ratio > tolerance(2))
              checkpoint = 2;
              patternSize = patternSize * 3;
            end
          case 5
            ratio = counter / patternSize;
            if (ratio < tolerance(1))
              checkpoint = 2;
              patternSize = counter;
            else
              candidate = [y, round(x - patternSize * 3.5)];
              if (validateVerticalFIP(imageBW, candidate, tolerance))
                candidates = [candidates; candidate];
              end
              checkpoint = 0;
            end
        end
      end
    end
  end


end

