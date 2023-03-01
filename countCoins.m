function countCoins =countCoins
    mushI = imread("mushroom img1.png");
    graymushI = rgb2gray(mushI);
    level = graythresh(graymushI);
    BW = imbinarize(graymushI,level);
    imshowpair(graymushI,BW,'montage');
    BW2 = imcomplement(BW);
    imshowpair(BW,BW2,'montage');
    B = bwboundaries(BW2);
    imshow(BW2);
    text(10,10,strcat('\color{green}Objects Found:',num2str(length(B))));
    hold on
    for k = 1:length(B)
        boundary = B{k};
        plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 0.2)
end