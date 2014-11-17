function point = findBlobCenter(imageBW, startPoint, inverse)
  if (nargin > 2 && inverse)
    imageBW = ~imageBW;
  end
  filled = imfill(imageBW, startPoint, 8);
  diff = filled - imageBW;
  [row, col] = find(diff);
  point = [mean(row),mean(col)];

%   rgbFill = repmat(diff,[1 1 3]);
%   rgbFill(:,:,2:3) = repmat(diff,[1 1 2]) * 0.7;
%   rgbImg = repmat(imageBW,[1 1 3]);
%   
%   hold off;
%   imshow(rgbImg + rgbFill .* ~rgbImg);
%   hold on;
%   scatter(startPoint(2),startPoint(1),[],[1,0,0],'x');
%   scatter(point(2),point(1),[],[0,1,0],'x');
%   pause;
end

