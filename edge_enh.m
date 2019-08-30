function [S2] = edge_enh(S1, Sal)

% threshold for extraction and enhancing kernel
cn = 0.15;
ker = [ -1 -1  -1;...
       -1  9.25 -1;...
       -1 -1  -1];

% Input   
Im_ori = S1;
Im_ori_dob = double(Im_ori);
[s1,s2,~] = size(Im_ori);


% Line finding before conv
g = rgb2gray(S1);
edge_map = edge(g,'canny',cn);
ln = HLine_v2(edge_map, Sal);
edge_map = ln;

% Apply conv on extracted lines
Im_rev = Im_ori_dob;
[x,y] = find(edge_map==1);

for i = 1:size(x,1)
    if x(i)<=1 || x(i)>=s1 || y(i)<=1 || y(i)>=s2
        continue;
    end
    patch = Im_ori_dob(x(i)-1:x(i)+1,y(i)-1:y(i)+1,:);
    r = sum(patch(:,:,1).*ker,'all');
    g = sum(patch(:,:,2).*ker,'all');
    b = sum(patch(:,:,3).*ker,'all');
    Im_rev(x(i),y(i),:) = [r,g,b];
end

Im_rev=uint8(Im_rev);
S2 = Im_rev;

end