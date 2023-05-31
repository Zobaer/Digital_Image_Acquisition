clc; clear; close all;
p=4; %zoom ratio
II=imread('cameraman.bmp'); %read the image
s = size(II)
I=im2double(II); %Convert to double for floating point operation, it's a normalized matrix.
[x,y] = size(I)
X=round(x*p); Y=round(y*p); %New sizes of the image, rounding has been done because p can be fractional
u=1:1/p:((X-1)/p+1); v=1:1/p:((Y-1)/p+1); %new pixel locations, u in x-direction, v in y-direction
[XI,YI]=ndgrid(u,v); %Create the 2D grid of new pixels

UI=XI-floor(XI); VI=YI-floor(YI); %find UI and VI, for weight calculation purpose
X1=floor(u); Y1=floor(v); X2=floor(u)+1; Y2=floor(v)+1; %map the new pixel locations u and v to the original pixel locations

X2(find(X2>x))=x; Y2(find(Y2>y))=y; %Handle the boundary case, if X2 or Y2 are >256 then make them 256
I1=I(X1,Y1); I2=I(X1,Y2); I3=I(X2,Y1); I4=I(X2,Y2); %All these I1,I2 etc. have size 1024*1024 and can be plotted as an image.
c1=(1-UI).*(1-VI); c2=(1-UI).*VI; c3=UI.*(1-VI); c4=UI.*VI; %Calculate the weights based on UI and VI
B=c1.*I1+c2.*I2+c3.*I3+c4.*I4; 
size(B)
figure(1);imshow(II); title("Original small-sized image");
figure(2);imshow(B); title("Using linear interpolation code from scratch");
Ir = imresize(I,4,"bilinear");
figure(3);imshow(Ir); title("Using 'imresize()' ('linear')");
MSE = mean( mean( sqrt( (Ir-B).^2 ) ) )