function [Mt] = threshold(Img,t)

Mt = Img;
Mt(Mt <= t) = 0;

end