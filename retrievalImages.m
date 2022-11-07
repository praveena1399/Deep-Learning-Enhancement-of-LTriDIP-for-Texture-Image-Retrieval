function no_retr = retrievalImages()
no_retr = NaN;
tot = 3; % how many attempts to make
while isnan(no_retr) && tot>0
    no_retr = str2double(input('Enter number of images to retrieve :', 's'));
    tot = tot-1;
end
end