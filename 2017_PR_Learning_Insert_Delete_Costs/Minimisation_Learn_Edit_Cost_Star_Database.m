% ***** Learn Edit Cost Kv, Ke with the nimimisation method ****
% *****  reference [37] *****
close all;
clc;
clear;
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

Database='LETTERLOW'; Kv_ini=1; Ke_ini=1; lambda=0.5; Selected_Registers= [10 60 110 160 210];
display('LETTERLOW: Minimisation method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[Kv_LetterLow, Ke_LetterLow] = Minimisation_learn_edit_cost_STAR(DB_Learning,Kv_ini, Ke_ini, lambda)

Database='LETTERMED'; Kv_ini=1; Ke_ini=1; lambda=0.5; Selected_Registers= [10 60 110 160 210];
display('LETTERMED: Minimisation method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[Kv_LetterMed, Ke_LetterMed] = Minimisation_learn_edit_cost_STAR(DB_Learning,Kv_ini, Ke_ini, lambda)

Database='LETTERHIGH'; Kv_ini=1; Ke_ini=1; lambda=0.5; Selected_Registers= [10 60 110 160 210];
display('LETTERHIGH: Minimisation method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[Kv_LetterHigh, Ke_LetterHigh] = Minimisation_learn_edit_cost_STAR(DB_Learning,Kv_ini, Ke_ini, lambda)

Database='ROTATIONZOOM'; Kv_ini=1; Ke_ini=1; lambda=0.5; Selected_Registers= [4 20 36 52 68];
display('ROTATIONZOOM: Minimisation method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[Kv_ROTATIONZOOM, Ke_ROTATIONZOOM] = Minimisation_learn_edit_cost_FEATURES(DB_Learning,Kv_ini, Ke_ini, lambda)

save Results_Minimisation_Kn_Ke_No_weights; 