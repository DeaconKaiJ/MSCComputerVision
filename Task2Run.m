clear; close all;
%Storage arrays
weedSoliditySave = [];
weedCircularitySave = [];
weedEccentricitySave = [];
weedNonCompactnessSave = [];
weedRGBPatches = {};
weedDepthPatches = {};
weedIndex= 0;
weedTestingIndex= 0;

onionSoliditySave = [];
onionCircularitySave = [];
onionEccentricitySave = [];
onionNonCompactnessSave = [];
onionRGBPatches = {};
onionDepthPatches ={};
onionIndex= 0;
onionTestingIndex= 0;

%Iterate through all pictures
for i =1:20
    str = string(i);
    if i <10
        str = "0"+str;
    end
    %Read each picture
    I = imread(str+"_depth.png");
    O = imread(str+"_rgb.png");
    P = imread(str+"_truth.png");
    
    %Function
    [weedObjects, onionObjects] = formatImages(P);
    %if the current picture is 19, its now the test set so store the index
    %for later use is split train test
    if i ==19
        onionTestingIndex = onionIndex +1;
        weedTestingIndex = weedIndex +1;
    end
    %Function
    [weedRGBPatches,weedDepthPatches,weedSoliditySave,weedCircularitySave,weedEccentricitySave,weedNonCompactnessSave,weedIndex] = ...
        patchImages(weedObjects, O, I, weedRGBPatches, weedDepthPatches, weedSoliditySave, weedCircularitySave, weedEccentricitySave,weedNonCompactnessSave, weedIndex);
    [onionRGBPatches,onionDepthPatches,onionSoliditySave,onionCircularitySave,onionEccentricitySave,onionNonCompactnessSave,onionIndex] = ...
        patchImages(onionObjects, O, I,onionRGBPatches,onionDepthPatches,onionSoliditySave, onionCircularitySave, onionEccentricitySave,onionNonCompactnessSave,onionIndex);
end

%Display shape features for weed
x=1:length(weedRGBPatches);
figure; 
subplot(2,2,1);plot(x, weedSoliditySave); title("Solidity Mean: "+mean(weedSoliditySave));
subplot(2,2,2);plot(x, weedCircularitySave);title("Circularity Mean: "+mean(weedCircularitySave));
subplot(2,2,3);plot(x, weedEccentricitySave);title("Eccentricity Mean: "+mean(weedEccentricitySave));
subplot(2,2,4);plot(x, weedNonCompactnessSave);title("NonCompactness Mean: "+mean(weedNonCompactnessSave));
sgtitle("Weed Objects")

%Display Shape Features for onions
x=1:length(onionRGBPatches);
figure;
subplot(2,2,1); plot(x, onionSoliditySave);title("Solidity Mean: "+mean(onionSoliditySave));
subplot(2,2,2); plot(x, onionCircularitySave);title("Circularity Mean: "+mean(onionCircularitySave));
subplot(2,2,3); plot(x, onionEccentricitySave);title("Eccentricity Mean: "+mean(onionEccentricitySave));
subplot(2,2,4);plot(x, onionNonCompactnessSave);title("NonCompactness Mean: "+mean(onionNonCompactnessSave));
sgtitle("Onion Objects")

% Abbreviations for array storage
% W = weeds
% O = onions
% AV = Average
% RA = Range
% con = Contrast
% cor = Correlation
% asm = Angular second moment

%Weeds
%%Infra-red Arrays (ifr)
ifrAVconW =[]; ifrRAconW =[];ifrAVcorW =[]; ifrRAcorW =[];ifrAVasmW =[]; ifrRAasmW =[];

%%Red colour channel Arrays (r)
rAVconW =[]; rRAconW =[];rAVcorW =[]; rRAcorW =[];rAVasmW =[]; rRAasmW =[];

%%Green colour channel Arrays (g)
gAVconW =[]; gRAconW =[];gAVcorW =[]; gRAcorW =[];gAVasmW =[]; gRAasmW =[];

%%Blue colour channel Arrays (b)

bAVconW =[]; bRAconW =[];bAVcorW =[]; bRAcorW =[];bAVasmW =[]; bRAasmW =[];

%Onions
%%Infra-red Arrays (ifr)
ifrAVconO =[]; ifrRAconO =[];ifrAVcorO =[]; ifrRAcorO =[];ifrAVasmO =[]; ifrRAasmO =[];

