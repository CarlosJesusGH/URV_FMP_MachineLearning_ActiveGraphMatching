function [distance,lab]=SFBP_Degree_Centrality_h(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% francesc.serratosa@urv.cat
% [Distance,labelling]= SFBP_Degree_Centrality_h(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% Graph matching algorithm: SFBP
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
        Q1(i,j)=norm(NA(i,:)-NB(j,:));
        if((sA(i)>0) && (sB(j)>0))
            Q1(i,j)=Q1(i,j)+norm(sA(i)-sB(j))*ArcInsDel;
        end
        if((sA(i)>0) && (sB(j)==0))
            Q1(i,j)=Q1(i,j)+ sA(i)*ArcInsDel;
        end
        if((sA(i)==0) && (sB(j)>0))
            Q1(i,j)=Q1(i,j)+ sB(j)*ArcInsDel;
        end      
    end
end

if(a>b) % Compute the deletion quadrant
    C_A=NodeInsDel+ArcInsDel*sA; 
    C_A_m=repmat(C_A,1,a-b);
    Q1=cat(2,Q1,C_A_m);
end
if(a<b) % Compute the insertion quadrant
    C_B=NodeInsDel+ArcInsDel*sB;
    C_B_m=repmat(C_B,1,b-a);
    Q1=cat(1,Q1,C_B_m');
end
lab=Hungarian(Q1);
distance=sum(sum(lab.*Q1));
lab=lab(1:a,:);
lab=lab(:,1:b);
lab=(vec2ind(lab')).*(sum(lab',1));
end