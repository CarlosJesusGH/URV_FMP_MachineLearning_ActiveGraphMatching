function [distance,lab]=BP_Eigenvector_Centrality_jv(NA,NB,EA,EB,NodeInsDel,Beta)
% francesc.serratosa@urv.cat
% [Distance,labelling]= BP_Eigenvector_Centrality_jv(NA,NB,EA,EB,NodeInsDel,Beta)
% Graph matching algorithm: BP
% Centrality: Eigenvector
% Linear Assignment solver: Jonker-Volgenant
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% EA, EB: Adjacency matrices. EA(i,j)=1: There is an edge between node i and j. 0: No edge.
% NO attributes on edges
% NodeInsDel: Cost of deleting or inserting a node
% Beta: Weight of the Centrality [0,1]. Beta=1: No centrality. Beta=0: Only centrality.

Nul=100000;
a=size(NA,1); 
b=size(NB,1);
sA=zeros(a,1);
sB=zeros(b,1);

for i=1:a
    NeighboursA{i}=NA(EA(i,:)>0,:);
    s=size(NeighboursA{i});
    sA(i)=s(1);
end
for j=1:b
    NeighboursB{j}=NB(EB(j,:)>0,:);
    s=size(NeighboursB{j});
    sB(j)=s(1);
end

[CentralityA_Null,CentralityA]=Node_Eigenvector_Centrality(EA);
[CentralityB_Null,CentralityB]=Node_Eigenvector_Centrality(EB);

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

% Compute the deletion quadrant
Q2=Nul*ones(a);
for i=1:a
        Q2(i,i)=Beta*NodeInsDel+(1-Beta)*abs(CentralityA(i)-CentralityB_Null);
end

% Compute the insertion quadrant
Q3=Nul*ones(b);
for j=1:b
        Q3(j,j)=Beta*NodeInsDel+(1-Beta)*abs(CentralityA_Null-CentralityB(j)); 
end

% % Compute the deletion quadrant
% Q2=Nul*ones(a);
% for i=1:a
%         Q2(i,i)=NodeInsDel; %CentralityA(i);
% end
% 
% % Compute the insertion quadrant
% Q3=Nul*ones(b);
% for j=1:b
%         Q3(j,j)=NodeInsDel; %CentralityB(j);
% end


% Concatenate the four matrices and Jonker-Volgenant
Q4=zeros(b,a);
QT=cat(1,Q1,Q3); Q2=cat(1,Q2,Q4);
C=cat(2,QT,Q2);
[lab,distance,v,u,costMat] = lapjv(C);
lab=lab(1:a);
L=lab<=b;
lab=lab.*L;
end