%%Red colour channel Arrays (r)
rAVconO =[]; rRAconO =[];rAVcorO =[]; rRAcorO =[];rAVasmO =[]; rRAasmO =[];

%%Green colour channel Arrays (g)
gAVconO =[]; gRAconO =[];gAVcorO =[]; gRAcorO =[];gAVasmO =[]; gRAasmO =[];

%%Blue colour channel Arrays (b)
bAVconO =[]; bRAconO =[];bAVcorO =[]; bRAcorO =[];bAVasmO =[]; bRAasmO =[];

%Function
[ifrAVconW,ifrAVcorW,ifrAVasmW,ifrRAconW,ifrRAcorW,ifrRAasmW, ...
    rAVconW,rAVcorW,rAVasmW,rRAconW,rRAcorW,rRAasmW, ...
    gAVconW,gAVcorW,gAVasmW,gRAconW,gRAcorW,gRAasmW, ...
    bAVconW,bAVcorW,bAVasmW,bRAconW,bRAcorW,bRAasmW] = textureFeatures(weedDepthPatches, weedRGBPatches,ifrAVconW,ifrAVcorW,ifrAVasmW,ifrRAconW,ifrRAcorW,ifrRAasmW, ...
                                                                                            rAVconW,rAVcorW,rAVasmW,rRAconW,rRAcorW,rRAasmW, ...
                                                                                            gAVconW,gAVcorW,gAVasmW,gRAconW,gRAcorW,gRAasmW, ...
                                                                                            bAVconW,bAVcorW,bAVasmW,bRAconW,bRAcorW,bRAasmW);
%Function
[ifrAVconO,ifrAVcorO,ifrAVasmO,ifrRAconO,ifrRAcorO,ifrRAasmO, ...
    rAVconO,rAVcorO,rAVasmO,rRAconO,rRAcorO,rRAasmO, ...
    gAVconO,gAVcorO,gAVasmO,gRAconO,gRAcorO,gRAasmO, ...
    bAVconO,bAVcorO,bAVasmO,bRAconO,bRAcorO,bRAasmO] = textureFeatures(onionDepthPatches, onionRGBPatches,ifrAVconO,ifrAVcorO,ifrAVasmO,ifrRAconO,ifrRAcorO,ifrRAasmO, ...
                                                                                            rAVconO,rAVcorO,rAVasmO,rRAconO,rRAcorO,rRAasmO, ...
                                                                                            gAVconO,gAVcorO,gAVasmO,gRAconO,gRAcorO,gRAasmO, ...
                                                                                            bAVconO,bAVcorO,bAVasmO,bRAconO,bRAcorO,bRAasmO);
%Display weed average and range for contrast
x=1:length(weedRGBPatches);
figure;
subplot(2,4,1);plot(x, ifrAVconW); title("Weed Infrared Average Contrast");
subplot(2,4,2);plot(x, ifrRAconW); title("Weed Infrared Range Contrast");
subplot(2,4,3);plot(x, rAVconW); title("Weed Red Average Contrast");
subplot(2,4,4);plot(x, rRAconW); title("Weed Red Range Contrast");
subplot(2,4,5);plot(x, gAVconW); title("Weed Green Average Contrast");
subplot(2,4,6);plot(x, gRAconW); title("Weed Green Range Contrast");
subplot(2,4,7);plot(x, bAVconW); title("Weed Blue Average Contrast");
subplot(2,4,8);plot(x, bRAconW); title("Weed Blue Range Contrast");

%Display onion average and range for contrast
x=1:length(onionRGBPatches);
figure;
subplot(2,4,1);plot(x, ifrAVconO); title("Onion Infrared Average Contrast");
subplot(2,4,2);plot(x, ifrRAconO); title("Onion Infrared Range Contrast");
subplot(2,4,3);plot(x, rAVconO); title("Onion Red Average Contrast");
subplot(2,4,4);plot(x, rRAconO); title("Onion Red Range Contrast");
subplot(2,4,5);plot(x, gAVconO); title("Onion Green Average Contrast");
subplot(2,4,6);plot(x, gRAconO); title("Onion Green Range Contrast");
subplot(2,4,7);plot(x, bAVconO); title("Onion Blue Average Contrast");
subplot(2,4,8);plot(x, bRAconO); title("Onion Blue Range Contrast");

