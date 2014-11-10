clear all;
close all;
image = imread('images/training/training_2/Hus_16.png');
message = qrap(image, 'image');
disp(message);