function Score = diceScore(segIMG, tIMG)
    % Calculate the Dice Score
    Dice = sum(segIMG(:) & tIMG(:));
    Score = 2*Dice/(sum(segIMG(:))+(sum(tIMG(:))));    
end