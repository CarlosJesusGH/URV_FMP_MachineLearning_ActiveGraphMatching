addpath('Utils')

Register=88; %number of queried register. The value must not exceed the total number of correspondences in the set

%% LETTERHIGH: Size of each set: 37500
Database='LETTERHIGH';
addpath(Database);
varname=[Database '.mat'];
load(varname);
[G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Test');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Validation');

%% LETTERMED: Size of each set: 37500
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Test');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Validation');

%% LETTERLOW: Size of each set: 37500
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Test');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Validation');

%% ROTATIONZOOM: Size of each set: 37500
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Test');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Validation');

%% PALMPRINT: Size of each set: 320 (except for validation which is empty)
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Test');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Validation');

%% SAGRADAFAMILIA3D: Size of each set: 37500
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Test');
% [G,Gprime,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Validation');

%% MATCHING ACCURACY CALCULATION EXAMPLE

%-->Create a correspondence using Bipartite (BP) Graph Matching
Cost_NodeInsDel=0.2; %Normalized value of the insertion/deletion cost of the nodes
Cost_EdgeInsDel=0.2; %Normalized value of the insertion/deletion cost of the edges
[d_degree_BP,f_degree_BP]=BP_Degree_Centrality_h(G.Nodes,Gprime.Nodes,G.Edges,Gprime.Edges,Cost_NodeInsDel,Cost_EdgeInsDel);
HD = hammingDistance(f_degree_BP,f);