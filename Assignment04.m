%% CEC495A
% Tymothy Anderson
% Assignment 04 - Postal Code Extraction

clear all; clc; close all;

% Load Image
I = imread('envelope3.jpg');
Imed = medfilt2(I,[100,100]);

Ifinal = Imed - I;
BW = Ifinal > 50;
figure
% imshow(BW)

[H, theta, rho] = hough(BW);
M = mesh(H)
[maxValue maxIndex] = max(max(H));
angle = maxIndex;

Irot = imrotate(BW,angle-1.5,'crop');
% imshow(Irot);

Isub =  imcrop(Irot, [0 717 745 348]);
% imshow(Isub);

SE = strel('disk',5);
Iclean = imopen(Isub, SE);
imshow(Iclean);
[labels,number] = bwlabel(Iclean,8);

Istats = regionprops(labels,'BoundingBox');
imshow(Isub);
hold on;
for k = 3:8
    Istats(k).BoundingBox(2) = Istats(k).BoundingBox(2) + 30;
    Istats(k).BoundingBox(4) = Istats(k).BoundingBox(4) + 95;
    
    rectangle('Position', [Istats(k).BoundingBox],'LineWidth',2, ...
    'EdgeColor','g');
end
