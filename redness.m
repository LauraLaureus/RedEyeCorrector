function [RdnsImage] = redness(RGBimage)

RdnsImage = double(zeros(size(RGBimage,1),size(RGBimage,2)));

for i = 1:size(RGBimage,1)
    for j = 1:size(RGBimage,2)
        RdnsImage(i,j) = RGBimage(i,j,1)^2;
        RdnsImage(i,j) = RdnsImage(i,j)/(RGBimage(i,j,2)^2+RGBimage(i,j,3)^2 + 1);
    end
end

end