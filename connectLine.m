function map = connectLine(p1,p2,map)

if p1(1)>p2(1)
    tmp=p1;
    p1=p2;
    p2=tmp;
end

x_dif = p2(1)-p1(1); y_dif = p2(2)-p1(2);
add_ = y_dif/x_dif;

% Check if its too steep or too flat, the map drawing could be bad.
if abs(y_dif) < 4
    if p2(1)<p1(1)
        map(p2(2),p2(1):p1(1))=1;
    else
        map(p2(2),p1(1):p2(1))=1;
    end
    disp(['Catch  ', 'x_dif = ', int2str(x_dif), ' y_dif = ', int2str(y_dif)])
    return;
end
if abs(x_dif) < 4
    if p2(2)<p1(2)
        map(p2(2):p1(2),p2(1))=1;
    else
        map(p1(2):p2(2),p2(1))=1;
    end
    disp(['Catch  ', 'x_dif = ', int2str(x_dif), ' y_dif = ', int2str(y_dif)])
    return;
end

for i = 1: x_dif-1
    y = add_*i+p1(2);
    map(floor(y), p1(1)+i)=1;
    map(ceil(y), p1(1)+i)=1;
    if floor(y) == ceil(y) 
    map(floor(y)-1, p1(1)+i)=1;    
    map(ceil(y)+1, p1(1)+i)=1;
    end
end
end