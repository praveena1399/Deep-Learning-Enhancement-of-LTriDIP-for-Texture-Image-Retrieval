function img = imgpro(image)
 if size(image,3)==3
     image=rgb2gray(image);
 end
 img=im2double(image);
 
 %img=imresize(img1,[180,180]);
end

