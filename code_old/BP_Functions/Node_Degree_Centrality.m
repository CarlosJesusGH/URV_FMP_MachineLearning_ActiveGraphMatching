function C = Node_Degree_Centrality(A)
C=sum(A,2);
C=C/sum(C);
end