function error = calculateError(x, y, px, py)
    error = [];
    for i = 1:length(x)
        e = sqrt((x(i) - px(i))^2 + (y(i) - py(i))^2);
        error = [error, e];
    end    
end