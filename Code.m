%This program is written by Akshat Rana(Pre-final yar undergraduate at IIT-Guwahati)
%This program performs DCT on the image, remove the high frequency
%components and the take IDCT to get the compressed image.
%Install image processing toolbox to run this program or use MATLAB online.
%If you have any queries E-mail me at akshat7010@gmail.com
clc
clear all;
close all;
%select the file
[file,path]=uigetfile('*.*',"Select image");
getfile=strcat(path,file);
img=double(imread(getfile));
%performing the DCT on the image blockwise
T=dctmtx(8);
dct= @(block_struct) T*(block_struct.data)*T';
D=blockproc(img,[8 8],dct);
% masking the higher frequency component
mask_matrix=[1 1 1 1 0 0 0 0
      1 1 1 0 0 0 0 0
      1 1 0 0 0 0 0 0
      1 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0
      0 0 0 0 0 0 0 0];
%performing the DCT on the image blockwise
C=blockproc(D,[8 8],@(block_struct)(mask_matrix.*block_struct.data));
invdct=@(block_struct) T' * (block_struct.data)*T;
invD=blockproc(C,[8 8],invdct);

%%saving the images
imwrite(uint8(img),"original.jpg",'quality',100);
imwrite(uint8(invD),"compressed.jpg",'quality',100);

%displaing them together for comparison
figure
imshowpair(img,invD,'montage')
title('Original(left) and Compressed(right)');
