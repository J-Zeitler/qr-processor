clear all;
close all;
image = imread('7_1_uneven_lighting.png');
message = qrap(image, 'Image');
disp(message);