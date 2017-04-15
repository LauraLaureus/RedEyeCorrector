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
        %se extrae la secci�n de la cara que tiene m�s probabilidad de tener
        %los ojos
        face = imcrop(I,detFaces(i,:));
        eyesRect = calculateFrecuentEyeRegion(face);
        eyesRegion = imcrop(face,eyesRect);
    end
    
    

    %se crea un mapa de "rojez"
    redMap = redness(eyesRegion);
    
    
    %se crea una m�scara donde a 0 est�n todos los p�xeles que pueden ser
    %piel
    eyesRegionG = imgaussfilt(eyesRegion,1);
    mask = removeSkinModal(eyesRegionG);
   
    
    %se crea una m�scara donde a 0 est�n todos los p�xeles que se
    %encuentran debajo del valor del quantil 60%
    redMask = threshold(redMap,quantile(reshape(redMap,1,[]),0.6));

    mask = imdilate(mask,disk);
    redMask = imdilate(redMask,disk);
    
    %se genera la m�scara intersecci�n de ambos
    intersectionMask =  mask .* redMask;
    
    %se limpia la m�scara intersecci�n
    intersectionMask = imerode(intersectionMask,disk);
    
    %se obtiene una m�scara de lo que no son los ojos
    NonEyesMask = imopen(intersectionMask,strel('square',round(size(intersectionMask,2)/12)));
    
    %se obtiene una segunda intersecci�n 
    mask2 = intersectionMask .* ~NonEyesMask;
    
    img = refillColor(mask2,eyesRegion); 
    face = copyOverImg(face,img,eyesRect);
   

    if detFaces(1) > 0
        I = copyOverImg(I,face,detFaces(i,:));
    else
        I = face;
    end
    
    if iImagesRequired
        figure,imshow(eyesRegion),title('Region de los Ojos');
        figure,subplot(3,1,1), imshow(mask),title('M�scara elimina la piel');
        subplot(3,1,2),imshow(redMask),title('M�scara roja');
        subplot(3,1,3), imshow(intersectionMask),title('M�scara intersecci�n');
        figure, subplot(3,1,1), imshow(intersectionMask),title('M�scara intersecci�n');
        subplot(3,1,2), imshow(NonEyesMask),title('M�scara no ojos');
        subplot(3,1,3), imshow(mask2),title('M�scara intersecci�n 2');
        figure,imshow(uint8(img)),title('Image');
        if detFaces(1) > 0
            figure,imshow(uint8(face)),title('Cara');
            figure,imshow(uint8(I)),title('I');
        end
    end
end
result = I;

end