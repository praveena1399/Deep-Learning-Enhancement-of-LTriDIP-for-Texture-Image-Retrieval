%imgpath = 'C:\Users\prave\Desktop\Databases\AT&T\Face_recognition-master\att_faces';
%destdirectory = 'C:\Users\prave\Desktop\Databases\AT&T\Face_recognition-master\att_faces\destdir';


%imgpath =  'C:\Users\prave\Desktop\Original_Brodatz\Original Brodatz';
%destdirectory = 'C:\Users\prave\Desktop\Original_Brodatz\Original Brodatz\destdir';

imgpath = 'c:\Users\prave\Desktop\Vistex';
destdirectory = 'C:\Users\prave\Desktop\VisTex\destdir';
no_in_cat=16;
height=128;
width=128;
%filePattern = fullfile(imgpath,'**\*.png');

mkdir(destdirectory);
count=0;
cn=1;

imglist  =  dir(imgpath);
imglist(strncmp({imglist.name},'.',1))=[];
imglist(strncmp({imglist.name},'.',1) | [imglist.isdir]) = [];
fvect=zeros(size(imglist,1)*25,768);
for i=1:size(imglist,1)
    n = imglist(i).name;
    imgname = [imgpath '/' n];
    

    if (n(1) ~= '.')
        Readimg = imread(imgname);
        [row,col,~] = size(Readimg);
        %[~, currentfilename, ~] = fileparts(imgname); 
        for ll=1:(height-1):row
           %ridx = floor(ll/(height-1)) +1; 
           for mm=1:(width-1):col
             %cidx = floor(mm/(width-1)) +1;
             if((ll+height)<=row && (mm+width)<=col)
                Readimg1=imcrop(Readimg,[(ll) (mm) (height-1) (width-1)]);
                
                %outfilename = sprintf('%03d_%03d_%03d.png',i,ridx,cidx);
                
                outfilename = sprintf('%03d_%03d.png',i,cn);
                %fulldestination = [destdirectory '\' n];
                fulldestination = fullfile(destdirectory,outfilename);
                
                
                imgfind = imgpro(Readimg1);
                imwrite(imgfind,fulldestination);
                count=count+1;
                if cn<no_in_cat
                  cn=cn+1;
                else
                  cn=1;
                end
                fvect(count, :) = featureVector(imgfind);
                %disp(['Feature Vector for ' outfilename ' has been extracted']);
                %sprintf('Good Going')
                
              end
             
           end
              %sprintf('Fair enough')
           
        end
         %sprintf('success')     
        
    end
end
save('fvect.mat','fvect');