function [mask] = getMask(I)
mask = zeros(size(I));

Ihsv = rgb2hsv(I);
for r = 1:size(I,1)
    for c= 1:size(I,2)
        if(Ihsv(r,c, 1) < 0.1 || Ihsv(r,c, 1) > 0.9) && (Ihsv(r,c,2) > 0.7)
            mask(r,c,:) = ones(1,1,3);
        end
    end
end
end