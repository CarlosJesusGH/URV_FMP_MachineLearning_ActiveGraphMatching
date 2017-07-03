clear;
clc;
close all;

NodeInsDel=20;
ArcInsDel=20;
Degree=0.5;
Nodes1=40;
Nodes2=40;

[N1,E1]=Random_Graph(Nodes1,4,Degree);
[N2,E2]=Random_Graph(Nodes2,4,Degree);
tic
[d_clique_SFBP,lab_clique_SFBP]=BP_Clique_Centrality_h(N1,N2,E1,E2,NodeInsDel,ArcInsDel);
toc
% [d_degree_SFBP,lab_degree_SFBP]=SFBP_Degree_Centrality_jv(N1,N2,E1,E2,NodeInsDel,ArcInsDel);
% 
% cost_clique_SFBP = Edit_Cost(N1,N2,E1,E2,NodeInsDel,ArcInsDel,lab_clique_SFBP)
% cost_degree_SFBP = Edit_Cost(N1,N2,E1,E2,NodeInsDel,ArcInsDel,lab_degree_SFBP)
