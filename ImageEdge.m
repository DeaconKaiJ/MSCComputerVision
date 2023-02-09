function ImageEdge = ImageEdge
    I = imread('lena_gray_512.tif');
    %ImageEdge = I;
    BW1 = edge(I,'Canny');
    BW2 = edge(I,'Prewitt');
    BW3 = edge(I,'Sobel');
    %subplot(2,2,1), imshow(BW1)
    %subplot(2,2,2), imshow(BW2)
    %subplot(2,2,3), imshow(BW3)
    xDirection = [-1 0 1;-2 0 2;-1 0 1];
    yDirection = [1 2 1;0 0 0;-1 -2 -1];
    xFilter = imfilter(I,xDirection);
    yFilter = imfilter(I,yDirection);
    %subplot(2,2,1), imshow(xFilter);
    %subplot(2,2,2),imshow(yFilter);

    C=im2double(I);
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
    subplot(2,2,1),imshow(x_out);
    subplot(2,2,2),imshow(y_out);
    subplot(2,2,3),imshow(I_out);