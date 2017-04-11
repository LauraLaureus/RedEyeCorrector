function [rect] = calculateFrecuentEyeRegion(Image)

width = size(Image,2);
height = size(Image,1);

blockDim = [width/5,height/4];

rect = [blockDim 4*width/5 height/2];

end