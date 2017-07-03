function [cost , nn] = computeCostStar(G1, G2, i, j)
%% Compute the cost of the external nodes of a star given without labelling
NeighboursA=G1.nodes(G1.edges(i,:)>0,:);
a=size(NeighboursA,1);
NeighboursB=G2.nodes(G2.edges(j,:)>0,:);
b=size(NeighboursB,1);
nn=min(a,b);
C=zeros(a,b);
  for i=1:a
    for j=1:b      
        C(i,j)=sqrt(sum((NeighboursA(i,:)-NeighboursB(j,:)).^2));
    end
  end
    lab=Hungarian(C);
    cost=sum(sum(lab.*C));
end