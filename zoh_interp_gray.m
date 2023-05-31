clc; clear; close all;
p=4; 
I=imread('cameraman.bmp');
[x,y] = size(I);
X=round(x*p); Y=round(y*p); 
u=1:1/p:((X-1)/p+1); v=1:1/p:((Y-1)/p+1);
U=round(u); V=round(v);
U(find(U>x))=x; V(find(V>y))=y;
B = I(U,V);
figure(1);imshow(I); title("Original small-sized image");
figure(2);imshow(B); title("Using ZOH interpolation code from scratch");
Ir = imresize(I,4,"nearest");
figure(3);imshow(Ir); title("Using 'imresize()' ('nearest')");
MSE = mean( mean( sqrt( (im2double(Ir)-im2double(B)).^2 ) ) )