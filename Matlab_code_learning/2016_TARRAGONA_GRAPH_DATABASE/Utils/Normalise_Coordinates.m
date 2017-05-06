function nodes = Normalise_Coordinates(nodes)
% (x,y) are centered at (0,0)
mx=median(nodes(:,1));
my=median(nodes(:,2));
nodes(:,1)=nodes(:,1)-mx;
nodes(:,2)=nodes(:,2)-my;
end