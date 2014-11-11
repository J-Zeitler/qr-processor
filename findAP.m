function AP = findAP(imageBW, toleranceFactor, FIPs)
  if size(FIPs,1) == 3
    searchFactors = [25/34, 37/34];

    A = FIPs(1,:);
    B = FIPs(2,:);
    C = FIPs(3,:);

    AB = B - A;
    AC = C - A;

    window = floor([A + searchFactors(1) * (AB + AC); A + searchFactors(2) * (AB + AC)]);
    y1 = window(1,1);
    y2 = window(2,1);
    dy = y2-y1;
    dy = dy/abs(dy);
    yRange = y1:dy:y2;
    x1 = window(1,2);
    x2 = window(2,2);
    dx = x2-x1;
    dx = dx/abs(dx);
    xRange = x1:dx:x2;

    APCandidates = findAPCandidates(imageBW, toleranceFactor, yRange, xRange);
    clusterPoint = findClusterCenter(APCandidates);
    AP = findBlobCenter(imageBW, clusterPoint, true);
  else
    AP = [];
  end
end

