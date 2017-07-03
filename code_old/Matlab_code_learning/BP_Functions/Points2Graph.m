function [Nodes,Edges] = Points2Graph(Nodes)
% function [Nodes,Edges] = Points2Graph(Nodes)
% Given the set of points: Nodes(1)=x, Nodes(2)=y, Nodes(3...)=features
% it generates a graph using delaunay function
% francesc.serratosa@urv.cat
        Edges = zeros(size(Nodes,2));
        delaunayResults = delaunay(Nodes(:,1),Nodes(:,2));
        for j = 1:length(delaunayResults)           
            edges = perms(delaunayResults(j,:));
            for z = 1:length(edges)
                Edges(edges(z,1), edges(z,2)) = 1;
            end
        end 
end