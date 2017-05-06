function [Nodes,Edges]=Random_Graph_Huge(n,V,degree)
% francesc.serratosa@urv.cat
% Generates a graph randomly with order n.
% V is the number of attributes on the nodes
% degree: [0,1]: degree=1: complete graph. degree=0: no edges.
% Edges only has one attribute
% Each Attribute on nodes and edges from 0 to 99. Natural number.
% No edge if attribute on this edges is 0.
% Edges: Adjacency matrix
% Nodes: N x V matrix that represent attributes on the N nodes
Edges = {};
%double(rand(n)>=(1-degree));
for i=1:n
    v=double(rand(1,n)>=(1-degree));
    v(i)=0;
    Edges{end+1}=find(v==1);
end
Edges=Edges';
Nodes=floor(99*rand(n,V));
end
