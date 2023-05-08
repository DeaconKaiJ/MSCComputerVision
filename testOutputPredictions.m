function testOutputPredictions(P1,P2,testVariables,predicedLabels)
    %Simple solution, eliminate all but the specified colour channel
    weedsP1 = P1(:,:,3); onionsP1 = P1(:,:,1);
   
    %Label objects
    weedLabeledP1 = bwlabel(weedsP1); onionLabeledP1 = bwlabel(onionsP1);
    
    %Extract the object properties
    weedObjectsP1 = regionprops(weedLabeledP1, "BoundingBox"); onionObjectsP1 = regionprops(onionLabeledP1, "BoundingBox");

    %Simple solution, eliminate all but the specified colour channel
    weedsP2 = P2(:,:,3); onionsP2 = P2(:,:,1);
   
    %Label objects
    weedLabeledP2 = bwlabel(weedsP2); onionLabeledP2 = bwlabel(onionsP2); 
    
    %Extract the object properties
    weedObjectsP2 = regionprops(weedLabeledP2, "BoundingBox"); onionObjectsP2 = regionprops(onionLabeledP2, "BoundingBox");
    
    %Factor variables
    weedTP=0; weedFP=0; weedFN=0; onionTP=0; onionFP=0; onionFN=0;

    figure;
    imshow(P1);title("Image 19")
    hold on
    %All of the weed cells
    weedThreshold =  length(weedObjectsP1)+length(weedObjectsP2);

    for i = 1:length(weedObjectsP1)
        %Bounding Box for object
        bbox = weedObjectsP1(i).BoundingBox;
        if predicedLabels(i) =="Weed" % Actual Weed, Predicted Weed
            rectangle("Position", [bbox(1),bbox(2),bbox(3),bbox(4)],"EdgeColor","b","LineWidth",2) %blue for weed
            weedTP =weedTP+1;
        end
        if predicedLabels(i) =="Onion" %Actual Weed, Predicted Onion
            rectangle("Position", [bbox(1),bbox(2),bbox(3),bbox(4)],"EdgeColor","r","LineWidth",2) %red for onion
            weedFN =weedFN+1;
            onionFP = onionFP+1;
        end
    end

    for i = 1:length(onionObjectsP1)
        %Bounding Box for object
        bbox = onionObjectsP1(i).BoundingBox;
        if predicedLabels(i+weedThreshold) =="Weed" %Actual onion, Predicted Weed
            rectangle("Position", [bbox(1),bbox(2),bbox(3),bbox(4)],"EdgeColor","b","LineWidth",2) %blue for weed
            weedFP=weedFP+1;
            onionFN=onionFN+1;
        end
        if predicedLabels(i+weedThreshold) =="Onion" %Actual Onion, Predicted Onion
            rectangle("Position", [bbox(1),bbox(2),bbox(3),bbox(4)],"EdgeColor","r","LineWidth",2) %red for onion
            onionTP =onionTP +1;
        end        
    end
    hold off

    weed19Precision = weedTP/(weedTP+weedFP)
    weed19Recall = weedTP/(weedTP+weedFN)
    
    onion19Precision = onionTP/(onionTP+onionFP)
    onion19Recall = onionTP/(onionTP+onionFN)

    weedTP=0; weedFP=0; weedFN=0; onionTP=0; onionFP=0; onionFN=0;
    figure;
    imshow(P2);title("Image 20")
    hold on

    for i = 1:length(weedObjectsP2)
        %Bounding Box for object
        bbox = weedObjectsP2(i).BoundingBox;
        if predicedLabels(i+length(weedObjectsP1)) =="Weed" %Actual Weed, Predicted Weed
            rectangle("Position", [bbox(1),bbox(2),bbox(3),bbox(4)],"EdgeColor","b","LineWidth",2) %blue for weed
            weedTP =weedTP+1;
        end
        if predicedLabels(i+length(weedObjectsP1)) =="Onion" %Actual Weed, Predicted Onion
            rectangle("Position", [bbox(1),bbox(2),bbox(3),bbox(4)],"EdgeColor","r","LineWidth",2) %red for onion
            weedFN =weedFN+1;
            onionFP = onionFP+1;
        end
    end

    for i = 1:length(onionObjectsP2)
        %Bounding Box for object
        bbox = onionObjectsP2(i).BoundingBox;
        if predicedLabels(i+weedThreshold+length(onionObjectsP1)) =="Weed" %Actual Onion, Predicted Weed
            rectangle("Position", [bbox(1),bbox(2),bbox(3),bbox(4)],"EdgeColor","b","LineWidth",2) %blue for weed
            weedFP=weedFP+1;
            onionFN=onionFN+1;
        end
        if predicedLabels(i+weedThreshold+length(onionObjectsP1)) =="Onion" %Actual Onion, Predicted Onion
            rectangle("Position", [bbox(1),bbox(2),bbox(3),bbox(4)],"EdgeColor","r","LineWidth",2) %red for onion
            onionTP =onionTP +1;
        end        
    end
    hold off
    weed20Precision = weedTP/(weedTP+weedFP)
    weed20Recall = weedTP/(weedTP+weedFN)
    
    onion20Precision = onionTP/(onionTP+onionFP)
    onion20Recall = onionTP/(onionTP+onionFN)
   
end