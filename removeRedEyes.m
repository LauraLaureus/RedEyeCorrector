function [result] = removeRedEyes(fileName)
I = imread(fileName);
FDetector = vision.CascadeObjectDetector;
disk = strel('disk',2);


detFaces = step(FDetector,I);

if size(detFaces,1) == 0
    detFaces = [0 0 size(I,2) size(I,1)];
end

for i = 1:size(detFaces,1)
    %se extrae la cara
    face = imcrop(I,detFaces(i,:));
    %se extrae la secci�n de la cara que tiene m�s probabilidad de tener
    %los ojos
    eyesRegion = imcrop(face,calculateFrecuentEyeRegion(face));
    figure,imshow(eyesRegion),title('RegionOjos');
    %se crea un mapa de "rojez"
    redMap = redness(eyesRegion);
    %se crea una m�scara donde a 0 est�n todos los p�xeles que pueden ser
    %piel
    eyesRegionG = imgaussfilt(eyesRegion,1);
    mask = removeSkinModal(eyesRegionG);
    %se crea una m�scara donde a 0 est�n todos los p�xeles que se
    %encuentran debajo del valor del quantil 60%
    redMask = threshold(redMap,quantile(reshape(redMap,1,[]),0.6));
    figure, imshow(redMask),title('M�scara roja');
    %se genera la m�scara intersecci�n de ambos
    intersectionMask = imclose(mask,disk) .* imclose(redMask,disk);
    figure, imshow(intersectionMask),title('M�scara intersecci�n');
    
    [lbls,l] = bwlabel(intersectionMask);
    if l > 2
        [shapes] = shapeFiltering(lbls);
    else 
        shapes = intersectionMask;
    end
    
    mask2 = uint8( im2bw(shapes,0.5));
    shapeFiltered = applyMask(double(eyesRegion),double(mask2));
    figure,imshow(uint8(shapeFiltered)),title('M�scara filtrada por forma');
    
    img = refillColor(intersectionMask,eyesRegion);
    figure,imshow(uint8(img)),title('Image');
end
result = I;

end