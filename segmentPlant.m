function [rgbIMG,segmentPlant] = segmentPlant(str)
    % Read image
    rgbIMG = imread('plant0'+str+'_rgb.png');
   
    % Convert image to grayscale
    gray_img = rgb2gray(rgbIMG);
    
    %Apply Sobel Mask
    C=im2double(gray_img);
    I_out=zeros(size(C));
    x_out=zeros(size(C));
    y_out=zeros(size(C));
    for i=2:size(C,1)-1
        for j=2:size(C,2)-1
	    x_out(i,j) = (C(i-1,j-1)*-1) + (C(i-1,j)*0) + (C(i-1,j+1)*1) + (C(i,j-1)*-2) + (C(i,j)*0) + (C(i,j+1)*2) + (C(i+1,j-1)*-1) + (C(i+1,j)*0) + (C(i+1,j+1)*1);
        y_out(i,j) = (C(i-1,j-1)*1) + (C(i-1,j)*2) + (C(i-1,j+1)*1) + (C(i,j-1)*0) + (C(i,j)*0) + (C(i,j+1)*0) + (C(i+1,j-1)*-1) + (C(i+1,j)*-2) + (C(i+1,j+1)*-1);
        I_out(i,j) = sqrt((x_out(i,j)^2)+(y_out(i,j)^2));
        end
    end
    
    %Binarize the output
    binaryIMG=imbinarize(I_out);

    %Remove small objects
    removeSmall= bwareaopen(binaryIMG, 100);

    %Create Disk element
    se = strel('disk',1);
    
    %Close image using disk element
    closedIMG = imclose(removeSmall, se);

    %Fill in circles
    filledIMG = imfill(closedIMG,'holes');
    
    %Erode with disk element
    segmentPlant = imerode(filledIMG,se);
end