%Function to split shape data into train test
[combinedSoliditySaveTrain, combinedSoliditySaveTest] = splitTrainTest(weedSoliditySave, onionSoliditySave, weedTestingIndex, onionTestingIndex);
[combinedCircularitySaveTrain, combinedCircularitySaveTest] = splitTrainTest(weedCircularitySave, onionCircularitySave, weedTestingIndex, onionTestingIndex);
[combinedEccentricitySaveTrain, combinedEccentricitySaveTest] = splitTrainTest(weedEccentricitySave, onionEccentricitySave, weedTestingIndex, onionTestingIndex);
[combinedNonCompactnessSaveTrain, combinedNonCompactnessSaveTest] = splitTrainTest(weedNonCompactnessSave, onionNonCompactnessSave, weedTestingIndex, onionTestingIndex);

%Y variabls
trainVariables = [];
testVariables = [];
%Iterate through all weed data, any weed related array will work
for i = 1:length(weedSoliditySave)
    %If Above or equal to index
    if i>=weedTestingIndex
        %test data
        testVariables = [testVariables, "Weed"];
    end
    %If below index
    if i<weedTestingIndex
        %train data
        trainVariables = [trainVariables, "Weed"];
    end
end
%Iterate through all onion data, any onion related array will work
for i = 1:length(onionSoliditySave)
    %If Above or equal to index
    if i>=onionTestingIndex
        %test data
        testVariables = [testVariables, "Onion"];
    end
    %If below index
    if i<onionTestingIndex
        %train data
        trainVariables = [trainVariables, "Onion"];
    end
end

%Save pictures 19 and 20 test
P1 = imread("19_truth.png");
P2 = imread("20_truth.png");

%Create train test table for the shape features
shapeTrainTable = table(combinedSoliditySaveTrain(:),combinedCircularitySaveTrain(:),combinedEccentricitySaveTrain(:),combinedNonCompactnessSaveTrain(:));
shapeTestTable = table(combinedSoliditySaveTest(:),combinedCircularitySaveTest(:),combinedEccentricitySaveTest(:),combinedNonCompactnessSaveTest(:));

%Run shape SVM using train table and y variables
shapeSVMModel = fitcsvm(shapeTrainTable,trainVariables, ClassNames=["Weed","Onion"]);

%Predict labels for test set
shapePredictedLabels = predict(shapeSVMModel,shapeTestTable);

disp("Shape model stats overall: ")
precisionRecall(testVariables,shapePredictedLabels)
disp("Shape model stats per image: ")
testOutputPredictions(P1,P2,testVariables,shapePredictedLabels)

%Function to split all feature data into train and test
[combinedIfrAVconTrain,combinedIfrAVconTest] = splitTrainTest(ifrAVconW,ifrAVconO, weedTestingIndex, onionTestingIndex);
[combinedIfrRAconTrain,combinedIfrRAconTest] = splitTrainTest(ifrRAconW,ifrRAconO, weedTestingIndex, onionTestingIndex);
[combinedIfrAVcorTrain,combinedIfrAVcorTest] = splitTrainTest(ifrAVcorW,ifrAVcorO, weedTestingIndex, onionTestingIndex);
[combinedIfrRAcorTrain,combinedIfrRAcorTest] = splitTrainTest(ifrRAcorW,ifrRAcorO, weedTestingIndex, onionTestingIndex);
[combinedIfrAVasmTrain,combinedIfrAVasmTest] = splitTrainTest(ifrAVasmW,ifrAVasmO, weedTestingIndex, onionTestingIndex);
[combinedIfrRAasmTrain,combinedIfrRAasmTest] = splitTrainTest(ifrRAasmW,ifrRAasmO, weedTestingIndex, onionTestingIndex);

[combinedrAVconTrain,combinedrAVconTest] = splitTrainTest(rAVconW,rAVconO, weedTestingIndex, onionTestingIndex);
[combinedrRAconTrain,combinedrRAconTest] = splitTrainTest(rRAconW,rRAconO, weedTestingIndex, onionTestingIndex); 
[combinedrAVcorTrain,combinedrAVcorTest] = splitTrainTest(rAVcorW,rAVcorO, weedTestingIndex, onionTestingIndex);
[combinedrRAcorTrain,combinedrRAcorTest] = splitTrainTest(rRAcorW,rRAcorO, weedTestingIndex, onionTestingIndex);
[combinedrAVasmTrain,combinedrAVasmTest] = splitTrainTest(rAVasmW,rAVasmO, weedTestingIndex, onionTestingIndex);
[combinedrRAasmTrain,combinedrRAasmTest] = splitTrainTest(rRAasmW,rRAasmO, weedTestingIndex, onionTestingIndex);

