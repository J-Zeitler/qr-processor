function bits = extractBits(imageBW, corners)
  bits = zeros(1,1413);
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
           
          zone = [x-1,y-1; x,y-1; x,y; x-1,y] / 41;
          transformedZone = zeros(4,2);
          
          imshow(imageBW);
          
          for z = 1:4
            c = zone(z,:);
            AB = (1-c(1))*A + c(1)*B;
            CD = (1-c(1))*C + c(1)*D;
            ABCD = (1-c(2))*AB + c(2)*CD;
            transformedZone(z,:) = [ABCD(2) ABCD(1)];
          end

          mask = zeros(size(imageBW));
          shapeInserter = vision.ShapeInserter('Shape', 'Polygons', 'Fill', true, 'FillColor', 'Custom', 'CustomFillColor', uint8(255));
          polygon = int32([transformedZone(1,:) transformedZone(2,:) transformedZone(3,:) transformedZone(4,:)]);
          mask = step(shapeInserter, mask, polygon);
          
          maskedValues = mask .* imageBW;
          imshow(mask/2 + imageBW/2);
          meanIntensity = sum(maskedValues(:)) / sum(mask(:));
          bit = round(meanIntensity);
          bits(b) = bit;
          b = b + 1;
          
          %imshow(imageBW);
          %hold on;
          %scatter(transformedZone(:,1),transformedZone(:,2),'ro');
          %pause;
         
        end
      end
    end
  end
end

