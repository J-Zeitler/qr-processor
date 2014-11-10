function point = findBlobCenter(imageBW, startPoint)
  filled = imfill(imageBW, startPoint, 8);
  diff = filled - imageBW;
  [row, col] = find(diff);
  point = [mean(row),mean(col)];
end

