function Histogram = Histogram
    I = imread('Lenna.png');
    GI = rgb2gray(I);
    gh = imhist(GI);
    normgh = imhist(GI) / numel(GI); 
    gbh = bar(gh);
    normgbh =bar(normgh);
    subplot(2,2,1),imshow(I);
    subplot(2,2,2),imshow(GI);
    subplot(2,2,3),gbh;
    subplot(2,2,4),normgbh;
end