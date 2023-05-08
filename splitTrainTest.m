function [trainData, testData] = splitTrainTest(dataWeed, dataOnion,weedIndex, onionIndex)
    %Train test arrays
    trainData = [];
    testData = [];
    %Iterate through all weed information
    for i =1:length(dataWeed)
        %If above or equal to index
        if i>=weedIndex
            %Test data
            testData = [testData, dataWeed(i)];
        end
        %If below index
        if i<weedIndex
            %Train data
            trainData = [trainData, dataWeed(i)];
        end
    end
    %Iterate through all onion informatiom
    for i =1:length(dataOnion)
        %If above or equal to index 
        if i>=onionIndex
            %Test data
            testData = [testData, dataOnion(i)];
        end
        %If below index
        if i<onionIndex
            %Train data
            trainData = [trainData, dataOnion(i)];
        end
    end
end