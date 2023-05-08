function [weedObjects, onionObjects]=formatImages(P)

    %Had issue with the segmentation sometimes flipping
    %Segment Truth Img by colour
    %L = imsegkmeans(P,3);
    %Mask for Weeds
    %weedMask = L == 2;
    %weedCluster = P.*uint8(weedMask);
    %weedGray = rgb2gray(weedCluster);
    %weedBinary=imbinarize(weedGray);
    
    %Mask for Onions
    %onionMask = L == 3;
    %onionCluster = P.*uint8(onionMask);
    %onionGray = rgb2gray(onionCluster);
    %onionBinary = imbinarize(onionGray);
    
    %Simple solution, eliminate all but the specified colour channel
    weeds = P(:,:,3);
    onions = P(:,:,1);
   
    %Label objects
    weedLabeled = bwlabel(weeds); %WEEDS
    onionLabeled = bwlabel(onions); %ONIONS
    
    %Extract the objects properties
    weedObjects = regionprops(weedLabeled, "BoundingBox","Circularity","Eccentricity","Solidity", "Area", "Perimeter", "PixelList", "Centroid");
    onionObjects = regionprops(onionLabeled, "BoundingBox","Circularity","Eccentricity","Solidity", "Area", "Perimeter", "PixelList", "Centroid");
end