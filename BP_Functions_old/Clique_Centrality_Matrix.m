function Q1=Clique_Centrality_Matrix(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% francesc.serratosa@urv.cat
% Q1=Clique_Centrality_Matrix(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% Centrality: Clique
% Returns de Matrix of distances between cliques
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
    sA(i)=s(1);
end
for j=1:b
    NeighboursB{j}=NB(EB(j,:)>0,:);
    s=size(NeighboursB{j});
    sB(j)=s(1);
end

% Compute substitution quadrant
Q1=zeros(a,b);
for i=1:a
    for j=1:b
        if((NA(i,1)>=0)&&(NB(j,1)>=0)) % mapping non-null to non-null
            Q1(i,j)=norm(NA(i,:)-NB(j,:));
            if((sA(i)>0) && (sB(j)>0))
              Q1(i,j)=Q1(i,j)+BP_Points_Centrality_h(NeighboursA{i},NeighboursB{j},NodeInsDel+ArcInsDel);
            end
            if((sA(i)>0) && (sB(j)==0))
                Q1(i,j)=Q1(i,j)+ sA(i)*(NodeInsDel+ArcInsDel);
            end
            if((sA(i)==0) && (sB(j)>0))
                Q1(i,j)=Q1(i,j)+ sB(j)*(NodeInsDel+ArcInsDel);
            end
        else
            if((NA(i,1)<0)&&(NB(j,1)>=0)) % Mapping null to non-null: Insertion
                Q1(i,j)=NodeInsDel+ sB(j)*(NodeInsDel+ArcInsDel);
            else
                if((NA(i,1)>=0)&&(NB(j,1)<0)) % mapping non-null to null: Deletion
                    Q1(i,j)=NodeInsDel+ sA(i)*(NodeInsDel+ArcInsDel);
                end
            end
        end
    end
end
end