function [RGBc] = refillColor (mask,image)

    mask = uint8(mask);   
    RGBc = image;
    
    for i =1:size(image,1)
        for j =1:size(image,2)
            if(mask(i,j) > 0)
                
                value = (RGBc(i,j,2) +  RGBc(i,j,3))/2;
                
                RGBc(i,j,1)= value;
                RGBc(i,j,2) = value;
                RGBc(i,j,3) = value;
            end
        end
    end
    
end