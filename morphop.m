function morphop = morphop
    %b = imread('coins.gif');
    %morphop =b;
    %SE = strel("disk",1);
    %dilate = imerode(b,SE);
    %morphop = dilate;
    [gifImage,map] = imread('coins.gif', 'Frames', 'all');
    imshow(gifImage,map);
    SE = strel("disk",1);
    erode = imerode(gifImage,SE);
    imshow(erode);
    morphop = erode;