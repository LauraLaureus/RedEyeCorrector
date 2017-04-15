function [shapes] = shapeFiltering(labeledImg)

     W = size(labeledImg,2);
     H = size(labeledImg,1);
%     
    kmin = 1/50;
    kmax = 1/2;
    
    props = regionprops(labeledImg,'Extrema');
    
    labelsToRemove = [];
    
    for i = 1:length(props)
        [w,h] = getDimensionOfArea(props(i).Extrema);
        if ((w/h)> 0.25*(W/H)) || ((w/h) < (W/H)*1.75) 
            labelsToRemove = [labelsToRemove i];
            continue
        end
        if kmax*W < w || kmin*W > w
            labelsToRemove = [labelsToRemove i];
            continue
        end
        
        if kmax*H < h || kmin*H > h
            labelsToRemove = [labelsToRemove i];
            continue
        end
        
    end
    
    if length(labelsToRemove) > 0
        shapes = removeLabels(labeledImg,labelsToRemove);
    else
        shapes = labeledImg;
    end
    
end

function [w,h] = getDimensionOfArea(extrema)
    interpolatedTopLeftCorner = (extrema(8,:)+extrema(1,:))/2;
    interpolatedBottomRightCorner = (extrema(4,:)+extrema(5))/2;
    
    w = interpolatedBottomRightCorner(2) - interpolatedTopLeftCorner(2);
    h = interpolatedBottomRightCorner(1) - interpolatedTopLeftCorner(1);
end

function [shapes] =removeLabels(labeledImg,labelsToRemove)

shapes = labeledImg;

for l = 1:length(labelsToRemove)
    shapes(shapes == labelsToRemove(l)) = 0;
end

end