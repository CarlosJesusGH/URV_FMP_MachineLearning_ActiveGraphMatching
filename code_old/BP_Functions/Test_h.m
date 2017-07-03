
%% Computing the distance and labelling between nodes using Hungarian
% Points Centrality
% [d_points_BP,lab_points_BP]=BP_Points_Centrality_h(N1,N2, Cost_NodeInsDel);
% [d_points_FBP,lab_points_FBP]=FBP_Points_Centrality_h(N1,N2, Cost_NodeInsDel);
% [d_points_SFBP,lab_points_SFBP]=SFBP_Points_Centrality_h(N1,N2, Cost_NodeInsDel);
% 
% % Degree Centrality
% [d_degree_BP,lab_degree_BP]=BP_Degree_Centrality_h(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);
% [d_degree_FBP,lab_degree_FBP]=FBP_Degree_Centrality_h(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);
% [d_degree_SFBP,lab_degree_SFBP]=SFBP_Degree_Centrality_h(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);

% Clique Centrality
[d_clique_BP,lab_clique_BP]=BP_Clique_Centrality_h(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);
% [d_clique_FBP,lab_clique_FBP]=FBP_Clique_Centrality_h(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);
% [d_clique_SFBP,lab_clique_SFBP]=SFBP_Clique_Centrality_h(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);

% Eigenvector Centrality
% [d_eigenvector_BP,lab_eigenvector_BP]=BP_Eigenvector_Centrality_h(N1,N2,E1,E2, Cost_NodeInsDel, Beta);

% Pagerank Centrality
% [d_pagerank_BP,lab_pagerank_BP]=BP_Pagerank_Centrality_h(N1,N2,E1,E2, Cost_NodeInsDel, Beta);

%% Computing the distance given de obtained labelling 
% Points Centrality
% cost_points_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_points_BP);
% cost_points_FBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_points_FBP);
% cost_points_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_points_SFBP);
% 
% % Degree Centrality
% cost_degree_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_degree_BP);
% cost_degree_FBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_degree_FBP);
% cost_degree_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_degree_SFBP);
% 
% Clique Centrality
cost_clique_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_clique_BP);
% cost_clique_FBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_clique_FBP);
% cost_clique_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_clique_SFBP);

% Eigenvector Centrality
% cost_eigenvector_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_eigenvector_BP);

% Pagerank Centrality
% cost_pagerank_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_pagerank_BP);

%% Printing distances
fprintf('\nDistances obtained by Hungarian linear solver\n');
fprintf('BP Points: %i\n',cost_points_BP);
fprintf('FBP Points: %i\n',cost_points_FBP);
fprintf('SFBP Points: %i\n\n',cost_points_SFBP);

fprintf('BP Degree: %i\n',cost_degree_BP);
fprintf('FBP Degree: %i\n',cost_degree_FBP);
fprintf('SFBP Degree: %i\n\n',cost_degree_SFBP);

fprintf('BP Clique: %i\n',cost_clique_BP);
fprintf('FBP Clique: %i\n',cost_clique_FBP);
fprintf('SFBP Clique: %i\n',cost_clique_SFBP);