[combinedgAVconTrain,combinedgAVconTest] = splitTrainTest(gAVconW,gAVconO, weedTestingIndex, onionTestingIndex);
[combinedgRAconTrain,combinedgRAconTest] = splitTrainTest(gRAconW,gRAconO, weedTestingIndex, onionTestingIndex); 
[combinedgAVcorTrain,combinedgAVcorTest] = splitTrainTest(gAVcorW,gAVcorO, weedTestingIndex, onionTestingIndex);
[combinedgRAcorTrain,combinedgRAcorTest] = splitTrainTest(gRAcorW,gRAcorO, weedTestingIndex, onionTestingIndex);
[combinedgAVasmTrain,combinedgAVasmTest] = splitTrainTest(gAVasmW,gAVasmO, weedTestingIndex, onionTestingIndex);
[combinedgRAasmTrain,combinedgRAasmTest] = splitTrainTest(gRAasmW,gRAasmO, weedTestingIndex, onionTestingIndex);

[combinedbAVconTrain,combinedbAVconTest] = splitTrainTest(bAVconW,bAVconO, weedTestingIndex, onionTestingIndex);
[combinedbRAconTrain,combinedbRAconTest] = splitTrainTest(bRAconW,bRAconO, weedTestingIndex, onionTestingIndex);
[combinedbAVcorTrain,combinedbAVcorTest] = splitTrainTest(bAVcorW,bAVcorO, weedTestingIndex, onionTestingIndex);
[combinedbRAcorTrain,combinedbRAcorTest] = splitTrainTest(bRAcorW,bRAcorO, weedTestingIndex, onionTestingIndex);
[combinedbAVasmTrain,combinedbAVasmTest] = splitTrainTest(bAVasmW,bAVasmO, weedTestingIndex, onionTestingIndex);
[combinedbRAasmTrain,combinedbRAasmTest] = splitTrainTest(bRAasmW,bRAasmO, weedTestingIndex, onionTestingIndex);

%Train and Test tables for Texture features
textureTrainTable = table(combinedIfrAVconTrain(:),combinedIfrRAconTrain(:),combinedIfrAVcorTrain(:),combinedIfrRAcorTrain(:),combinedIfrAVasmTrain(:),combinedIfrRAasmTrain(:), ...
    combinedrAVconTrain(:),combinedrRAconTrain(:),combinedrAVcorTrain(:),combinedrRAcorTrain(:),combinedrAVasmTrain(:),combinedrRAasmTrain(:),combinedgAVconTrain(:),...
    combinedgRAconTrain(:), combinedgAVcorTrain(:),combinedgRAcorTrain(:),combinedgAVasmTrain(:),combinedgRAasmTrain(:),combinedbAVconTrain(:),combinedbRAconTrain(:),...
    combinedbAVcorTrain(:),combinedbRAcorTrain(:),combinedbAVasmTrain(:),combinedbRAasmTrain(:));
textureTestTable = table(combinedIfrAVconTest(:),combinedIfrRAconTest(:),combinedIfrAVcorTest(:),combinedIfrRAcorTest(:),combinedIfrAVasmTest(:),combinedIfrRAasmTest(:), ...
    combinedrAVconTest(:),combinedrRAconTest(:),combinedrAVcorTest(:),combinedrRAcorTest(:),combinedrAVasmTest(:),combinedrRAasmTest(:),combinedgAVconTest(:),...
    combinedgRAconTest(:), combinedgAVcorTest(:),combinedgRAcorTest(:),combinedgAVasmTest(:),combinedgRAasmTest(:),combinedbAVconTest(:),combinedbRAconTest(:),...
    combinedbAVcorTest(:),combinedbRAcorTest(:),combinedbAVasmTest(:),combinedbRAasmTest(:));

%Run Texture SVM using train table and y variables
textureSVMModel = fitcsvm(textureTrainTable,trainVariables, ClassNames=["Weed","Onion"]);

%Predict labels for test set
texturePredictedLabels = predict(textureSVMModel,textureTestTable);

