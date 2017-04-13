function [RGBc] = refillColor (mask,image)

    mask = uint8(mask);
    masked = image;
    masked(:,:,1) = image(:,:,1).*uint8(~mask);
    masked(:,:,2) = image(:,:,2).*uint8(~mask);
    masked(:,:,3) = image(:,:,3).*uint8(~mask);
    
    g = masked (:,:,2);
    b = masked (:,:,3);
    
%     gb = sum(reshape(g,1,[])+reshape(b,1,[]));
%     
%     Mean = gb/(2*nnz(~mask));
%     
%     r = mask;
%     r(mask > 0) = Mean;
%     g(mask > 0) = Mean;
%     b(mask > 0) = Mean;
%    
    RGBc = image;
    
    for i =1:size(image,1)
        for j =1:size(image,2)
            if(mask(i,j) > 0)
                
                value = (RGBc(i,j,2) +  RGBc(i,j,3))/2;
                
                RGBc(i,j,1)=value;
                RGBc(i,j,2) = value;
                RGBc(i,j,3) = value;
            end
        end
    end
    
end