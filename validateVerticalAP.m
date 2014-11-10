function valid = validateVerticalAP(imageBW, candidate, ratioLimit)
  [height width] = size(imageBW);
  valid = true;
  directions = [-1 1];
  patternSize = 0;
  for dir = directions
    if valid
      y = candidate(1);
      x = candidate(2);
      if (dir == directions(1))
        while true
          y = y + dir;
          if (y < 1 || y > height)
            valid = false;
            break;
          end
          if (imageBW(y,x) == 0)
            break;
          end
        end
        dy = dir * (y - candidate(1));
        patternSize = round((dy - 1) * 2 + 1);
      else
        whiteStart = y;
        for y = whiteStart:dir:round(whiteStart + dir*patternSize*0.5*ratioLimit(2))
          if (y < 1 || y > height)
            valid = false;
            break;
          end
          pxl = imageBW(y,x);
          if (pxl == 0)
            ratio = dir*(y-whiteStart)/(patternSize*0.5);
            if (ratio < ratioLimit(1))
              valid = false;
            end
            break;
          end
        end
      end
      if valid
        blackStart = y;
        for y = blackStart:dir:round(blackStart + dir*patternSize*ratioLimit(2))
          if (y < 1 || y > height)
            valid = false;
            break;
          end
          pxl = imageBW(y,x);
          whiteStart = y;
          if (pxl == 1)
            ratio = dir*(y-blackStart)/patternSize;
            if (ratio < ratioLimit(1))
              valid = false;
            end
            break;
          end
        end
        if (valid && (whiteStart < 1 || whiteStart > height || imageBW(whiteStart,x) == 0))
          valid = false;
        end
      end
    end
  end
end

