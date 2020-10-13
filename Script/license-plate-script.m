addpath('c:\VSG_IPA_toolbox');

clc;
%%
%---- Looping all the given input images ----%
for k = 1:3
    %---- Specifying the directory of the input images ----%
    fileName = strcat('C:\Users\japes\Documents\MATLAB\number_plate_', num2str(k),'.jpg');
    if exist(fileName, 'file')
        in_img1a = openimage(fileName);
    else
        fprintf('File %s does not exist.\n',fileName);
    end
    %---- Displaying the given input image ----%
    h=figure; imshow(uint8(in_img1a)); colormap(gray); set(h,'Name','Input Image');
    img1 = vsg('GreyScaler',in_img1a);
    %%
    %---- Obtaining the binary image after it has been thresholded ----%
    img2 = vsg('OtsuSeg',img1);
    %h=figure; imshow(uint8(img2)); colormap(gray); set(h,'Name','Otsu Segmented Image');

    %%
    %---- Procedure to find the biggest blob in the image ----%
    
    img4 = vsg('BiggestBlob',img2);
    %h=figure; imshow(uint8(img4)); colormap(gray); set(h,'Name','Biggest Blob Result Image');
    img5 = vsg('NOT',img4);
    %h=figure; imshow(uint8(img5)); colormap(gray); set(h,'Name','Binary Image');
    img6 = vsg('BiggestBlob',img5);
    img7 = vsg('Subtract',img5,img6);
    %h=figure; imshow(uint8(img7)); colormap(gray); set(h,'Name','Biggest Blob Eliminated Image');
    %%
    %---- Filtering the image ----%
    img8 = vsg('RAFilter',img7,9);
    %h=figure; imshow(uint8(img8)); colormap(gray); set(h,'Name','RAFilter');
    %%
    %---- Thresholding the image ----%
    img9 = vsg('MidThresh',img8);
    %h=figure; imshow(uint8(img9)); colormap(gray); set(h,'Name','Thresholded Image');
    %%
    %--- Contracting the bright region and spreading the dark region ----%
    img9a = vsg('SINFilter',img9);
    img9b = vsg('SINFilter',img9a);
    img9c = vsg('SINFilter',img9b);
    img9d = vsg('SINFilter',img9c);
    %---- Spreading bright region and contracting the dark region----%
    img9e = vsg('LINFilter',img9d);
    img9f = vsg('LINFilter',img9e);
    img9g = vsg('LINFilter',img9f);
    %h=figure; imshow(uint8(img9g)); colormap(gray); set(h,'Name','Filtered Image');
    %%
    %---- To locate the smallest blob in the image ----%
    img10 = vsg('SmallestBlob',img9g);
    %h=figure; imshow(uint8(img10)); colormap(gray); set(h,'Name','Smallest Blob Image');
    %%
    %---- Eliminating the smallest blobs to obtain the characters ----%
    img11 = vsg('Subtract',img9g,img10);
    img12 = vsg('SmallestBlob',img11);
    img13 = vsg('Subtract',img11,img12);
    h=figure; imshow(uint8(img13)); colormap(gray); set(h,'Name','Characters found');
    %%
    %---- Centroid of each blob is calculated ----%
    img14=vsg('Centroid',img13);
    %---- Counting the number of White pixels in the image ----%
    [pix2]=vsg('WPCounter',img14);
    str=['The number of characters found in the Image : ' num2str(pix2)];
    disp(str);
    %%
    %---- Overlaying the input image and the processed image ----%
    img15 = vsg('Point2Cross',img13);
    img16 = vsg('Add',img15,in_img1a);
    h=figure; imshow(uint8(img16)); colormap(gray); set(h,'Name','Output Image');
    %%
end

pause;
figs = get(0, 'Children');
close(figs(figs ~= gcf))