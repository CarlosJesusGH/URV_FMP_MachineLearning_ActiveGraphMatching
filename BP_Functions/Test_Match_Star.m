clear;
clc;
close all;
%% Parameters of graph generation
Degree_of_Graphs=0.5;
Number_Node_Attributes=3;
Number_Nodes1=10;
Number_Nodes2=10;
fprintf('Degree of Graphs: %i\nNumber of Node Attributes: %i\nNumber of Nodes Graph1: %i\nNumber of Nodes Graph2: %i\n',Degree_of_Graphs,Number_Node_Attributes,Number_Nodes1,Number_Nodes2);
%% Parameters of error-tolerant graph matching
NodeInsDel=50;
ArcInsDel=50;
Va= 4;
Vb= 10;
fprintf('Cost InsDel nodes: %i\nCost InsDel edges: %i\n',NodeInsDel,ArcInsDel);

%% Generating two attributed graphs
[N1,E1]=Random_Graph(Number_Nodes1, Number_Node_Attributes, Degree_of_Graphs);
[N2,E2]=Random_Graph(Number_Nodes2, Number_Node_Attributes, Degree_of_Graphs);
G1.N=N1; G1.E=E1;
G2.N=N1; G2.E=E1;

[distance,lab]=Match_Star(G1,G2,Va,Vb,NodeInsDel,ArcInsDel);

% Printing distances
fprintf('Dist(%i,%i)= %i\n', Va,Vb,distance);
lab'
