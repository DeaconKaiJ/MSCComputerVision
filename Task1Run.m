clear; close all;
%Iterate through all 16 imgs
diceScoreSave=[];
trueLeaf = readmatrix("Leaf_counts.csv");
%Iterate through all
for i =1:16
    str = string(i);
    if i <10
        str = "0"+str;
    end
    %Segement IMG
    [I,segIMG] = segmentPlant(str);

    %Import ground truth
    tIMG = truthIMG(str);

    %Calculate Dice score, save it
    dsScore = diceScore(segIMG, tIMG);
    diceScoreSave = [diceScoreSave,dsScore];

    %Display figures
    figure; 
    subplot(2,2,1),imshow(I);
    title('Original Image')
    subplot(2,2,2),imshow(segIMG);
    title('Segmented Image DS = '+string(dsScore))
    subplot(2,2,3),imshow(segIMG);
    plantNumber = findLeaves(segIMG);
    title("Estimated Leaves: "+string(plantNumber))
    subplot(2,2,4),imshow(tIMG);
    title('Actual Leaves: '+string(trueLeaf(i,2)))
    sgtitle("Plant Image " +str);
    
end
dsMean = sum(diceScoreSave)/length(diceScoreSave);
x=1:16;
figure; plot(x, diceScoreSave); title("Dice Score Mean: "+ string(dsMean));xlabel("Image");ylabel("DS")


