function precisionRecall (actualD, predictedD)
    %Storage for factors
    weedTP=0;
    weedFP=0;
    weedFN=0;

    onionTP=0;
    onionFP=0;
    onionFN=0;
    
    for i = 1:length(actualD) 
        if actualD(i) =="Weed" 
            if predictedD(i) == "Weed" % Actual Weed, Predicted Weed
                weedTP =weedTP+1;
            end
            if predictedD(i) == "Onion" %Actual Weed, Predicted Onion
                weedFN =weedFN+1;
                onionFP = onionFP+1;
            end
        end
        if actualD(i) =="Onion"
            if predictedD(i) == "Weed" %Actual onion, Predicted Weed
                weedFP=weedFP+1;
                onionFN=onionFN+1;
            end
            if predictedD(i) == "Onion" %Actual Onion, Predicted Onion
                onionTP =onionTP +1;
            end
        end
    end

    %precision TP/(TP+FP)
    %recall TP/(TP+FN)

    weedPrecision = weedTP/(weedTP+weedFP)
    weedRecall = weedTP/(weedTP+weedFN)
    
    onionPrecision = onionTP/(onionTP+onionFP)
    onionRecall = onionTP/(onionTP+onionFN)
    
end
