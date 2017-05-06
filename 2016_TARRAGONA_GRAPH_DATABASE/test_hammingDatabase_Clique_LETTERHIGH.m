%this function to compare the result of three hammaing 
%hamming with out leraning 
%hamming with learning kv ,ke and no wieght 
%hamming with learning kv ,ke and wieght  
clear;
clc;
%% Adding libraries
addpath('../BP_Functions');
% addpath('LETTERHIGH');
% addpath('LETTERMED');
% addpath('LETTERHIGH');
% addpath('ROTATIONZOOM');
% addpath('PALMPRINT');
% addpath('SAGRADAFAMILIA3D');
% addpath('HOUSEHOTEL');
%% LETTERHIGH: Size of each set: 37500
%% LETTERMED: Size of each set: 37500
%% LETTERHIGH: Size of each set: 37500
%% ROTATIONZOOM: Size of each set: 80
%% PALMPRINT: Size of each set: 320 (except for validation which is empty)
%% SAGRADAFAMILIA3D: Size of each set: 18496
%% HOUSEHOTEL: Size of each set: 2627

attributes=1:2;
Num_Registers=10;
%%
% display('LETTERHIGH no learning');
% Kv=1; Ke=1; 
% w=ones(1,length(attributes));
% [hamming_LETTERHIGH_no_learn,runtime_LETTERHIGH_no_learn,hamming_Graph_LETTERHIGH_no_learn] = hammingDatabase_Clique_nD('LETTERHIGH',w,attributes,Kv,Ke,Num_Registers);
% hamming_LETTERHIGH_no_learn
%%
display('LETTERHIGH learning kv and ke');
clear w;
clear Kv;
clear Ke;
load ../2017_PR_Learning_Insert_Delete_Costs/Results_Linear_Classifier_Kn_Ke_No_weights;
w=ones(1,length(attributes));
Kv=Kv_Letter_High; Ke=Ke_Letter_High;
[hamming_LETTERHIGH_wight_learn_kv_Ke_No_weights,runtime_LETTERHIGH_wight_learn_kv_Ke_No_weights,hamming_Graph_LETTERHIGH_wight_learn_kv_Ke_No_weights] = hammingDatabase_Clique_nD('LETTERHIGH',w,attributes,Kv,Ke,Num_Registers);
hamming_LETTERHIGH_wight_learn_kv_Ke_No_weights
%%
% display('LETTERHIGH learning w, kv and ke');
% clear w;
% clear Kv;
% clear Ke;
% load ../2017_PR_Learning_Insert_Delete_Costs/Results_Linear_Classifier_w_Kn_Ke;
% w=w_Letter_High; Kv=Kv_Letter_High; Ke=Ke_Letter_High; 
% [hamming_LETTERHIGH_nD,runtime_LETTERHIGH_nD,hamming_Graph_LETTERHIGH_nD] = hammingDatabase_Clique_nD('LETTERHIGH',w,attributes,Kv,Ke,Num_Registers);
% hamming_LETTERHIGH_nD
%%
clear w;
clear Kv;
clear Ke;
clear w_Letter_Low;
clear Kv_Letter_Low;
clear Ke_Letter_Low;
clear w_Letter_Med;
clear Kv_Letter_Med;
clear Ke_Letter_Med;
clear w_Letter_High;
clear Kv_Letter_High;
clear Ke_Letter_High;
clear w_ROTATIONZOOM;
clear Kv_ROTATIONZOOM;
clear Ke_ROTATIONZOOM;
clear attributes;
save Results_Hamming_LETTERHIGH;
display('LETTERHIGH Done');