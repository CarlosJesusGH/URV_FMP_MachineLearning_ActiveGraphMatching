function d=Dist_Minutia(node1, node2)
   a=abs(node1(3)-node2(3));
   d=norm(node1(1:2)-node2(1:2))/2000+min(a,360-a)/360+10*abs(node1(4)-node2(4));
end
