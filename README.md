# Digital_Image_Acquisition
Project 1 on digital  image processing

1.	Develop a Matlab code for image zooming (p>1) and shrinking (p<1) which is based on array operations for image interpolation with the option of nearest neighbor interpolation (m=0), bilinear (m=1) or bicubic interpolation (m=3). 
a.	Use the given grayscale image (“cameraman.bmp”) for experimental analysis. 
b.	Some detailed comparison between three different interpolation methods should be conducted and discussed. You can downsize the image first, and then resize it back to the original size by different interpolation techniques. Then you can evaluate the quality of interpolated images quantitatively by comparing to the original image before downsizing. 
c.	The Matlab function of the “Mexican hat” bicubic interpolation kernel is provided (MexHat.m) which will be used for bicubic image interpolation. You can use “Y=arrayfun(@MexHat,X)” to use an array X as the input which will return an array Y of the same dimension. 
d.	Select some color images for further detailed comparison. 

2.	Develop a Maltab code for image registration. Given the reference image (“cameraman.bmp”) and two input images (“cameramanB.bmp” and “cameramanC.bmp”), you are required to do the following. 
a.	Manually select at least 3 (preferably 4 or more) pairs of control points in the image pair. (You will need to use “imshow” to display the image and then click the “Data Cursor” icon to use a Cursor to select control points with their coordinates.) 
b.	Develop a system of linear equations from the control points and use the “linsolve” function to find the optimal affine transformation between the two images. 
c.	Use the obtained affine transformation to deform the input image and to match the deformed input image with the reference image where three interpolation methods are evaluated in terms of their registration errors.  
d.	Please be noted the coordinate systems of “imshow” ((x,y) represents the horizontal and vertical coordinates) is different from the one in the image array (I(x,y): x and y are row and y indices, respectively) in the Matlab code. After the affine transformation is obtained, the x and y coordinates need to be changed for image transformation. 
