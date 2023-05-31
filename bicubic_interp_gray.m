clc; clear; close all;
p=4; %zoom ratio
II=imread('cameraman.bmp'); %read the image,
II=II(:,:,1);s = size(II)
I=im2double(II); %Convert to double for floating point operation
[x,y] = size(I); 

%New sizes of the image,rounding has been done because p can be fractional
X=round(x*p); Y=round(y*p); 

%new pixel locations u in x-direction, v in y-direction
u=1:1/p:((X-1)/p+1); v=1:1/p:((Y-1)/p+1); 
                                     
[XI,YI]=ndgrid(u,v); %Create the 2D grid of new pixels
UI=XI-floor(XI); VI=YI-floor(YI);

%map the new pixel locations u and v to the original pixel locations
X1=floor(u)-1; X2=floor(u); X3=floor(u)+1; X4=floor(u)+2;
Y1=floor(v)-1; Y2=floor(v); Y3=floor(v)+1; Y4=floor(v)+2;

%Handle the boundary cases
X4(find(X4>x))=x; Y4(find(Y4>y))=y; 
X3(find(X3>x))=x; Y3(find(Y3>y))=y; 
X1(find(X1<1))=1; Y1(find(Y1<1))=1; 

I1=I(X1,Y1); I2=I(X1,Y2); I3=I(X1,Y3); I4=I(X1,Y4);
I5=I(X2,Y1); I6=I(X2,Y2); I7=I(X2,Y3); I8=I(X2,Y4);
I9=I(X3,Y1); I10=I(X3,Y2); I11=I(X3,Y3); I12=I(X3,Y4);
I13=I(X4,Y1); I14=I(X4,Y2); I15=I(X4,Y3); I16=I(X4,Y4);

%Distances (4 distances in row and column directions each)
Xa = UI+1; Xb = UI; Xc = 1-UI; Xd = 2-UI;
Ya = VI+1; Yb = VI; Yc = 1-VI; Yd = 2-VI;

%Distances will be passed to mexhat function to have weights
Xamex = arrayfun(@MexHat,Xa); Yamex = arrayfun(@MexHat,Ya);
Xbmex = arrayfun(@MexHat,Xb); Ybmex = arrayfun(@MexHat,Yb);
Xcmex = arrayfun(@MexHat,Xc); Ycmex = arrayfun(@MexHat,Yc);
Xdmex = arrayfun(@MexHat,Xd); Ydmex = arrayfun(@MexHat,Yd);

%Weights
c1 = Xamex.*Yamex; c2 = Xamex.*Ybmex; c3 = Xamex.*Ycmex;c4 = Xamex.*Ydmex;
c5 = Xbmex.*Yamex; c6 = Xbmex.*Ybmex; c7 = Xbmex.*Ycmex;c8 = Xbmex.*Ydmex;
c9 = Xcmex.*Yamex; c10 = Xcmex.*Ybmex; c11 = Xcmex.*Ycmex;
c12 = Xcmex.*Ydmex;
c13 = Xdmex.*Yamex; c14 = Xdmex.*Ybmex; c15 = Xdmex.*Ycmex;
c16 = Xdmex.*Ydmex;

B=c1.*I1 + c2.*I2 + c3.*I3 + c4.*I4 + c5.*I5 + c6.*I6 + c7.*I7 + c8.*I8...
    +c9.*I9 + c10.*I10 + c11.*I11 + c12.*I12 + c13.*I13 + c14.*I14 +...
    c15.*I15 + c16.*I16; 
figure(1);imshow(II); title("Original small-sized image");
figure(2);imshow(B); title("Using bicubic interpolation code from scratch");
size(B)
Ir = imresize(I,4,"bicubic");
figure(3);imshow(Ir); title("Using 'imresize()' ('bicubic')");
MSE = mean( mean( sqrt( (Ir-B).^2 ) ) )