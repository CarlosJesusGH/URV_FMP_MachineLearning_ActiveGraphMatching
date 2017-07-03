function [distance,lab]=Match_Star(G1,G2,Va,Vb,NodeInsDel,ArcInsDel)
NA=G1.N; NB=G2.N;
EA=G1.E; EB=G2.E;

NeighboursA=NA(EA(Va,:)>0,:);
NeighboursB=NB(EB(Vb,:)>0,:);
[distance,lab_clique]=BP_Points_Centrality_h(NeighboursA,NeighboursB,NodeInsDel+ArcInsDel);
distance=distance+norm(NA(Va,:)-NB(Vb,:));
lab= -1*ones(size(NA,1),1);
k=1;
for i= 1:size(NA,1)
    if(EA(Va,i)==1)
        lab(i)=lab_clique(k);
        k=k+1;
    end
end
lab(Va)=-2;
end