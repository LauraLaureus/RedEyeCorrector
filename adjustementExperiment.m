I = imread('./imgre/ojo6.jpg');
figure, imshow(I);
Ihsv = rgb2hsv(I);

Ihsv(:,:,3) = imadjust(Ihsv(:,:,3));
figure, imshow(hsv2rgb(Ihsv));

Ic = hsv2rgb(Ihsv);
mask = getMask3(Ic);
figure, imshow(mask);

disk = strel('disk',2);
mask2 = imdilate(imopen(mask,disk),disk);
imshow(mask2(:,:,1));
