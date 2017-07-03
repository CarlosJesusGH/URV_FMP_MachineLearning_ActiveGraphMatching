clear;
clc;
%% Adding libraries
addpath('../BP_Functions');
addpath('Utils');
addpath('LETTERHIGH');
addpath('LETTERMED');
addpath('LETTERLOW');
addpath('ROTATIONZOOM');
addpath('PALMPRINT');
addpath('SAGRADAFAMILIA3D');
addpath('HOUSEHOTEL');
%% LETTERHIGH: Size of each set: 37500
%% LETTERMED: Size of each set: 37500
%% LETTERLOW: Size of each set: 37500
%% ROTATIONZOOM: Size of each set: 80
%% PALMPRINT: Size of each set: 320 (except for validation which is empty)
%% SAGRADAFAMILIA3D: Size of each set: 18496
%% HOUSEHOTEL: Size of each set: 2627

display('PALMPRINT');
Kv=0.03285;
[classify_PALMPRINT2,runtime_PALMPRINT2,class_PALMPRINT2] = classifyDatabase_Point('PALMPRINT',Kv,0);

save Results_Classify_Point;