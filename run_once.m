clear all;
close all;
image = imread('images/training/training_1/Bygg_11.png');
message = qrap(image, 'image');
disp(message);