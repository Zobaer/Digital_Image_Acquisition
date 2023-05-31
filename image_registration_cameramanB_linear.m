clc; clear; close all;
Iref=imread('cameraman.bmp'); Iref_size = size(Iref)
figure(1);subplot(121);imshow(Iref); 
Iinp = imread('cameramanB.bmp'); Iinp_size = size(Iinp)
subplot(122);imshow(Iinp);
Iinp = im2double(Iinp);
%manually selected control point pairs for cameramanB:
%%%%%%%%%%%%%%%%%%%%%%%%%
%  Ref(x,y) %  Inp(v,w) %
%%%%%%%%%%%%%%%%%%%%%%%%%
%   (1,1)   %  (1,129)  %
%  (1,256)  % (129,350) %
%  (256,1)  %  (222,1)  %
% (256,256) % (350,222) %
%%%%%%%%%%%%%%%%%%%%%%%%%
z = [0 0 0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vw1=[1 129 1]; vw2=[129 350 1]; vw3=[222 1 1]; vw4=[350 222 1];
A = [vw1 z; z vw1; vw2 z; z vw2; vw3 z; z vw3; vw4 z; z vw4]
B = [1 1 1 256 256 1 256 256]'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t = linsolve(A,B)
T = [t(1:3) t(4:6) [0 0 1]']
Tinv = inv(T)
Tinv_size = size(Tinv);

%Pixel location matrix of reference image
n = Iref_size(1);
%n=4;
s = 1:n;
[X,Y] = ndgrid(s,s);
Xr = reshape(X,[],1); %reshape for doing matrix operation
Yr = reshape(Y,[],1);
xy1 = [Xr Yr ones(length(s)^2,1)];
xy1_size = size(xy1);
vw1 = xy1*Tinv;
vw1_size = size(vw1);
vw = vw1(:,1:2); %All new pixel locations in the input image,
%one co-ordinate per row.

XI = reshape(vw(:,1),n,n); %Reshape back
YI = reshape(vw(:,2),n,n); %Reshape back
UI=XI-floor(XI); VI=YI-floor(YI);
c1=(1-UI).*(1-VI); c2=(1-UI).*VI; c3=UI.*(1-VI); c4=UI.*VI;
X1 = floor(XI);Y1=floor(YI); X2=floor(XI)+1; Y2=floor(YI)+1;
X1(find(X1>Iinp_size(1)))=Iinp_size(1);
Y1(find(Y1>Iinp_size(2)))=Iinp_size(2);
X2(find(X2>Iinp_size(1)))=Iinp_size(1);
Y2(find(Y2>Iinp_size(2)))=Iinp_size(2);

X1(find(X1<1))=1; Y1(find(Y1<1))=1;X2(find(X2<1))=1; Y2(find(Y2<1))=1;
for i=1:n
    for j = 1:n
        I1(i,j) = Iinp(X1(i,j),Y1(i,j));
        I2(i,j) = Iinp(X1(i,j),Y2(i,j));
        I3(i,j) = Iinp(X2(i,j),Y1(i,j));
        I4(i,j) = Iinp(X2(i,j),Y2(i,j));
    end
end
BB=c1.*I1+c2.*I2+c3.*I3+c4.*I4; 
size(BB)
figure(2);imshow(BB); 