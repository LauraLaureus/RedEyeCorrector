function [RdnsImage] = redness(RGBimage)

RdnsImage = rgb2hsv(RGBimage);

for i = 1:size(RGBimage,1)
    for j = 1:size(RGBimage,2)
        if RdnsImage(i,j,1) < 0.1 || RdnsImage(i,j,1) > 0.9
            RdnsImage(i,j,1) = 255 * RdnsImage(i,j,2) * RdnsImage(i,j,3);
        else
            RdnsImage(i,j,1) = 0;
        end
    end
end

RdnsImage = RdnsImage(:,:,1);
end