function [decodedMessage, succeeded] = extractMessage(imageBW, toleranceFactor, windowTitle)
%extractMessage
  FIPs = findFIPs(imageBW, toleranceFactor);
  AP = findAP(imageBW, 0.3, FIPs);
  if (size(FIPs,1) == 3 && size(AP,1) == 1)
    corners = getCorners(FIPs, AP);

    bits = extractBits(imageBW, corners);

    decodedMessage = readBits(bits);

    if ~isempty(windowTitle)
      hold off;
      imshow(imageBW);
      set(gcf,'name',windowTitle,'NumberTitle','off');
      hold on;

      scatter(FIPs(:,2),FIPs(:,1),[],[1,0,0;1,0,0;1,0,0]);
      scatter(AP(2),AP(1),[],[0,0.8,1]);
      scatter(corners(:,2),corners(:,1),[],[0,1,0]);
      pause;
    end
    succeeded = true;
  else
    succeeded = false;
    decodedMessage = '';
  end
end

