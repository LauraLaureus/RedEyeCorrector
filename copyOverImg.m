function [img] = copyOverImg(img,section,rect)

rect = round(rect);
for i = rect(1):(rect(1)+rect(3))
    for j = rect(2):(rect(2)+rect(4))
        img(i,j,1) = section(i-rect(1)+1,j-rect(2)+1,1);
        img(i,j,2) = section(i-rect(1)+1,j-rect(2)+1,2);
        img(i,j,3) = section(i-rect(1)+1,j-rect(2)+1,3);
    end
end

end