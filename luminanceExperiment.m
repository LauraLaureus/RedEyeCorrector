I = imread('./imgre/ojo2.jpg');
lum  = luminance (I);
imshow(lum);

I = imread('./imgre/ojo1.jpg');
lum  = luminance (I);
figure,imshow(lum);

I = imread('./imgre/ojo3.jpg');
lum  = luminance (I);
figure,imshow(lum);

I = imread('./imgre/ojo4.jpg');
lum  = luminance (I);
figure,imshow(lum);

I = imread('./imgre/ojo5.jpg');
lum  = luminance (I);
figure,imshow(lum);

I = imread('./imgre/ojo6.jpg');
lum  = luminance (I);
figure,imshow(lum);

I = imread('./imgre/ojo7.jpg');
lum  = luminance (I);
figure,imshow(lum);

Ia = imadjust(lum,[quantile(reshape(lum,1,[]),0.9) 1],[]); %0.5
figure,imshow(Ia);

Ih = histeq(lum);
figure,imshow(Ih);