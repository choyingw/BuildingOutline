close all;
clc;

list = dir('CroppedWeb/*.png');
val_all=[];

% Level of L0 smoothing
sm = [0.001, 0.003, 0.005, 0.008, 0.01, 0.02, 0.025 , 0.03, 0.035, 0.04];
% The Canny edge threshold for outputs and levels
cn = [0.01 0.45]; M = 7;

for items = 1:length(list)

name = list(items).name(1:end-4);

[~,~] = system('mkdir output');
[~,~] = system('sudo chmod a+w output');

% Reading image and mask
Im = imresize(imread(['CroppedWeb/' name '.png']),0.5);
Sal = imresize(imread(['WebMask/' name '.png']),0.5);

% Median of image
Med = find_mid(Im);

% Adjustment based on the image median 
if Med<=90
    Im = Im*1.6;
    cn = [0.01,0.3];
    M = 3;
elseif Med<=100
    Im = Im*1.5;
    cn = [0.01, 0.35];
    M = 5;
elseif Med<=120
    Im = Im*1.3;
end

S = Im;
%cnt = 0;

for i = 1:M
% smoothing first
S1 = L0Smoothing(S,sm(i));
% do the enhancing
S = edge_enh(uint8(S1*255), Sal);
end

g = rgb2gray(S);
edge_map = edge(g,'Canny',cn);

% Output the extracted salient edges
imwrite(~edge_map,['output/ExtractOut.jpg']);
compute_ssim(name,0)

end

