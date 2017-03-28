% ***** Learn Edit Cost Table1 ****
close all;
clc;
clear;
%% Adding libraries
addpath('./BP_Functions');
addpath('./2016_TARRAGONA_GRAPH_DATABASE');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/Utils');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/LETTERHIGH');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/LETTERMED');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/LETTERLOW');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/ROTATIONZOOM');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/PALMPRINT');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/SAGRADAFAMILIA3D');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/HOUSEHOTEL');
addpath('Learning_Functions');
%% LETTERHIGH: Size of each set: 37500
%% LETTERMED: Size of each set: 37500
%% LETTERLOW: Size of each set: 37500
%% ROTATIONZOOM: Size of each set: 80
%% PALMPRINT: Size of each set: 320 (except for validation which is empty)
%% SAGRADAFAMILIA3D: Size of each set: 18496
%% HOUSEHOTEL: Size of each set: 2627
attributes=1:2;
Database='LETTERHIGH'; outlier=0; MAX_Selected_Registers= 750;
display('LETTERHIGH: Linear classifier method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
for Selected_Registers = 100 : 100: MAX_Selected_Registers
    registers = 1 :Selected_Registers;
    DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,registers);
    [Kv_Letter_Low, Ke_Letter_Low] = Linear_Classier_learn_edit_costs_STAR(DB_Learning, outlier)
    w=ones(1,length(attributes));
    Kv=Kv_Letter_Low; Ke=Ke_Letter_Low;
    [hamming_LETTERHIGH_wight_learn_kv_Ke_No_weights,runtime_LETTERHIGH_wight_learn_kv_Ke_No_weights,hamming_Graph_LETTERHIGH_wight_learn_kv_Ke_No_weights] = hammingDatabase_Clique_nD('LETTERHIGH',w,attributes,Kv,Ke,10);
    hamming_LETTERHIGH_wight_learn_kv_Ke_No_weights

end
