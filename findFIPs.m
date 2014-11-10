function FIPs = findFIPs(imageBW, toleranceFactor)
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
end

