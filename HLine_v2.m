function map = HLine_v2(edge_map, Sal)

% Hough transform for line detections
[H,T,R] = hough(edge_map,'Theta',-90:0.5:89.5);
P  = houghpeaks(H,500,'threshold',ceil(0.3*max(H(:))),'Theta',-90:0.5:89.5);
lines = houghlines(edge_map,T,R,P,'FillGap',5,'MinLength',30);
map = zeros(size(edge_map,1),size(edge_map,2));
cnt_skip=0;

for k = 1:length(lines)
   if k>length(lines)
       break;
   end
   % If one of the end is at the background, skip
   if (Sal(lines(k).point1(2), lines(k).point1(1)) < 20) || (Sal(lines(k).point2(2), lines(k).point2(1)) < 20)
       cnt_skip=cnt_skip+1;
       continue;
   end
   
   subset = lines;
   coll_ind = k;
   % Check if there are intersections with others. If yes, suppress others.
   for m = 1:length(subset)
       if m == k
           continue;
       end
       if isempty(polyxpoly([lines(k).point1(1),lines(k).point2(1)], [lines(k).point1(2),lines(k).point2(2)],...
               [subset(m).point1(1),subset(m).point2(1)], [subset(m).point1(2),subset(m).point2(2)])) == 0
           coll_ind(end+1) = m;
       end
   end
   if length(coll_ind)>1
       for n=1:length(coll_ind)
           if coll_ind(n) > length(lines)
               continue;
           end
           lines(coll_ind(n))=[];
       end
       continue;
   end
   
   % Return the map with connected lines
   map = connectLine(lines(k).point1, lines(k).point2, map);
   
end
disp(['Connecting ', int2str(length(lines)-cnt_skip), ' lines.']);
end