function [Nodes,Edges]=Random_Graph_With_Nulls(n,V,degree,nulls)
% francesc.serratosa@urv.cat
% Generates a graph randomly with order n.
% V is the number of attributes on the nodes
% nulls is the number of nulls (it has to be equal or lower than n)
% Edges only has one attribute
% Each Attribute on nodes and edges from 0 to 99. Natural number.
% No edge if attribute on this edges is 0.
% Edges: Adjacency matrix
% Nodes: N x V matrix that represent attributes on the N nodes

Edges = double(rand(n)>=(1-degree));
for i=1:n
    for j=i+1:n
        Edges(i,j)=Edges(j,i);
    end
    Edges(i,i)=0;
end
Nodes=floor(99*rand(n,V));
% Deleting the nulls
 while nulls >0
     k=ceil(n*rand(1,1));
     if(Nodes(k,:)~=-ones(1,V))
         Nodes(k,:)=-ones(1,V);
         Edges(k,:)=0;
         Edges(:,k)=0;
         nulls=nulls-1;
     end
 end    
end
