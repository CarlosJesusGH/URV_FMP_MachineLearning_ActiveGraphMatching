function [CNull,C] = Node_Eigenvector_Centrality(A)
n=size(A,1);
[V,D]=eig(A);
Vmax=V(:,n);
Vmax=abs(Vmax);
C=(A*Vmax);
% C=C/sum(C);
C=C/D(n,n);
CNull=D(n,n);
end