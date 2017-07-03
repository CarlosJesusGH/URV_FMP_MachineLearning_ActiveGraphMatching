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

attributes=[];
Num_Registers=1;
%%
% display('PALMPRINT no learning');
% Kv=1; Ke=1; 
% w=[1/2000 1/180];
% [hamming_PALMPRINT_no_learn,runtime_PALMPRINT_no_learn,hamming_Graph_PALMPRINT_no_learn] = hammingDatabase_Clique_nD('PALMPRINT',w,attributes,Kv,Ke,Num_Registers);
% hamming_PALMPRINT_no_learn
%%
display('PALMPRINT learning kv and ke');
clear w;
clear Kv;
clear Ke;
load ../2017_PR_Learning_Insert_Delete_Costs/Results_Linear_Classifier_Kn_Ke_No_weights;
Kv=Kv_PALMPRINT; Ke=Ke_PALMPRINT;
[hamming_PALMPRINT,~,~] = hammingDatabase_Clique('PALMPRINT',Kv,Ke,Num_Registers);
%%
display('PALMPRINT learning w, kv and ke');
clear w;
clear Kv;
clear Ke;
load ../2017_PR_Learning_Insert_Delete_Costs/Results_Linear_Classifier_w_Kn_Ke;
w=w_PALMPRINT; Kv=Kv_PALMPRINT; Ke=Ke_PALMPRINT; 
[hamming_PALMPRINT_nD,~,~] = hammingDatabase_Clique_nD('PALMPRINT',w,attributes,Kv,Ke,Num_Registers);
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
clear w_SAGRADAFAMILIA3D;
clear Kv_SAGRADAFAMILIA3D;
clear Ke_SAGRADAFAMILIA3D;
clear w_PALMPRINT;
clear Kv_PALMPRINT;
clear Ke_PALMPRINT;
clear attributes;
save Results_Hamming_PALMPRINT;
display('PALMPRINT Done');
