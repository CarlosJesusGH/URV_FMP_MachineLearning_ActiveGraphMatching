function [Benchmarks]=LoadBenchmarks(Database)

addpath(Database);
varname=[Database '.mat'];
load(varname);

%% Number of Graphs, Correspondences, Nodes and Edges

k=0;
nodes=0;
edges=0;
Max_Nodes=0;
Max_Edges=0;
Graphs_Learning=0;
Graphs_Test=0;
Graphs_Validation=0;
Correspondences_Learning=0;
Correspondences_Test=0;
Correspondences_Validation=0;
Number_Classes=0;
Number_Node_Attributes=0;

if length(Database.Learning)==1
else
    Graphs_Learning=length(Database.Learning);
    Correspondences_Learning=length(Database.Learning)*length(Database.Learning{1,1}.Correspondences);
    Number_Classes=Database.Learning{1,length(Database.Learning)}.Class;
    Number_Node_Attributes=size((Database.Learning{1,1}.Graph.Nodes),2);
for i=1:length(Database.Learning)
    k=k+1;
    nodes=nodes+size(Database.Learning{1,i}.Graph.Nodes,1);
    edges=edges+sum(sum(Database.Learning{1,i}.Graph.Edges));
    if size(Database.Learning{1,i}.Graph.Nodes,1)>Max_Nodes
        Max_Nodes=size(Database.Learning{1,i}.Graph.Nodes,1);
    else
    end
    if sum(sum(Database.Learning{1,i}.Graph.Edges))>Max_Edges
       Max_Edges=sum(sum(Database.Learning{1,i}.Graph.Edges)); 
    else
    end
end
end

if length(Database.Test)==1
else
    Graphs_Test=length(Database.Test);
    Correspondences_Test=length(Database.Test)*length(Database.Test{1,1}.Correspondences);
for i=1:length(Database.Test)
    k=k+1;
    nodes=nodes+size(Database.Test{1,i}.Graph.Nodes,1);
    edges=edges+sum(sum(Database.Test{1,i}.Graph.Edges));
    if size(Database.Test{1,i}.Graph.Nodes,1)>Max_Nodes
        Max_Nodes=size(Database.Test{1,i}.Graph.Nodes,1);
    else
    end
    if sum(sum(Database.Test{1,i}.Graph.Edges))>Max_Edges
       Max_Edges=sum(sum(Database.Test{1,i}.Graph.Edges)); 
    else
    end
end
end

if length(Database.Validation)==1
else
    Graphs_Validation=length(Database.Validation);
    Correspondences_Validation=length(Database.Validation)*length(Database.Validation{1,1}.Correspondences);
for i=1:length(Database.Validation)
    k=k+1;
    nodes=nodes+size(Database.Validation{1,i}.Graph.Nodes,1);
    edges=edges+sum(sum(Database.Validation{1,i}.Graph.Edges));
    if size(Database.Validation{1,i}.Graph.Nodes,1)>Max_Nodes
        Max_Nodes=size(Database.Validation{1,i}.Graph.Nodes,1);
    else
    end
    if sum(sum(Database.Validation{1,i}.Graph.Edges))>Max_Edges
       Max_Edges=sum(sum(Database.Validation{1,i}.Graph.Edges)); 
    else
    end
end
end

Average_Nodes=nodes/k;
Average_Edges=edges/k;

%% Number of Nulls in the correspondences

k=0;
nulls=0;
Max_Nulls=0;

if length(Database.Learning)==1
else
for i=1:length(Database.Learning)
    for j=1:length(Database.Learning{1,i}.Correspondences)
    k=k+1;
    nulls_in_correspondence=0;
    for m=1:length(Database.Learning{1,i}.Correspondences{1,j}.Mappings)
        if Database.Learning{1,i}.Correspondences{1,j}.Mappings(1,m)==-1
            nulls=nulls+1;
            nulls_in_correspondence=nulls_in_correspondence+1;
        else
        end
        if nulls_in_correspondence>Max_Nulls
            Max_Nulls=nulls_in_correspondence;
        else
        end
    end
    
    end
end
end

if length(Database.Test)==1
else
for i=1:length(Database.Test)
    for j=1:length(Database.Test{1,i}.Correspondences)
    k=k+1;
    nulls_in_correspondence=0;
    for m=1:length(Database.Test{1,i}.Correspondences{1,j}.Mappings)
        if Database.Test{1,i}.Correspondences{1,j}.Mappings(1,m)==-1
            nulls=nulls+1;
            nulls_in_correspondence=nulls_in_correspondence+1;
        else
        end
        if nulls_in_correspondence>Max_Nulls
            Max_Nulls=nulls_in_correspondence;
        else
        end
    end
    
    end
end
end

if length(Database.Validation)==1
else
for i=1:length(Database.Validation)
    for j=1:length(Database.Validation{1,i}.Correspondences)
    k=k+1;
    nulls_in_correspondence=0;
    for m=1:length(Database.Validation{1,i}.Correspondences{1,j}.Mappings)
        if Database.Validation{1,i}.Correspondences{1,j}.Mappings(1,m)==-1
            nulls=nulls+1;
            nulls_in_correspondence=nulls_in_correspondence+1;
        else
        end
        if nulls_in_correspondence>Max_Nulls
            Max_Nulls=nulls_in_correspondence;
        else
        end
    end
    
    end
end
end

Average_Nulls=nulls/k;

%% Vector with the benchmarks

Benchmarks=[Graphs_Learning;Graphs_Validation;Graphs_Test;Correspondences_Learning;Correspondences_Validation;Correspondences_Test;Number_Classes;Number_Node_Attributes;Average_Nodes;Average_Edges;Average_Nulls;Max_Nodes;Max_Edges;Max_Nulls];

end