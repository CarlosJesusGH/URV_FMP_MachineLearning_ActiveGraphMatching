function [NodesCopy,EdgesCopy]=Random_Graph_Copy(Nodes,Edges)
% francesc.serratosa@urv.cat
% Generates a graph copy with noise.
n=size(Nodes,1); %number of nodes
V=size(Nodes,2); %number of attributes
% EdgesRandom = double(rand(n)>=0.3);
% NodesRandom=floor(40*rand(n,V));
% NodesCopy=Nodes+NodesRandom;
% EdgesCopy=Edges.*EdgesRandom;
NodesCopy=floor(99*rand(n,V));
EdgesCopy=Edges;
end
