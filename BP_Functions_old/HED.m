function distance=HED(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% francesc.serratosa@urv.cat
% distance=HED(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
% Graph matching algorithm: Hausdorff Edit Distance
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
EdgesA=sum(sA);
for j=1:b
    NeighboursB{j}=NB(EB(j,:)>0,:);
    s=size(NeighboursB{j});
    sB(j)=s(1);
end
EdgesB=sum(sB);

    C=zeros(a+1,b+1);
    C(:,end)= [NodeInsDel+0.5*ArcInsDel*sA;0]; 
    C(end,:)= [NodeInsDel+0.5*ArcInsDel*sB;0]; 
    for idx=1:(a);
        for idy=1:(b)
            C(idx,idy)=0.5*(norm(NA(idx,:)-NB(idy,:))+0.5*(Hausdorff(NeighboursA{i},NeighboursB{j},ArcInsDel)));
        end
    end
    A=min(C,[],1);
    A(end)=0;
    B=min(C,[],2);
    B(end)=0;
    distance =sum(A)+sum(B);
    distance =max(distance,abs(a-b)*NodeInsDel+abs(EdgesA-EdgesB)*ArcInsDel);
end