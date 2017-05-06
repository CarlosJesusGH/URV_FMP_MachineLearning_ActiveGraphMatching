clear;
clc;
close all;
%% Parameters of graph generation
Degree_of_Graphs=0.5;
Number_Node_Attributes=3;
Number_Nodes1=4;
Number_Nodes2=3;
fprintf('Degree of Graphs: %i\nNumber of Node Attributes: %i\nNumber of Nodes Graph1: %i\nNumber of Nodes Graph2: %i\n',Degree_of_Graphs,Number_Node_Attributes,Number_Nodes1,Number_Nodes2);
%% Parameters of error-tolerant graph matching
Cost_NodeInsDel=50;
Cost_ArcInsDel=50;
Beta=0.5;
fprintf('Cost InsDel nodes: %i\nCost InsDel edges: %i\nBeta: %i\n',Cost_NodeInsDel,Cost_ArcInsDel,Beta);

%% Generating two attributed graphs
[N1,E1]=Random_Graph(Number_Nodes1, Number_Node_Attributes, Degree_of_Graphs);
[N2,E2]=Random_Graph(Number_Nodes2, Number_Node_Attributes, Degree_of_Graphs);
Test_h;
% Test_jv;
% Test_HED;