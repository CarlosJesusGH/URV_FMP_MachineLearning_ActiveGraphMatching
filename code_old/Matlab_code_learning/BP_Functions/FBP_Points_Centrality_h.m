function [distance,lab]=FBP_Points_Centrality_h(NA,NB,InsDel)
% francesc.serratosa@urv.cat
% [Distance,labelling]= FBP_Points_Centrality_h(NA,NB,InsDel)
% Graph matching algorithm: FBP
% Centrality: Points
% Linear Assignment solver: Hungarian
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% InsDel: Cost of deleting or inserting a node

Nul=100000;
a=size(NA,1); 
b=size(NB,1);
% Compute the cost between points
Q1=zeros(a,b);
for i=1:a
    for j=1:b
        Q1(i,j)=norm(NA(i,:)-NB(j,:))-2*InsDel;
    end
end
lab=Hungarian(Q1);
distance=sum(sum(lab.*Q1));
lab=(vec2ind(lab')).*(sum(lab',1));
C_ve_di=InsDel*(a+b);
distance=distance+C_ve_di;
end