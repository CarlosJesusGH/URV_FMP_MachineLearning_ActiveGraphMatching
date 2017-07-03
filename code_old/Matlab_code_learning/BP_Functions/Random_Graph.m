function [Nodes,Edges]=Random_Graph(n,V,degree)
% francesc.serratosa@urv.cat
% Generates a graph randomly with order n.
% V is the number of attributes on the nodes
% degree: [0,1]: degree=1: complete graph. degree=0: no edges.
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
end
