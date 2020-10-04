clear all
close all

%find edges using canny edge detector
I = imread('sample.jpg');

%cartoonify colors
cartoonImage = cartoon(im2double(I));
figure, imshow(cartoonImage, []);

bwcartoon = rgb2gray (cartoonImage);
figure, imshow(bwcartoon);

%perform canny edge detection
cannycartoon = edge(bwcartoon, 'Canny', [0.0, 0.2], 2);
figure, imshow(cannycartoon);
inversecartoon = imcomplement(cannycartoon);
figure, imshow(inversecartoon);

se = strel('disk',1,4);
cannycartoon1 = imcomplement(imdilate(cannycartoon,se));
figure, imshow(cannycartoon1);

%create final image
[y1,x1,z1] = size(cartoonImage);

finalimage = zeros(y1,x1,3); %create empty final image

for i = 1:y1
    for j = 1:x1
            finalimage(i,j,1) = cartoonImage(i,j,1)*cannycartoon1(i,j);
            finalimage(i,j,2) = cartoonImage(i,j,2)*cannycartoon1(i,j);
            finalimage(i,j,3) = cartoonImage(i,j,3)*cannycartoon1(i,j);
    end
end

figure, imshow(finalimage, []);

