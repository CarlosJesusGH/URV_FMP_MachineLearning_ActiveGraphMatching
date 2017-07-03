
%% Computing the distance and labelling between nodes using Jonker-Volgenant
% Points Centrality
[d_points_BP,lab_points_BP]=BP_Points_Centrality_jv(N1,N2, Cost_NodeInsDel);
[d_points_SFBP,lab_points_SFBP]=SFBP_Points_Centrality_jv(N1,N2, Cost_NodeInsDel);

% Degree Centrality
[d_degree_BP,lab_degree_BP]=BP_Degree_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);
[d_degree_SFBP,lab_degree_SFBP]=SFBP_Degree_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);

% Clique Centrality
[d_clique_BP,lab_clique_BP]=BP_Clique_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);
[d_clique_SFBP,lab_clique_SFBP]=SFBP_Clique_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);

% Planar Centrality
[d_planar_BP,lab_planar_BP]=BP_Planar_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);
[d_planar_SFBP,lab_planar_SFBP]=SFBP_Planar_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);

% Hausdorff Centrality
[d_hausdorff_BP,lab_hausdorff_BP]=BP_HED_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);
[d_hausdorff_SFBP,lab_hausdorff_SFBP]=SFBP_HED_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);

% Eigenvector Centrality
[d_eigenvector_BP,lab_eigenvector_BP]=BP_Eigenvector_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Beta);
[d_eigenvector_SFBP,lab_eigenvector_SFBP]=SFBP_Eigenvector_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Beta);

% Pagerank Centrality
[d_pagerank_BP,lab_pagerank_BP]=BP_Pagerank_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Beta);
[d_pagerank_SFBP,lab_pagerank_SFBP]=SFBP_Pagerank_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Beta);

% Greedy Centrality
[d_greedy_SFBP,lab_greedy_SFBP]=SFBP_Greedy_Centrality_jv(N1,N2,E1,E2, Cost_NodeInsDel, Beta);

%% Computing the distance given de obtained labelling 
% Points Centrality
cost_points_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_points_BP);
cost_points_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_points_SFBP);

% Degree Centrality
cost_degree_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_degree_BP);
cost_degree_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_degree_SFBP);

% Clique Centrality
cost_clique_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_clique_BP);
cost_clique_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_clique_SFBP);

% Planar Centrality
cost_planar_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_planar_BP);
cost_planar_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_planar_SFBP);

% Hausdorff Centrality
cost_hausdorff_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_hausdorff_BP);
cost_hausdorff_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_hausdorff_SFBP);

% Eigenvector Centrality
cost_eigenvector_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_eigenvector_BP);
cost_eigenvector_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_eigenvector_SFBP);

% Pagerank Centrality
cost_pagerank_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_pagerank_BP);
cost_pagerank_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_pagerank_SFBP);

% Greedy Centrality
cost_greedy_SFBP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,lab_greedy_SFBP);

%% Printing distances
fprintf('\nDistances obtained by Jonker-Volgenant linear solver\n');
fprintf('BP Points: %i\n',cost_points_BP);
fprintf('SFBP Points: %i\n\n',cost_points_SFBP);

fprintf('BP Degree: %i\n',cost_degree_BP);
fprintf('SFBP Degree: %i\n\n',cost_degree_SFBP);

fprintf('BP Clique: %i\n',cost_clique_BP);
fprintf('SFBP Clique: %i\n\n',cost_clique_SFBP);

fprintf('BP Planar: %i\n',cost_planar_BP);
fprintf('SFBP Planar: %i\n\n',cost_planar_SFBP);

fprintf('BP HED: %i\n',cost_hausdorff_BP);
fprintf('SFBP HED: %i\n\n',cost_hausdorff_SFBP);

fprintf('BP Eigenvector: %i\n',cost_eigenvector_BP);
fprintf('SFBP Eigenvector: %i\n\n',cost_eigenvector_SFBP);

fprintf('BP PageRank: %i\n',cost_pagerank_BP);
fprintf('SFBP PageRank: %i\n\n',cost_pagerank_SFBP);

fprintf('SFBP Greedy: %i\n',cost_greedy_SFBP);
