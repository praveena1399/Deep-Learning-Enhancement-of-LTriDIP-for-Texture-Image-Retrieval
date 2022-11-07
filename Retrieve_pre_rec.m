%SECOND PART FOR PRECISION AND RECALL


% query image. Change your image name here



%queryimage = '001_001.png';



% number of similar images to be found

%fullFileName = fullfile(destdirectory,queryimage);
%if exist(fullFileName,'file')
%  imgquery=imread(fullFileName);
%else
%        warningMessage = sprintf('File not found:\n%s', fullFileName);

%end


% get feature vectors
% Image_query = imgpro(imgquery);
%feature_query = featureVector(imgquery);
%disp(['Feature Vector for query image has been extracted.']);



load('fvect.mat');
precision = zeros(5,1);
recall = zeros(5,1);
dist = zeros(640,1);
nsimarr = [16 32 64 80 96];

for nnsim = 1:length(nsimarr)


nsim = nsimarr(nnsim);
no_in_cat=16;
no_cat = 40;
imnumber=0;


imglist = dir(destdirectory);
imglist(strncmp({imglist.name},'.',1))=[];
imglist(strncmp({imglist.name},'.',1) | [imglist.isdir]) = [];
%precision = zeros(size(imglist,1),1);
%recall = zeros(size(imglist,1),1);
precision2 = 0;
recall2 = 0;


for ff=1:size(imglist,1)
   gg = imglist(ff).name;
   queryimage = gg;
   fullFileName = fullfile(destdirectory,queryimage);
   imgquery = imread(fullFileName);
   imgquery = imgpro(imgquery);
   feature_query = featureVector(imgquery);




for aa=1:size(imglist,1)
    n = imglist(aa).name;

    imgname = [destdirectory '\' n];

    if (n(1) ~= '.')
        dist(aa,:) = sMeasure(feature_query,fvect(aa,:));
    end
end


% To skip the query image, we change 0 distance to any large number
m = max(dist);

new_dist = zeros(size(dist,1), 1);
for bb=1:size(dist,1)
    if (dist(bb)==0)
        new_dist(bb) = 2*m;
    else
        new_dist(bb) = dist(bb);
    end
end

clear aa bb n 

% Display query image
%figure;
%subplot(1,nsim,1);
%imshow(imread(fullFileName));
%title('query image');

for cc=1:nsim
    % find closest object according to eucledian distance
    idxclosest = find(new_dist == min(new_dist));
    n = imglist(idxclosest).name;
    imgres= imread([destdirectory '/' n]);
    %subplot(1,nsim,cc+1);
    %figure;
    %imshow(imgres);
    %title(['Closest image rank of ' num2str(cc)]);
    query_name_split=split(queryimage,"_");
    for dd=1:no_in_cat
      
       if(strcmp(n, strcat(query_name_split(1,1),{'_0'},num2str(dd),{'.png'})))
         if imnumber < no_in_cat
           imnumber=imnumber+1;
         else
           imnumber=0;
          end
         
        end
     end
     
    new_dist(idxclosest) = m; % To retrieve the next nearest image
end

%precision(ff,:) = (imnumber/nsim)*100;
precision1 = (imnumber/nsimarr(nnsim))*100;
precision2 = precision2 + precision1;
%recall(ff,:) = (imnumber/no_in_cat)*100;
recall1 = (imnumber/no_in_cat)*100;
recall2 = recall2 + recall1;


end

precision(nnsim,:) = precision2/(no_in_cat * no_cat);
recall(nnsim,:) = recall2/(no_in_cat * no_cat);

end





figure;
plot(nsimarr,precision);
title('Precision Curve');
xlabel('No. of images retrieved');
ylabel('Precision %');

figure;
plot(nsimarr,recall);
title('Recall Curve');
xlabel('No. of images retrieved');
ylabel('Recall %');
