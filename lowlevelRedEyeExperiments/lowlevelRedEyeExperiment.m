I = imread('./imgre/ojo8.jpg');
imtool(I);

%se asume que se ha exportado la sección de ojo rojo con el nombre redEye.

redEyeRasterized = [reshape(redEye(:,:,1),1,[]),
                    reshape(redEye(:,:,2),1,[]),
                    reshape(redEye(:,:,3),1,[])];
redEyeRasterized = redEyeRasterized';

%los componentes RGB de cada pixel están en cada línea

minRGB = min(redEyeRasterized);
maxRGB = max(redEyeRasterized);
intervalRGB = [minRGB;maxRGB]
%Se muestra los valores mínimos y máximos de RGB

coverage = double(intervalRGB(2,:) - intervalRGB(1,:))/255

%% Repetimos el experimento en el espacio HSV

REhsv = rgb2hsv(redEye);

redEyeRasterized = [reshape(REhsv(:,:,1),1,[]),
                    reshape(REhsv(:,:,2),1,[]),
                    reshape(REhsv(:,:,3),1,[])];
redEyeRasterized = redEyeRasterized';

%los componentes RGB de cada pixel están en cada línea

minHSV = min(redEyeRasterized);
maxHSV = max(redEyeRasterized);
intervalHSV = [minHSV;maxHSV]
%Se muestra los valores mínimos y máximos de RGB

%% ¿El intervalo es correcto para demás imágenes?
figure, imshow(imread('./imgre/ojo7.jpg'));
I2hsv = rgb2hsv(imread('./imgre/ojo7.jpg'));
toNull = zeros(1,1,3);
I2show = I2hsv;

for r = 1:size(I2hsv,1)
    for c = 1:size(I2hsv,2)
        if ~((I2hsv(r,c,1) < intervalHSV(1,1) || I2hsv(r,c,1) > intervalHSV(2,1))&&(I2hsv(r,c,2) > intervalHSV(1,2) && I2hsv(r,c,2) < intervalHSV(2,2))&&(I2hsv(r,c,3) > intervalHSV(1,3) && I2hsv(r,c,3) < intervalHSV(2,3)))
            I2show(r,c,:) = toNull;
        end
    end
end

I2show = hsv2rgb(I2show);
figure,imshow(I2show);

nnz(I2show) %devuelve 93;
