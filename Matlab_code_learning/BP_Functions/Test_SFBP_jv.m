clear;
clc;
close all;
%% Parameters of graph generation
Degree_of_Graphs=0.5;
Number_Node_Attributes=1;
Number_Nodes1=1000;
Number_Nodes2=1000;
fprintf('Degree of Graphs: %i\nNumber of Node Attributes: %i\nNumber of Nodes Graph1: %i\nNumber of Nodes Graph2: %i\n',Degree_of_Graphs,Number_Node_Attributes,Number_Nodes1,Number_Nodes2);
%% Parameters of error-tolerant graph matching
Cost_NodeInsDel=50;
Cost_ArcInsDel=50;
fprintf('Cost InsDel nodes: %i\nCost InsDel edges: %i\n',Cost_NodeInsDel,Cost_ArcInsDel);

%% Generating two attributed graphs
[N1,E1]=Random_Graph(Number_Nodes1, Number_Node_Attributes, Degree_of_Graphs);
[N2,E2]=Random_Graph(Number_Nodes2, Number_Node_Attributes, Degree_of_Graphs);

% Computing the distance using SFBP and Degree centrality
tic
[cost_SFBP, lab_SFBP]=SFBP_Degree_Centrality_jv(N1,N2,E1,E2,Cost_NodeInsDel,Cost_ArcInsDel);
toc
% Printing distances
fprintf('Distance: %i\n', cost_SFBP);