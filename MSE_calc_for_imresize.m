clc;clear; close all;
I = imread('cameraman.bmp'); %read the original image
II=imread('cameraman_128by128.bmp'); %read the downsized image, 
Ir_zoh = imresize(II,2,"nearest");
Ir_lin = imresize(II,2,"bilinear");
Ir_bicubic = imresize(II,2,"bicubic");
MSE_zoh = immse(I,Ir_zoh(:,:,1))
MSE_lin = immse(I,Ir_lin(:,:,1))
MSE_bicubic = immse(I,Ir_bicubic(:,:,1))