clear all;
I = imread('./imgre/ojo6.jpg');

FDetector = vision.CascadeObjectDetector;

imshow(I);

faces = step(FDetector,I);
disk = strel('disk',2);
hold on;

for i = 1:size(faces,1)
    %rectangle('Position',faces(i,:));
    face = imcrop(I,faces(i,:));
    eyesRegion = imcrop(face,calculateFrecuentEyeRegion(face));
    eyesRegionG = imgaussfilt(eyesRegion,1);
    mask = removeSkinModal(eyesRegionG);
    %figure,imshow(mask);
    skinSegmentation = applyMask(double(eyesRegion),mask);
    figure,imshow(skinSegmentation);
    %closedSegmentation = imclose(mask,disk);
    %figure,imshow(uint8(closedSegmentation));
    %[labeled l] = bwlabels(mask);
    
end
