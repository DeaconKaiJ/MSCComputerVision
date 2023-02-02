function myoutput = RandomNum
    X=rand;
    disp(X)
    if X <0.7
        disp("Hello World")
    else
        disp("Goodbye World")
    end
    myoutput = X;
    return
end