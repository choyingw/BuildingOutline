function val = compute_ssim(name, flag)

A = 1-double(imread(['output/ExtractOut.jpg']))./255;

% If flag == 1, load the groundtruth and compute ssim.
if flag == 1
    B =  rgb2gray(imresize(imread(['GT/' name '.jpg']),0.5));
end

Mask = double(imresize(imread(['WebMask/' name '.png']),0.5))./255;
A=uint8((1-A.*Mask)*255);
imwrite(A, ['output/ExtractOut_cl.jpg'])

if flag == 1
    val = ssim(A,B,'Exponents',[1 1 1]);
    return
end

val = 0;
end
