clc;
clear all;
close all;
I=imread('fab_def.jpg');
I=rgb2gray(I);
I=medfilt2(I);
%I2=histeq(I);
figure;
imshow(I);
[M,N]=size(I);
%% ideal low pass filtering
F=fft2(I);
u=0:(M-1);
v=0:(N-1);
idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>N/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
 D=sqrt(U.^2+V.^2);
 
 %% filtering the image
 P=max(max(F));
 H=double(D<=P);       % Comparing with the cut-off frequency 
 G=H.*F;               % Convolution with the Fourier transformed image
 g=real(ifft2(double(G))); % Inverse Fourier transform
 figure;
 imshow(I),figure,imshow(g,[ ]); % Displaying input and output image
 
%% Edge detection
I3=edge(g,'sobel');
figure;
imshow(I3);
I4 = imclose(I3, strel('line', 15, 90));
I5 = imopen(I4, strel('line', 5, 0));
I5 = bwareaopen(I5, 200);
figure;
imshow(I5);
%% erosion and dilution
sel=strel('line',300,90);
I6=imclose(I5,sel);
figure;
imshow(I6);
I7 = I.*uint8(I6);
figure;
imshow(I7);