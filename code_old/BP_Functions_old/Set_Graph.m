function Graph=Set_Graph(N,E)
n=size(N,1);
edges = {};
nodes = {};
for i=1:n
    for j=1:size(N,2)
        nodes{i,j}=N(i,j);
    end
    
    for j=1:n
        edges{i,j}=E(j,i);
    end
end
Graph.edges=edges;
Graph.nodes=nodes;
end
