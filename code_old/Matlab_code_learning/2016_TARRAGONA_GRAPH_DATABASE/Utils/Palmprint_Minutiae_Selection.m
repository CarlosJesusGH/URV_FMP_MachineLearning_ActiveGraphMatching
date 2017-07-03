function [nodes, edges] = Palmprint_Minutiae_Selection(nodes,edges)
% Function generates another graph with only the good quality minutiae
quality=find(nodes(:,5)==1);
nodes(quality,:)=[];
edges(quality,:)=[];
edges(:,quality)=[];
end