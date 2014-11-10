function point = findBlobCenter(imageBW, startPoint, inverse)
  if (nargin > 2 && inverse)
    imageBW = ~imageBW;
  end
  filled = imfill(imageBW, startPoint, 8);
  diff = filled - imageBW;
  [row, col] = find(diff);
  point = [mean(row),mean(col)];
end

