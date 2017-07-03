function [distance,lab]=SFBP_Pagerank_Centrality_jv(NA,NB,EA,EB,NodeInsDel,Beta)
% francesc.serratosa@urv.cat
% [Distance,labelling]=SFBP_Pagerank_Centrality_jv(NA,NB,EA,EB,NodeInsDel,Beta)
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% EA, EB: Adjacency matrices. 1: There is an edge. 0: No edge.
% NO attributes on edges
% NodeInsDel: Cost of deleting or inserting a node
% ArcInsDel: Cost of deleting or inserting an edge
% It uses the  Jonker-Volgenant Algorithm for Linear Assignment Problem.
Nul=100000;
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
[CentralityA_Null,CentralityA]=Node_Pagerank_Centrality(EA);
[CentralityB_Null,CentralityB]=Node_Pagerank_Centrality(EB);

% Compute substitution quadrant
Q1=zeros(a,b);
for i=1:a
    for j=1:b
         Q1(i,j)=norm(NA(i,:)-NB(j,:));
        if((sA(i)>0) && (sB(j)>0))
            Q1(i,j)=Beta*Q1(i,j)+(1-Beta)*abs(CentralityA(i)-CentralityB(j));
        end
        if(sA(i) == 0 && sB(j) == 0)
            Q1(i,j)=Beta*Q1(i,j)+ (1-Beta)*abs(CentralityA_Null-CentralityB_Null);
        else
            if((sA(i)>0) && (sB(j)==0))
                Q1(i,j)=Beta*Q1(i,j)+ (1-Beta)*abs(CentralityA(i)-CentralityB_Null); 
            end
            if((sA(i)==0) && (sB(j)>0))
                Q1(i,j)=Beta*Q1(i,j)+ (1-Beta)*abs(CentralityA_Null-CentralityB(j));
            end
        end     
    end
end

if(a>b) % Compute the deletion quadrant
    cA=zeros(a,1);
    for i=1:a
        cA(i)=Beta*NodeInsDel+(1-Beta)*abs(CentralityA(i)-CentralityB_Null);
    end 
    C_A=NodeInsDel+cA; 
    C_A_m=repmat(C_A,1,a-b);
    Q1=cat(2,Q1,C_A_m);
end
if(a<b) % Compute the insertion quadrant
    cB=zeros(b,1);
    for j=1:b
        cB(j)=Beta*NodeInsDel+(1-Beta)*abs(CentralityB(j)-CentralityA_Null);
    end 
   C_B=NodeInsDel+cB;
    C_B_m=repmat(C_B,1,b-a);
    Q1=cat(1,Q1,C_B_m');
end
[lab,distance,v,u,costMat] = lapjv(Q1);
lab=lab(1:a);
L=lab<=b;
lab=lab.*L;
end