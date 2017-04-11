function [d detectionImg] = interquantileRednessDetector(RGBimg)
rednessImg = redness(RGBimg);

rasterRedImg = reshape(rednessImg,1,[]);
q1 = quantile(rasterRedImg,0.25);
q3 = quantile(rasterRedImg,0.75);

iqr = q3-q1;

d = 0;
detectionImg = zeros(1,length(rasterRedImg));
for i = 1:length(rasterRedImg)
    if rasterRedImg(i) > q3
        d = d+1;
        detectionImg(i) = 1;
    end
end

detectionImg = reshape(detectionImg, size(rednessImg));
end