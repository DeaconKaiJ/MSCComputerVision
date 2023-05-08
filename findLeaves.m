function plantNumber = findLeaves(segIMG)
    %Range for circles
    Rmin = 5;
    Rmax = 100;
    %Find circles
    [centers,radii,metric] = imfindcircles(segIMG, [Rmin, Rmax]);
    %Visualise circles on last image
    viscircles(centers, radii,'Color','b');
    %Number of circles is the number of plants
    plantNumber = length(metric);
end