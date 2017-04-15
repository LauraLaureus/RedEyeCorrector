function [lum] = luminance(Img)

lum = rgb2hsv(Img);
lum = lum(:,:,2).*lum(:,:,3);

end