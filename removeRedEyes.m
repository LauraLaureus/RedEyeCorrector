function [result] = removeRedEyes(fileName,printImages)

iImagesRequired = true;

if nargin == 2
    iImagesRequired = printImages;
end

I = imread(fileName);
FDetector = vision.CascadeObjectDetector;
disk = strel('disk',2);


detFaces = step(FDetector,I);

if size(detFaces,1) == 0
    detFaces = [0 0 size(I,2) size(I,1)];
end


for i = 1:size(detFaces,1)
    %se extrae la cara
    
    if (detFaces(1) == 0)
        face = I;
        eyesRect = [1 1 size(I,2) size(I,1) ];
        eyesRegion = I;
    else 
        face = imcrop(I,detFaces(i,:));
        eyesRect = calculateFrecuentEyeRegion(face);
        eyesRegion = imcrop(face,eyesRect);
    end
    
    %se extrae la sección de la cara que tiene más probabilidad de tener
    %los ojos
    
    
    if iImagesRequired
        figure,imshow(eyesRegion),title('RegionOjos');
    end
    
    %se crea un mapa de "rojez"
    redMap = redness(eyesRegion);
    
    
    %se crea una máscara donde a 0 están todos los píxeles que pueden ser
    %piel
    eyesRegionG = imgaussfilt(eyesRegion,1);
    mask = removeSkinModal(eyesRegionG);
    
    if iImagesRequired
        figure, imshow(mask),title('Máscara elimina la piel');
    end
    
    
    %se crea una máscara donde a 0 están todos los píxeles que se
    %encuentran debajo del valor del quantil 60%
    redMask = threshold(redMap,quantile(reshape(redMap,1,[]),0.5));
    
    if iImagesRequired
        figure, imshow(redMask),title('Máscara roja');
    end
    
%     lumMap = luminance(eyesRegion);
    
    %se genera la máscara intersección de ambos
    intersectionMask = imclose(mask,disk) .* imclose(redMask,disk);
    %intersectionMask = imopen(intersectionMask,disk);
    
    if iImagesRequired
        figure, imshow(intersectionMask),title('Máscara intersección');
    end
    
    [lbls,l] = bwlabel(imopen(intersectionMask,disk)); %imopen para quitar ruido
    if l > 2
        [shapes] = shapeFiltering(lbls);
    else 
        shapes = intersectionMask;
    end

    mask2 = uint8( im2bw(shapes,0.5));
   
    
    if iImagesRequired
        shapeFiltered = applyMask(double(eyesRegion),double(mask2));
        figure,imshow(uint8(shapeFiltered)),title('Máscara filtrada por forma');
    end
    
    img = imclose(mask2,disk);
    img = refillColor(mask2,eyesRegion);
    
    
    if iImagesRequired
        figure,imshow(uint8(img)),title('Image');
    end
    
 
    face = copyOverImg(face,img,eyesRect);
    
    if iImagesRequired
        figure,imshow(uint8(face)),title('Cara');
    end

    if detFaces(1) > 0
        I = copyOverImg(I,face,detFaces(i,:));
    else
        I = face;
    end
    
    if iImagesRequired
        figure,imshow(uint8(I)),title('I');
    end
end
result = I;

end