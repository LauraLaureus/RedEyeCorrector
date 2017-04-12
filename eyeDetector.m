clear all;
I = imread('./imgre/ojo3.jpg');

FDetector = vision.CascadeObjectDetector;

imshow(I);

faces = step(FDetector,I);
disk = strel('disk',2);
hold on;

for i = 1:size(faces,1)
    %rectangle('Position',faces(i,:));
    face = imcrop(I,faces(i,:));
    eyesRegion = imcrop(face,calculateFrecuentEyeRegion(face));
    
    redMap = redness(eyesRegion);
    %figure,imshow(uint8(redMap));
    
    eyesRegionG = imgaussfilt(eyesRegion,1);
    mask = removeSkinModal(eyesRegionG);
    %figure,imshow(mask);
    
%     skinSegmentation = applyMask(double(eyesRegion),mask);
%     figure,imshow(uint8(skinSegmentation));
%    
    closedSegmentation = imclose(mask,disk);
    
    % para testear solo
%     skinSegmentationClosed = applyMask(double(eyesRegion),closedSegmentation);
%     figure,imshow(uint8(skinSegmentationClosed));
%     
    [labeled,l] = bwlabel(closedSegmentation);
    
    if l > 2
        [shapes] = shapeFiltering(labeled);
    end
    mask2 = uint8( im2bw(shapes,0.5));
    shapeFiltered = applyMask(double(eyesRegion),double(mask2));
    figure,imshow(uint8(shapeFiltered));
    
    rednessMaskered = redMap.*double(mask2);
    %figure,imshow(uint8(rednessMaskered),colormap(jet));
    redMaskdThresholded = threshold(rednessMaskered,50);
    %figure,imshow(uint8(redMaskdThresholded),colormap(jet));
    
    redMaskdT2 = uint8(im2bw(redMaskdThresholded,0.5));
   
    hsvEyesRegion = rgb2hsv(eyesRegion);
    desaturatedEyesRGB = desaturate(imclose(redMaskdT2,disk),0,0,hsvEyesRegion);
    figure,imshow(desaturatedEyesRGB);
end
