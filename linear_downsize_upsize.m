clc; clear; close all;
format long;
p=2; %zoom ratio
%II=imread('gray_downsized_256by256.bmp'); %read the downsized image, 
%II=imread('gray_downsized_128by128.bmp'); %read the downsized image, 
II=imread('cameraman_128by128.bmp'); %read the downsized image, 
%Iorig = imread('gray_original_1024by1024.bmp');
Iorig = imread('cameraman.bmp'); %read the original image
Iorig=Iorig(:,:,1);
Iorig2 = im2double(Iorig);

II=II(:,:,1);s = size(II)
I=im2double(II); %Convert to double for floating point operation, it's a normalized matrix.
[x,y] = size(I)
X=round(x*p); Y=round(y*p); %New sizes of the image, rounding has been done because p can be fractional
u=1:1/p:((X-1)/p+1); v=1:1/p:((Y-1)/p+1); %new pixel locations, u in x-direction, v in y-direction
[XI,YI]=ndgrid(u,v); %Create the 2D grid of new pixels

UI=XI-floor(XI); VI=YI-floor(YI); %find UI and VI, for weight calculation purpose
X1=floor(u); Y1=floor(v); X2=floor(u)+1; Y2=floor(v)+1; %map the new pixel locations u and v to the original pixel locations

X2(find(X2>x))=x; Y2(find(Y2>y))=y;
I1=I(X1,Y1); I2=I(X1,Y2); I3=I(X2,Y1); I4=I(X2,Y2);
c1=(1-UI).*(1-VI); c2=(1-UI).*VI; c3=UI.*(1-VI); c4=UI.*VI;
B=c1.*I1+c2.*I2+c3.*I3+c4.*I4; 
size(B)
figure(1);imshow(II);
figure(2);imshow(B); 
%MSE_scratch = mean( mean( sqrt( (Iorig2-B).^2 ) ) )
format shorteng;
MSE_scratch = immse(Iorig2,B)
figure(3);imshow(Iorig2-B);
Ir = imresize(I,2,"bilinear");
%MSE_imresize = mean( mean( sqrt( (Iorig2-Ir).^2 ) ) )
MSE_imresize = immse(Iorig2,Ir)