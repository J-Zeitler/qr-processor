function p = findClusterCenter(points)
  m = mean(points);
  means = repmat(m,size(points,1),1);
  dist = abs(points - means);
  [~,i] = min(dist);
  p = points(i(1),:);
end

