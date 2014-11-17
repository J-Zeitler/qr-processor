clear all;
close all;
image = imread('images/training/training_1/Bygg_11.png');
message = qrap(image, 'Image');
disp(message);

imshow(imread('7_1_uneven_lighting.png'));
figure;
imshow(imread('7_1_bright_spot.png'));