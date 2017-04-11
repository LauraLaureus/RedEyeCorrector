function [img] = applyMask(Img,mask)
img = Img;

for c = 1:size(Img,3)
    img(:,:,c) = Img(:,:,c).*mask;
end
end