function [CNull,C] = Node_Pagerank_Centrality(A)
n=size(A,1);
[V,D]=eig(A);
Vmax=V(:,n);
ss = sum(A);
ss(find(ss==0)) = 1;
Vmax=Vmax./ss';
Vmax=abs(Vmax);
C=(A*Vmax);
% C=C/sum(C);
C=C/D(n,n);
CNull = D(n,n);
end