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
load ../2017_PR_Learning_Insert_Delete_Costs/Results_Linear_Classifier_w_Kn_Ke;

display('LETTERLOW');
w=w_Letter_Low; Kv=Kv_Letter_Low; Ke=Ke_Letter_Low; attributes=1:2;
[hamming_LETTERLOW_nD,runtime_LETTERLOW_nD,hamming_Graph_LETTERLOW_nD] = hammingDatabase_Clique_nD('LETTERLOW',w,attributes,Kv,Ke,0);

display('LETTERMED');
w=w_Letter_Med; Kv=Kv_Letter_Med; Ke=Ke_Letter_Med;attributes=1:2;
[hamming_LETTERMED_nD,runtime_LETTERMED_nD,hamming_Graph_LETTERMED_nD] = hammingDatabase_Clique_nD('LETTERMED',w,attributes,Kv,Ke,0);

display('LETTERHIGH');
w=w_Letter_High; Kv=Kv_Letter_High; Ke=Ke_Letter_High;attributes=1:2;
[hamming_LETTERHIGH_nD,runtime_LETTERHIGH_nD,hamming_Graph_LETTERHIGH_nD] = hammingDatabase_Clique_nD('LETTERHIGH',w,attributes,Kv,Ke,0);

% display('PALMPRINT');
% w=w_PALMPRINT; Kv=Kv_PALMPRINT; Ke=Ke_PALMPRINT; attributes=1:5;
% [hamming_PALMPRINT_nD,runtime_PALMPRINT_nD,hamming_Graph_PALMPRINT_nD] = hammingDatabase_Clique_nD('PALMPRINT',w,attributes,Kv,Ke,0);

display('ROTATIONZOOM');
[hamming_ROTATIONZOOM_nD,runtime_ROTATIONZOOM_nD,hamming_Graph_ROTATIONZOOM_nD] = hammingDatabase_Clique_nD('ROTATIONZOOM',w,attributes,Kv,Ke,0);
clear w;
clear Kv;
clear Ke;
clear attributes;
save Results_Hamming_Clique_nD;