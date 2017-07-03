function cost = computeCostStar_PALMPRINT_nD(G1, G2, i, j)
%% Compute the cost of the external nodes of a star given without labelling
NeighboursA=G1.nodes(G1.edges(i,:)>0,:);
a=size(NeighboursA,1);
NeighboursB=G2.nodes(G2.edges(j,:)>0,:);
b=size(NeighboursB,1);

C=zeros(a,b,2);
  for i=1:a
    for j=1:b      
        C(i,j,1)=norm(NeighboursA(i,1:2)-NeighboursB(j,1:2)); % x,y
        C(i,j,2)=abs(NeighboursA(i,3)-NeighboursB(j,3)); % angle
        if C(i,j,2) > 180
             C(i,j,2)=C(i,j,2)-180;
        end
    end
  end
  
cost=zeros(2,1);
for t=1:2
    lab=Hungarian(C(:,:,t));
    cost(t)=sum(sum(lab.*C(:,:,t)));
end

end