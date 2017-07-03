function [distance,lab]=FBP_Degree_Centrality_h(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% francesc.serratosa@urv.cat
% [Distance,labelling]= FBP_Degree_Centrality_h(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% Graph matching algorithm: FBP
% Centrality: Degree
% Linear Assignment solver: Hungarian
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% EA, EB: Adjacency matrices. EA(i,j)=1: There is an edge between node i and j. 0: No edge.
% NO attributes on edges
% NodeInsDel: Cost of deleting or inserting a node
% ArcInsDel: Cost of deleting or inserting an edge

Nul=100000;
a=size(NA,1); 
b=size(NB,1);
sA=zeros(a,1);
sB=zeros(b,1);
for i=1:a
    NeighboursA{i}=NA(EA(i,:)>0,:);
    s=size(NeighboursA{i});
    sA(i)=s(1);% degree of nodes
end
for j=1:b
    NeighboursB{j}=NB(EB(j,:)>0,:);
    s=size(NeighboursB{j});
    sB(j)=s(1);% degree of nodes
end
% Compute the cost between points
Q1=zeros(a,b);
for i=1:a
    for j=1:b
        Q1(i,j)=norm(NA(i,:)-NB(j,:))-2*NodeInsDel;
        if((sA(i)>0) && (sB(j)>0))
            Q1(i,j)=Q1(i,j)+norm(sA(i)-sB(j))*ArcInsDel-ArcInsDel*(sA(i)+sB(j));
        end
    end
end
lab=Hungarian(Q1);
distance=sum(sum(lab.*Q1));
lab=(vec2ind(lab')).*(sum(lab',1));
C_ve_di=NodeInsDel*(a+b)+ArcInsDel*(sum(sA)+sum(sB));
distance=distance+C_ve_di;
end