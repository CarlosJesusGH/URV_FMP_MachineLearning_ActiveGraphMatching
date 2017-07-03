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

Database='LETTERLOW'; outlier=0; Selected_Registers= 1:75;
display('LETTERLOW: Linear classifier method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);

[Kv_Letter_Low, Ke_Letter_Low] = Linear_Classier_learn_edit_costs_STAR(DB_Learning, outlier,-100000,-100000)
title('Letter Low');

figure(2);
Database='LETTERMED'; outlier=0; Selected_Registers= 1:75;
display('LETTERMED: Linear classifier method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[Kv_Letter_Med, Ke_Letter_Med] = Linear_Classier_learn_edit_costs_STAR(DB_Learning, outlier,-100000,-100000)
title('Letter Med');

figure(3);
Database='LETTERHIGH'; outlier=0; Selected_Registers= 1:75;
display('LETTERHIGH: Linear classifier method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[Kv_Letter_High, Ke_Letter_High] = Linear_Classier_learn_edit_costs_STAR(DB_Learning, outlier,-100000,-100000)
title('Letter High');

figure(4);
Database='SAGRADAFAMILIA3D'; outlier=0; Selected_Registers= 1:2; %18496;
display('SAGRADAFAMILIA3D: Linear classifier method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
[Kv_SAGRADAFAMILIA3D, Ke_SAGRADAFAMILIA3D] = Linear_Classier_learn_edit_costs_STAR(DB_Learning, outlier,-100000,-100000)
title('Sagrada Familia 3D');

% figure(5)
% Database='ROTATIONZOOM'; outlier=0; Selected_Registers= 1:2;
% display('ROTATIONZOOM: Linear classifier method: Learn insertion and deletion (without weights)');    
% varname=[Database '.mat'];
% load(varname);
% DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,Selected_Registers);
% [Kv_ROTATIONZOOM, Ke_ROTATIONZOOM] = Linear_Classier_learn_edit_costs_FEATURES(DB_Learning, outlier,-100000,-100000)
% title('RotationZoom');

figure(6);
Database='PALMPRINT'; outlier=0; Selected_Registers= 1:8:80; %1:4:80;
display('PALMPRINT: Linear classifier method: Learn insertion and deletion (without weights)');    
varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Selected_Registers_PALMPPRINT(Database,Selected_Registers);
[Kv_PALMPRINT, Ke_PALMPRINT] = Linear_Classier_learn_edit_costs_PALMPRINT(DB_Learning, outlier,-100000,-100000)
title('Palmprint');

clear Database;
clear DB_Learning;
clear outlier;
clear Selected_Registers;
clear varname;

save Results_Linear_Classifier_Kn_Ke_No_weights; 
display('Learning Done');
