function [mask] = removeSkinModal(RGB)

mask = ones(size(RGB,1),size(RGB,2));
CgImg = mask;
CrImg = mask;

for i = 1:size(RGB,1)
    for j = 1:size(RGB,2)
        
        RGBp = reshape(RGB(i,j,:),3,1);
        [Cg,Cr] = ycgcrRotated(RGBp);
        CgImg(i,j) = Cg;
        CrImg(i,j) = Cr;
%         if(Cg <= 140 && Cg >=125) && (Cr <=217 && Cr >=136)
%             mask(i,j) = 0;
%         end
        
    end
end

CgMode = mode(reshape(CgImg,1,[]));
CrMode = mode(reshape(CrImg,1,[]));
CgModeP = CgMode;
CrModeP = CrMode;


while sqrt((CgMode-CgModeP)^2 + (CrMode-CrModeP)^2) < 0.1
    
for i = 1:size(RGB,1)
    for j = 1:size(RGB,2)

        if(CgImg(i,j) <= CgMode*1.07 && CgImg(i,j) >=CgMode*0.93) && (CrImg(i,j) <=CrMode*1.07 && CrImg(i,j) >=CrMode*0.93)
            mask(i,j) = 0;
        end
        
    end
end

CgModeP = CgMode;
CrModeP = CrMode;

CgMode = mode(reshape(CgImg,1,[]).*reshape(mask,1,[]));
CrMode = mode(reshape(CrImg,1,[]).*reshape(mask,1,[]));
sqrt((CgMode-CgModeP)^2 + (CrMode-CrModeP)^2)
end


end

function [Cg,Cr] = ycgcrRotated(RGBp)

RGBp = double(RGBp);
yCgCr = [0.257,0.504,0.098;
        -0.317,0.438,-0.121;
        0.439,-0.368,-0.071];
bias = [16;128;128];

YCgCrp = yCgCr*RGBp+bias;

Cg = YCgCrp(2)*cos(deg2rad(30))+YCgCrp(3)*sin(deg2rad(30))-48;
Cr = -YCgCrp(2)*sin(deg2rad(30))+YCgCrp(3)*cos(deg2rad(30))+80;

end