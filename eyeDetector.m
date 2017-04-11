clear all;
I = imread('./imgre/ojo1.jpg');

FDetector = vision.CascadeObjectDetector;

imshow(I);

faces = step(FDetector,I);

hold on;

for i = 1:size(faces,1)
    rectangle('Position',faces(i,:));
    face = imcrop(I,faces(i,:));
    eyesRegion = imcrop(face,calculateFrecuentEyeRegion(face));
    figure,imshow(eyesRegion);
end
