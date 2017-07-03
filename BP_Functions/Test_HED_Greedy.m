clear;
clc;
close all;
%% Parameters of graph generation
Degree_of_Graphs=0.5;
Number_Node_Attributes=3;
Number_Nodes1=10;
Number_Nodes2=15;
fprintf('Degree of Graphs: %i\nNumber of Node Attributes: %i\nNumber of Nodes Graph1: %i\nNumber of Nodes Graph2: %i\n',Degree_of_Graphs,Number_Node_Attributes,Number_Nodes1,Number_Nodes2);
%% Parameters of error-tolerant graph matching
Cost_NodeInsDel=50;
Cost_ArcInsDel=50;
fprintf('Cost InsDel nodes: %i\nCost InsDel edges: %i\n',Cost_NodeInsDel,Cost_ArcInsDel);

%% Generating two attributed graphs
[N1,E1]=Random_Graph(Number_Nodes1, Number_Node_Attributes, Degree_of_Graphs);
[N2,E2]=Random_Graph(Number_Nodes2, Number_Node_Attributes, Degree_of_Graphs);


% Computing the distance using HED
d_HED=HED(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);


% Computing the distance using SFBP and HED as centrality
[cost_SFBP_HED, lab_SFBP_HED]=SFBP_HED_Centrality_jv(N1,N2,E1,E2,Cost_NodeInsDel,Cost_ArcInsDel);
dist_SFBP_HED = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel, lab_SFBP_HED);
% Computing the distance using SFBP and Greedy as centrality
[cost_SFBP_Greedy, lab_SFBP_Greedy]=SFBP_Greedy_Centrality_jv(N1,N2,E1,E2,Cost_NodeInsDel,Cost_ArcInsDel);
dist_SFBP_Greedy = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel, lab_SFBP_Greedy);

% Printing distances
fprintf('HED: %i\n', d_HED);
fprintf('Cost of SFBP with HED centrality: %i\n', cost_SFBP_HED);
fprintf('Exact Cost of SFBP with HED centrality given labelling: %i\n', dist_SFBP_HED);
fprintf('Cost of SFBP with Greedy centrality: %i\n', cost_SFBP_Greedy);
fprintf('Exact Cost of SFBP with Greedy centrality given labelling: %i\n', dist_SFBP_Greedy);
