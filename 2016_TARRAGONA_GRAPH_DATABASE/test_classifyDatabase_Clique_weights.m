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

load('w');
display('ROTATIONZOOM');
Kv=-0.0011; Ke=0.0971;
[classify_ROTATIONZOOM3,runtime_ROTATIONZOOM3,class_ROTATIONZOOM3] = classifyDatabase_Clique_weights('ROTATIONZOOM',w,Kv,Ke,0);
Kv=-0.7426; Ke=1.4073;
[classify_ROTATIONZOOM4,runtime_ROTATIONZOOM4,class_ROTATIONZOOM4] = classifyDatabase_Clique_weights('ROTATIONZOOM',w,Kv,Ke,0);
save Results_Classify_Clique_weights;