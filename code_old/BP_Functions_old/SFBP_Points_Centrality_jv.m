function [distance,lab]=SFBP_Points_Centrality_jv(NA,NB,InsDel)
% francesc.serratosa@urv.cat
% [Distance,labelling]= SFBP_Points_Centrality_jv(NA,NB,InsDel)
% Graph matching algorithm: SFBP
% Centrality: Points
% Linear Assignment solver: Jonker-Volgenant
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
        Q1(i,j)=norm(NA(i,:)-NB(j,:));
    end
end

if(a>b) % Compute the deletion quadrant
    C_A_m=repmat(InsDel,a,a-b);
    Q1=cat(2,Q1,C_A_m);
end
if(a<b) % Compute the insertion quadrant
    C_B_m=repmat(InsDel,b-a,b); 
    Q1=cat(1,Q1,C_B_m);
end
[lab,distance,v,u,costMat] = lapjv(Q1);
lab=lab(1:a);
L=lab<=b;
lab=lab.*L;
end