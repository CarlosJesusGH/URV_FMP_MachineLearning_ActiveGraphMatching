function d=Dist_Minutia(node1, node2,wd,wa)
% wd and wa are the weights on the position and the angle
   a=abs(node1(3)-node2(3));
   if a < 180
       d=wd*norm(node1(1:2)-node2(1:2))+wa*a;
   else
       d=wd*norm(node1(1:2)-node2(1:2))+wa*(a-180);
   end
end
