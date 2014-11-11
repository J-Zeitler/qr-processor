function corners = getCorners(FIPs, AP)
  corners = zeros(4,2);
  
  A = FIPs(1,:);
  B = FIPs(2,:);
  C = FIPs(3,:);
  D = AP;
  
  AB = B - A;
  AC = C - A;
  AD = D - A;
  
  corners(1,:) = A - 3.5/34*AB - 3.5/34*AC;
  corners(2,:) = corners(1,:) + 41/34*AB;
  corners(3,:) = corners(1,:) + 41/34*AC;
  corners(4,:) = corners(1,:) + 41/31*AD;
end

