clc; clear; close all;
format long;
p=2; 
%II=imread('gray_downsized_256by256.bmp'); %read the downsized image, 
%II=imread('gray_downsized_128by128.bmp'); %read the downsized image, 
II=imread('cameraman_128by128.bmp'); %read the downsized image, 
%Iorig = imread('gray_original_1024by1024.bmp');
Iorig = imread('cameraman.bmp'); %read the original image
Iorig=Iorig(:,:,1);
II=II(:,:,1);s = size(II)
%I=im2double(II);
[x,y] = size(II)
s=x;
X=round(x*p); Y=round(y*p); 
u=1:1/p:((X-1)/p+1); v=1:1/p:((Y-1)/p+1);
U=round(u); V=round(v);
U(find(U>x))=x; V(find(V>y))=y;
B = II(U,V);
figure(1);imshow(II);
figure(2);imshow(B); 
%MSE_scratch = mean( mean( sqrt( (im2double(Iorig)-im2double(B)).^2 ) ) )
format shorteng;
MSE_scratch = immse(im2double(Iorig),im2double(B))
figure(3);imshow(Iorig-B);
Ir = imresize(II,2,"nearest");
%MSE_imresize = mean( mean( sqrt( (im2double(Iorig)-im2double(Ir)).^2 ) ) )
MSE_imresize = immse(im2double(Iorig),im2double(Ir))
