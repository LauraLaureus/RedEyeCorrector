function [desaturatedEyesRGB] = desaturate(redMask,medianS,medianVp,hsvEyesRegion)

for i = 1:size(hsvEyesRegion,1)
    for j = 1:size(hsvEyesRegion,2)
        if (redMask(i,j) > 0)
            hsvEyesRegion(i,j,2) = medianS;
            hsvEyesRegion(i,j,3) = medianVp;
        end
    end
end

desaturatedEyesRGB = hsv2rgb(hsvEyesRegion);

end
    