function [distance,lab]=SFBP_Clique_Centrality_jv(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% francesc.serratosa@urv.cat
% [Distance,labelling]= SFBP_Clique_Centrality_jv(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% Graph matching algorithm: SFBP
% Centrality: Clique
% Linear Assignment solver: Jonker-Volgenant
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% EA, EB: Adjacency matrices. EA(i,j)=1: There is an edge between node i and j. 0: No edge.
% NO attributes on edges
% NodeInsDel: Cost of deleting or inserting a node
% ArcInsDel: Cost of deleting or inserting an edge

a=size(NA,1); 
b=size(NB,1);
sA=zeros(a,1);
sB=zeros(b,1);
for i=1:a
    NeighboursA{i}=NA(EA(i,:)>0,:);
    s=size(NeighboursA{i});
    sA(i)=s(1); % degree of nodes
end
for j=1:b
    NeighboursB{j}=NB(EB(j,:)>0,:);
    s=size(NeighboursB{j});
    sB(j)=s(1); % degree of nodes
end

% Compute substitution quadrant
Q1=zeros(a,b);
for i=1:a
    for j=1:b
        Q1(i,j)=norm(NA(i,:)-NB(j,:));
        if((sA(i)>0) && (sB(j)>0))
            Q1(i,j)=Q1(i,j)+SFBP_Points_Centrality_jv(NeighboursA{i},NeighboursB{j},NodeInsDel+ArcInsDel);
        end
        if((sA(i)>0) && (sB(j)==0))
            Q1(i,j)=Q1(i,j)+ sA(i)*(NodeInsDel+ArcInsDel);
        end
        if((sA(i)==0) && (sB(j)>0))
            Q1(i,j)=Q1(i,j)+ sB(j)*(NodeInsDel+ArcInsDel);
        end      
    end
end

if(a>b) % Compute the deletion quadrant
    C_A=NodeInsDel+(NodeInsDel+ArcInsDel)*sA; 
    C_A_m=repmat(C_A,1,a-b);
    Q1=cat(2,Q1,C_A_m);
end
if(a<b) % Compute the insertion quadrant
    C_B=NodeInsDel+(NodeInsDel+ArcInsDel)*sB;
    C_B_m=repmat(C_B,1,b-a);
    Q1=cat(1,Q1,C_B_m');
end
[lab,distance,v,u,costMat] = lapjv(Q1);
lab=lab(1:a);
L=lab<=b;
lab=lab.*L;
end