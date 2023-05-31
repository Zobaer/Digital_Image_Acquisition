clc; clear; close all;
p=4; 
I=imread('zobaer_color.bmp');
[x,y] = size(I);
s=x;
X=round(x*p); Y=round(y*p); 
u=1:1/p:((X-1)/p+1); v=1:1/p:((Y-1)/p+1);
U=round(u); V=round(v);
U(find(U>x))=x; V(find(V>y))=y;
B = I(U,V);
figure(1);imshow(I);
%figure(2);imshow(A); 

BB = B(:,1:s*p);
BB2 = B(:,s(1)*p+1:2*s*p);
BB3 = B(:,2*s(1)*p+1:3*s*p);
BB(:,:,2) = BB2; BB(:,:,3)=BB3;
size(BB)
figure(2);imshow(BB); 
