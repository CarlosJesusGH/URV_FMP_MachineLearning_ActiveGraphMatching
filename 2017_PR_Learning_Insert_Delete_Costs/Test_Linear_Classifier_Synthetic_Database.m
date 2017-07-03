close all;
clc;
clear;
addpath('../BP_Functions');
addpath('./Learning_Functions');
addpath('../2016_IJPRAI_Graph_Generation');


%% Parameters
M=20;              % M: Number of pairs of graphs
Kv=-100000; Ke=-100000;     % Kn, Ke: Initial costs
degree= 0.4;      % degree of the random graphs
n1=10;            % number of nodes g1
n2= 5;            % number of nodes g2
nS= floor(0.2*n2);
eI=0;
eD=eI;
num_attributes=3;     % number of attributes of nodes
outlier=0;
Noise = [0.0 0.0 0.0];
%% End parameters

%% Preparing data
LearningSet = [];
attributes =1:num_attributes;
for i=1:M
   
    [G1.nodes,G2.nodes,G1.edges,G2.edges,Dmin,Dmax]=Random_Graph_Pair(n1,n1-n2,nS,eI,eD,num_attributes,Noise,degree,Kv,Ke);
    LearningSet{i}.graph1.edges=G1.edges;
    LearningSet{i}.graph2.edges=G2.edges;
    LearningSet{i}.graph1.nodes = G1.nodes;
    LearningSet{i}.graph2.nodes = G2.nodes;
    LearningSet{i}.labelling=1:n1;
    LearningSet{i}.labelling(n2+1:n1)=0;
end
save  LearningSet;
load  LearningSet;

[w, Kv, Ke] =Linear_Classier_learn_edit_costs_STAR_nD(LearningSet,outlier,attributes)
%[ Kv_deduced, Ke_deduced] = Linear_Classier_learn_edit_costs_STAR(LearningSet,outlier,Kv,Ke)
 