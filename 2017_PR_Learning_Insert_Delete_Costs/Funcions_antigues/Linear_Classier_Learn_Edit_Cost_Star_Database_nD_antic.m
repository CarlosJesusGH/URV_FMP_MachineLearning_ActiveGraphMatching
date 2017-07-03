% ***** Learn Edit Cost Table1 ****
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

Database='LETTERLOW'; outlier=5; Selected_Registers= 1:750; attributes = 1:2;
display('LETTERLOW: Linear classifier method: Learn w, Kv and Ke');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[w_Letter_Low, Kv_Letter_Low, Ke_Letter_Low] = Linear_Classier_learn_edit_costs_STAR_nD(DB_Learning,outlier,attributes)

figure(2);
Database='LETTERMED'; outlier=5; Selected_Registers= 1:750;attributes = 1:2;
display('LETTERMED: Linear classifier method: Learn w, Kv and Ke');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[w_Letter_Med,Kv_Letter_Med, Ke_Letter_Med] = Linear_Classier_learn_edit_costs_STAR_nD(DB_Learning,outlier,attributes)

figure(3);
Database='LETTERHIGH'; outlier=5; Selected_Registers= 1:750;attributes = 1:2;
display('LETTERHIGH: Linear classifier method: Learn w, Kv and Ke');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[w_Letter_High,Kv_Letter_High, Ke_Letter_High] = Linear_Classier_learn_edit_costs_STAR_nD(DB_Learning,outlier,attributes)

Database='ROTATIONZOOM'; outlier=5; Selected_Registers= 1:20; attributes = 3:66;
display('ROTATIONZOOM: Linear classifier method: Learn w, Kv and Ke');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[w_ROTATIONZOOM, Kv_ROTATIONZOOM, Ke_ROTATIONZOOM] = Linear_Classier_learn_edit_costs_STAR_nD(DB_Learning, outlier,attributes)

% Database='PALMPRINT'; outlier=0; Selected_Registers= 1:8:80; attributes = 1:5;
% display('PALMPRINT: Linear classifier method: Learn w, Kv and Ke');    
% varname=[Database '.mat'];
% load(varname);
% DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
% [w_PALMPRINT, Kv_PALMPRINT, Ke_PALMPRINT] = Linear_Classier_learn_edit_costs_STAR_nD(DB_Learning, outlier,attributes)

clear Database;
clear attributes;
clear DB_Learning;
clear outlier;
clear Selected_Registers;
clear varname;
save Results_Linear_Classifier_w_Kn_Ke; 
