function orderedFIPs = findFIPs(imageBW, toleranceFactor)
  FIPCandidates = findFIPCandidates(imageBW, toleranceFactor);
  nFIPCandidates = size(FIPCandidates,1);
  FIPClusterIndices = kmeans(FIPCandidates, 3);
  FIPCluster1 = []; FIPCluster2 = []; FIPCluster3 = [];
  for i = 1:nFIPCandidates
    index = FIPClusterIndices(i);
    switch index
      case 1
        FIPCluster1 = [FIPCluster1; FIPCandidates(i,:)];
      case 2
        FIPCluster2 = [FIPCluster2; FIPCandidates(i,:)];
      case 3
        FIPCluster3 = [FIPCluster3; FIPCandidates(i,:)];
    end
  end
  
  clusterPoint1 = findClusterCenter(FIPCluster1);
  clusterPoint2 = findClusterCenter(FIPCluster2);
  clusterPoint3 = findClusterCenter(FIPCluster3);

  FIP1 = findBlobCenter(imageBW, clusterPoint1);
  FIP2 = findBlobCenter(imageBW, clusterPoint2);
  FIP3 = findBlobCenter(imageBW, clusterPoint3);
  
  FIPs = [FIP1; FIP2; FIP3];
  
  [~,i] = max(pdist(FIPs));
  switch i
    case 1
      A = FIPs(3,:);
      B = FIPs(1,:);
      C = FIPs(2,:);
    case 2
      A = FIPs(2,:);
      B = FIPs(1,:);
      C = FIPs(3,:);
    case 3
      A = FIPs(1,:);
      B = FIPs(2,:);
      C = FIPs(3,:);
  end
  AB = B - A;
  AC = C - A;
  
  z = AC(1) * AB(2) - AC(2) * AB(1);
  if z > 0
    lowerLeft = C;
    upperRight = B;
  else
    lowerLeft = B;
    upperRight = C;
  end
  upperLeft = A;
  
  orderedFIPs = [upperLeft;upperRight;lowerLeft];
end

