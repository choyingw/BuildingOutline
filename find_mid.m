function val = find_mid(Im)

[a,~]=imhist(Im);
a_ = cumsum(a);
m = floor(a_(end)/2);
for i = 1:length(a_)-1
    if (a_(i)<=m) && (a_(i+1)>m)
        val = i;
        return 
    end
end

val = 0;
end