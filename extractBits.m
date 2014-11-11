function bits = extractBits(imageBW, corners)
  bits = zeros(1,1464);
  b = 1;
  if (size(corners,1) == 4)
    A = corners(1,:); % upper left
    B = corners(2,:); % upper right
    C = corners(3,:); % lower left
    D = corners(4,:); % lower right
    
    res = 41;
    
    controlZones = zeros(2,2,4);
    controlZones(:,:,1) = [1,1; 8,8];
    controlZones(:,:,2) = [34,1; 41,8];
    controlZones(:,:,3) = [1,34; 8,41];
    controlZones(:,:,4) = [33,33; 37,37];
    
    for x = 1:res
      for y = 1:res
        % read bits column first
        if (y > 8 || x > 8) && ... % not in first control point
          (y > 8 || x < 34) && ... % not in second control point
          (y < 34 || x > 8) && ... % not in third control point
          (y < 33 || x < 33 || y > 37 || x > 37) % not in fourth control point
        
          px = (x - 0.5) / 41;
          py = (y - 0.5) / 41;
          AB = (1-px)*A + px*B;
          CD = (1-px)*C + px*D;
          ABCD = (1-py)*AB + py*CD;
          transformedPoint = ABCD;
          pyi = round(transformedPoint(1));
          pxi = round(transformedPoint(2));
          bit = imageBW(pyi,pxi);
          bits(b) = bit;
          b = b + 1;
        end
      end
    end
  end
end

