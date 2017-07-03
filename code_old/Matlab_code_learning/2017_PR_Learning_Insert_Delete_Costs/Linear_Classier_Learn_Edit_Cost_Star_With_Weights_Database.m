% ***** Learn Edit Cost Table1 ****
%% Adding libraries
addpath('../BP_Functions');
addpath('../2016_TARRAGONA_GRAPH_DATABASE');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/Utils');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/LETTERHIGH');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/LETTERMED');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/LETTERLOW');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/ROTATIONZOOM');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/PALMPRINT');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/SAGRADAFAMILIA3D');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/HOUSEHOTEL');
addpath('Learning_Functions');
%% LETTERHIGH: Size of each set: 37500
%% LETTERMED: Size of each set: 37500
%% LETTERLOW: Size of each set: 37500
%% ROTATIONZOOM: Size of each set: 80
%% PALMPRINT: Size of each set: 320 (except for validation which is empty)
%% SAGRADAFAMILIA3D: Size of each set: 18496
%% HOUSEHOTEL: Size of each set: 2627

figure(6);
display('ROTATIONZOOM: Linear Classification method: Learn insertion and deletion (using weights)');
Database='ROTATIONZOOM'; outlier=5; Selected_Registers= 1:20;
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
load('w');
[Kv_ROTATIONZOOM, Ke_ROTATIONZOOM] = Linear_Classier_learn_edit_costs_With_Weights_FEATURES(DB_Learning, w,outlier)
save Results_Linear_Classification_Kn_Ke_With_weights;
 