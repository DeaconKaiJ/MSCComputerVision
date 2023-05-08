function [RGBPatches,DepthPatches,soliditySave,circularitySave,eccentricitySave,nonCompactnessSave,testingIndex] = ...
    patchImages(Objects, O, I, RGBPatches,DepthPatches,soliditySave, circularitySave, eccentricitySave, nonCompactnessSave,testingIndex)
  
    % Extract the image patches corresponding to each object in class 1
    for i = 1:length(Objects)
        %Bounding Box for object
        bbox = Objects(i).BoundingBox;

        %RGB patch
        patchRGB = imcrop(O, bbox);
        RGBPatches{end+1} = patchRGB;

        %Depth patch
        patchDepth = imcrop(I, bbox);
        DepthPatches{end+1} = patchDepth;

        %Save solidity using regionprops function
        solidity = Objects(i).Solidity;
        %Save eccentricity using regionprops function
        eccentricity = Objects(i).Eccentricity;
        
        %x direction second moment
        xVariance = sum((Objects(i).PixelList(:,1) - Objects(i).Centroid(1)).^2); %(2,0)
        %y direction second moment
        yVariance = sum((Objects(i).PixelList(:,2) - Objects(i).Centroid(2)).^2); %(0,2)
        
        %no correction factor, using moments
        %nonCompactness = 2*pi*(xVariance+yVariance);

        %correction factor for noncompactness, using moments
        nonCompactness = 2*pi*((xVariance+yVariance)+(6/Objects(i).Area));

        %no correction factor, using moments
        %circularity = (1/(2*pi))*(Objects(i).Area^2/(xVariance+yVariance));

        %correction factor, using moments
        circularity = (1/(2*pi))*(Objects(i).Area^2/(xVariance+yVariance+(6/Objects(i).Area)));
        
        %regionprops function
        %circularity = Objects(i).Circularity;
        %circularity = (4*pi*Objects(i).Area/Objects(i).Perimeter^2)*(1 - 0.5/(Objects(i).Perimeter/(2*pi) + 0.5))^2;
        
        %save information in relevant arrays
        soliditySave = [soliditySave,solidity];
        circularitySave = [circularitySave,circularity];
        eccentricitySave = [eccentricitySave,eccentricity];
        nonCompactnessSave = [nonCompactnessSave,nonCompactness];
           
    end    
    %Store index value
    testingIndex = testingIndex + length(Objects);
end