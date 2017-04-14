function goodness(filePath)
I = imread(filePath);

redMap = redness(I);
q60 = quantile(reshape(redMap,1,[]),0.6);
OriginalThresholded = threshold(redMap,q60);


filtered = removeRedEyes(filePath);
redMap2 = redness(filtered);
FilteredThresholded = threshold(redMap2,q60);

figure, subplot (3,1,1), imshow(OriginalThresholded)
subplot(3,1,2),imshow(FilteredThresholded)


positive = redMap - redMap2;
subplot(3,1,3),imshow(positive);


npos = nnz(positive);
disp(['Number pixels getting positive: ',num2str(npos)]);

disk2 = strel('square',7);
fpositive = imopen(positive,disk2);
figure,imshow(fpositive);

fpos =  nnz(fpositive);
disp(['Minimum number pixels getting false positive: ',num2str(fpos)]);
disp(['Percentaje false Positive: ',num2str(fpos/npos)]);
end 