disp("Texture model stats overall: ")
precisionRecall(testVariables,texturePredictedLabels)
disp("Texture model stats per image: ")
testOutputPredictions(P1,P2,testVariables,texturePredictedLabels)

%Combined both shape and texture tables into train and test
combinedTrainTable = table(combinedSoliditySaveTrain(:),combinedCircularitySaveTrain(:),combinedEccentricitySaveTrain(:),combinedNonCompactnessSaveTrain(:), ...
    combinedIfrAVconTrain(:),combinedIfrRAconTrain(:),combinedIfrAVcorTrain(:),combinedIfrRAcorTrain(:),combinedIfrAVasmTrain(:),combinedIfrRAasmTrain(:), ...
    combinedrAVconTrain(:),combinedrRAconTrain(:),combinedrAVcorTrain(:),combinedrRAcorTrain(:),combinedrAVasmTrain(:),combinedrRAasmTrain(:),combinedgAVconTrain(:),...
    combinedgRAconTrain(:), combinedgAVcorTrain(:),combinedgRAcorTrain(:),combinedgAVasmTrain(:),combinedgRAasmTrain(:),combinedbAVconTrain(:),combinedbRAconTrain(:),...
    combinedbAVcorTrain(:),combinedbRAcorTrain(:),combinedbAVasmTrain(:),combinedbRAasmTrain(:));

combinedTestTable = table(combinedSoliditySaveTest(:),combinedCircularitySaveTest(:),combinedEccentricitySaveTest(:),combinedNonCompactnessSaveTest(:),...
    combinedIfrAVconTest(:),combinedIfrRAconTest(:),combinedIfrAVcorTest(:),combinedIfrRAcorTest(:),combinedIfrAVasmTest(:),combinedIfrRAasmTest(:), ...
    combinedrAVconTest(:),combinedrRAconTest(:),combinedrAVcorTest(:),combinedrRAcorTest(:),combinedrAVasmTest(:),combinedrRAasmTest(:),combinedgAVconTest(:),...
    combinedgRAconTest(:), combinedgAVcorTest(:),combinedgRAcorTest(:),combinedgAVasmTest(:),combinedgRAasmTest(:),combinedbAVconTest(:),combinedbRAconTest(:),...
    combinedbAVcorTest(:),combinedbRAcorTest(:),combinedbAVasmTest(:),combinedbRAasmTest(:));

%Run combined model using combined train table and y variables
fullSVMModel = fitcsvm(combinedTrainTable,trainVariables, ClassNames=["Weed","Onion"]);

%Predict labels for test set
fullPredictedLabels = predict(fullSVMModel,combinedTestTable);

disp("Combined model stats overall: ")
precisionRecall(testVariables,fullPredictedLabels)
disp("Combined model stats per image: ")
testOutputPredictions(P1,P2,testVariables,fullPredictedLabels)

%Determine most important columns
idx = fscchi2(combinedTrainTable,trainVariables);
idx(1:10); %identifies columns 2     1     3     4     6     5    10    18    17    22

%Reduced Train Test table using 10 features
reducedcombinedTrainTable = table(combinedSoliditySaveTrain(:),combinedCircularitySaveTrain(:),combinedEccentricitySaveTrain(:),combinedNonCompactnessSaveTrain(:), ...
    combinedIfrAVconTrain(:),combinedIfrRAconTrain(:),combinedIfrRAasmTrain(:),combinedgAVconTrain(:),combinedgRAconTrain(:),combinedgRAasmTrain(:));

reducedcombinedTestTable = table(combinedSoliditySaveTest(:),combinedCircularitySaveTest(:),combinedEccentricitySaveTest(:),combinedNonCompactnessSaveTest(:), ...
    combinedIfrAVconTest(:),combinedIfrRAconTest(:),combinedIfrRAasmTest(:),combinedgAVconTest(:),combinedgRAconTest(:),combinedgRAasmTest(:));

%Run Reduced model using train table and y variables
reducedSVMModel = fitcsvm(reducedcombinedTrainTable,trainVariables, ClassNames=["Weed","Onion"]);

%Predict labels for test set
reducedPredictedLabels = predict(reducedSVMModel,reducedcombinedTestTable);
disp("Reduced model stats overall: ")
precisionRecall(testVariables,reducedPredictedLabels)
disp("Reduced model stats per image: ")
testOutputPredictions(P1,P2,testVariables,reducedPredictedLabels)