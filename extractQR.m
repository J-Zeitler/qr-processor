function qr = extractQR(imageBW, FIPs, AP)
  d = max(pdist(FIPs));
  resolution = round(d(1)/34);

  targetPoints = [3.5 3.5; 3.5 37.5; 37.5 3.5; 34.5 34.5]; % Positions of control points in a non-transformed qr image
  targetPoints = ceil(targetPoints * resolution); % Scale to get higher resolution in resulting image
  
  inputPoints = [FIPs ; AP];
  
  tform = fitgeotrans(targetPoints, inputPoints, 'projective');
  qr = imwarp(imageBW, tform);
  
  % TODO: extract square of QR image
  
  % Discussion: Since the notion of corners already is very accurate,
  % maybe we don't want to rely on an inverse transform that could
  % mess up the locations of the corners. So, instead, we could
  % sample QR bits directly in the image, using the vectors between
  % the corners.
end

