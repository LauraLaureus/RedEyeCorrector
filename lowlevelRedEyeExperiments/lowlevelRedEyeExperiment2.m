clear all;
images = dir('./imgre/ojorojos*.jpg');

redEyesVector = [];

for img = 3:length(images)
    redEye = imread(['./imgre/',images(img).name]);
    REhsv = rgb2hsv(redEye);
    
    redEyeRasterized = [reshape(REhsv(:,:,1),1,[]),
                        reshape(REhsv(:,:,2),1,[]),
                        reshape(REhsv(:,:,3),1,[])];
    redEyesVector = [redEyesVector;redEyeRasterized'];
end


minHSV = min(redEyesVector);
maxHSV = max(redEyesVector);
intervalHSV = [minHSV;maxHSV]

minHSV(1,1) = max(redEyesVector(find(redEyesVector(:,1) < 0.1),1)) 

save('intervalHSV.mat','intervalHSV')
%% experimento fallido por la alta cantidad de ruido 