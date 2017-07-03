function [NodesCopy,EdgesCopy]=Random_Graph_Copy(Nodes,Edges,Del_Nodes,Noise_Nodes,Noise_Edges)
% francesc.serratosa@urv.cat
% Generates a graph copy with noise.
% Noise_Nodes: [0,1]
% Noise_Edges: [0,1]

n=size(Nodes,1); %number of nodes
V=size(Nodes,2); %number of attributes

EdgesRandom = double(rand(n)>=(1-Noise_Edges));
NodesRandom=floor(100*Noise_Nodes*rand(n,V));
NodesCopy=Nodes+NodesRandom;
EdgesCopy=xor(Edges,EdgesRandom);
Delete=rand(Del_Nodes,1);
Delete=ceil(n*Delete);
NodesCopy(Delete)=[];
EdgesCopy(Delete,:)=[];
EdgesCopy(:,Delete)=[];


% NodesCopy=floor(99*rand(n,V));
% EdgesCopy=Edges;
end
