function truthIMG = truthIMG(str)
    %Read image
    gt = imread('plant0'+str+'_label.png');
    %Create threshold
    T = adaptthresh(gt,1,"ForegroundPolarity","bright","Statistic","median");
    %Binarise with threshold
    truthIMG = imbinarize(gt,T);
end