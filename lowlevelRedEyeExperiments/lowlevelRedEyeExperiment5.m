clear all;
images = dir('./imgre/ojo*.jpg');


for img = 3:length(images)
    redEye = imread(['./imgre/',images(img).name]);
    figure, subplot(2,1,1), imshow(redEye);
    mask = getMask(redEye);
    subplot(2,1,2), imshow(mask);
end
