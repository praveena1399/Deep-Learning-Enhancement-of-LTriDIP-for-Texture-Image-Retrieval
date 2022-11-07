function f = featureVector(image)
%im=ii;
%imwrite(image,'C:Users\prave\Desktop\AT&T\Face_recognition-master\att_faces\s10\{im}.png','png');

img=im2double(image);
%img=imresize(img,[180,180]);
if size(img,3)==3
     img=rgb2gray(img);
end
img = padarray(img,[1,1]);
[m,n]=size(img);
%sprintf('size of image is:%d %d',m,n);
%figure;
%imshow(img);
z1=zeros(8,1);
z2=zeros(8,1);
z3=zeros(8,1);
mag=zeros(8,1);
LTriDP1=zeros(m-2,n-2);
LTriDP2=zeros(m-2,n-2);
LTriDP3=zeros(m-2,n-2);
q=[1 0 0 0 0 1 1 -1 -1 1 0 -1 0 0 -1 0];
r=[0 1 -1 1 -1 0 0 0 0 0 1 0 1 -1 0 -1];

for ii=2:m-1
 for jj=2:n-1
    x=1;
    t=1;
    for k=-1:1
     for l=-1:1
	  if x<16
       if (k~=0)||(l~=0)
            d1= img(ii+k,jj+l)-img(ii,jj);
            d2= img(ii+k,jj+l)-img(ii+k+q(x),jj+l+r(x));
            p1=img(ii,jj)-img(ii+k+q(x),jj+l+r(x));
            x=x+1;
            d3= img(ii+k,jj+l)-img(ii+k+q(x),jj+l+r(x));
            p2= img(ii,jj)-img(ii+k+q(x),jj+l+r(x));
            m2=sqrt(d2^2 + d3^2);
            m1=sqrt(p1^2 + p2^2);
            x=x+1;
            c=0;
            if d1<0
              c=c+1;
             end
            if d2<0
               c=c+1;
             end
            if d3<0
              c=c+1;
             end
            if m1<m2
              mag(t)=0;
             else
              mag(t)=1;
             end
            f= mod(c,3);
            z1(t)=f;
            if t<8
               t=t+1;
             end
        end
	   end
      end
     end
    for v=1:8
       if z1(v)==1
         z2(v)=1;
        else
         z2(v)=0;
        end
       if z1(v)==2
          z3(v)=1;
        else
         z3(v)=0;
        end
     end
    for u=0:7
       LTriDP1(ii-1,jj-1)=LTriDP1(ii-1,jj-1)+((2^u)*z2(u+1));
       LTriDP2(ii-1,jj-1)=LTriDP2(ii-1,jj-1)+((2^u)*z3(u+1));
       LTriDP3(ii-1,jj-1)=LTriDP3(ii-1,jj-1)+((2^u)*mag(u+1));
     end
  end
 end
LTriDP1=uint8(LTriDP1);
LTriDP2=uint8(LTriDP2);
LTriDP3=uint8(LTriDP3);

H1=imhist(LTriDP1);
H2=imhist(LTriDP2);
H3=imhist(LTriDP3);
jointhist=[H1(:);H2(:);H3(:)];
f=jointhist';
end


