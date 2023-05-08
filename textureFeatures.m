function [ifrAVcon,ifrAVcor,ifrAVasm,ifrRAcon,ifrRAcor,ifrRAasm, ...
    rAVcon,rAVcor,rAVasm,rRAcon,rRAcor,rRAasm, ...
    gAVcon,gAVcor,gAVasm,gRAcon,gRAcor,gRAasm, ...
    bAVcon,bAVcor,bAVasm,bRAcon,bRAcor,bRAasm] = textureFeatures(DepthPatches, RGBPatches,ifrAVcon,ifrAVcor,ifrAVasm,ifrRAcon,ifrRAcor,ifrRAasm, ...
                                                                                            rAVcon,rAVcor,rAVasm,rRAcon,rRAcor,rRAasm, ...
                                                                                            gAVcon,gAVcor,gAVasm,gRAcon,gRAcor,gRAasm, ...
                                                                                            bAVcon,bAVcor,bAVasm,bRAcon,bRAcor,bRAasm)
    %Infra-red Arrays (ifr)
    %Red colour channel (r)
    %Green colour channel (g)
    %Blue colour channel (b)
    % AV = Average
    % RA = Range
    % con = Contrast
    % cor = Correlation
    % asm = Angular second moment

    %Rotation for 0, 45, 90, 135
    offsets = [0 1;-1 1;-1 0;-1 -1];
    %iterate through all patches, patch amount should be same for depth and RGB
    for i=1:length(DepthPatches)
        %Infra-red GLCM and properties
        infraRedGLCM = graycomatrix(DepthPatches{i}, Offset=offsets); infraRedStats = graycoprops(infraRedGLCM,"Contrast","Correlation","Energy");
        %Find the mean and range for each property
        ifrAVcon = [ifrAVcon,mean(infraRedStats.Contrast)]; ifrRAcon = [ifrRAcon, (max(infraRedStats.Contrast) - min(infraRedStats.Contrast))];
        ifrAVcor = [ifrAVcor,mean(infraRedStats.Correlation)]; ifrRAcor = [ifrRAcor, (max(infraRedStats.Correlation) - min(infraRedStats.Correlation))];
        ifrAVasm = [ifrAVasm,mean(infraRedStats.Energy)]; ifrRAasm = [ifrRAasm, (max(infraRedStats.Energy) - min(infraRedStats.Energy))];
    
        %Split colour channels
        [r,g,b] = imsplit(RGBPatches{i});
        %Red GLCM and properties
        redGLCM = graycomatrix(r, Offset=offsets); redStats = graycoprops(redGLCM,"Contrast","Correlation","Energy");
        %Find the mean and range for each property
        rAVcon = [rAVcon,mean(redStats.Contrast)]; rRAcon = [rRAcon, (max(redStats.Contrast) - min(redStats.Contrast))];
        rAVcor = [rAVcor,mean(redStats.Correlation)]; rRAcor = [rRAcor, (max(redStats.Correlation) - min(redStats.Correlation))];
        rAVasm = [rAVasm,mean(redStats.Energy)]; rRAasm = [rRAasm, (max(redStats.Energy) - min(redStats.Energy))];

        %Green GLCM and properties
        greenGLCM = graycomatrix(g, Offset=offsets); greenStats = graycoprops(greenGLCM,"Contrast","Correlation","Energy");
        %Find the mean and range for each property
        gAVcon = [gAVcon,mean(greenStats.Contrast)]; gRAcon = [gRAcon, (max(greenStats.Contrast) - min(greenStats.Contrast))];
        gAVcor = [gAVcor,mean(greenStats.Correlation)]; gRAcor = [gRAcor, (max(greenStats.Correlation) - min(greenStats.Correlation))];
        gAVasm = [gAVasm,mean(greenStats.Energy)]; gRAasm = [gRAasm, (max(greenStats.Energy) - min(greenStats.Energy))]; 
        
        %Blue GLCM and properties
        blueGLCM = graycomatrix(b, Offset=offsets); blueStats = graycoprops(blueGLCM,"Contrast","Correlation","Energy");
        %Find the mean and range for each property
        bAVcon = [bAVcon,mean(blueStats.Contrast)]; bRAcon = [bRAcon, (max(blueStats.Contrast) - min(blueStats.Contrast))];
        bAVcor = [bAVcor,mean(blueStats.Correlation)]; bRAcor = [bRAcor, (max(blueStats.Correlation) - min(blueStats.Correlation))];
        bAVasm = [bAVasm,mean(blueStats.Energy)]; bRAasm = [bRAasm, (max(blueStats.Energy) - min(blueStats.Energy))];
    end
end