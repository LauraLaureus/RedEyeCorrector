function [img] = copyOverImg(img,section,rect)

rect = round(rect);

x = 1;
for i = rect(2):(rect(2)+rect(4))
    y = 1;
    for j = rect(1):(rect(1)+rect(3))
        img(i,j,1) = section(x,y,1);
        img(i,j,2) = section(x,y,2);
        img(i,j,3) = section(x,y,3);
        y = y+1;
        if y > size(section,2), break,end
    end
    x = x+1;
    if x > size(section,1), break,end
end

end