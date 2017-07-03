%this function to compare the result of three hammaing 
%hamming with out leraning 
%hamming with learning kv ,ke and no wieght 
%hamming with learning kv ,ke and wieght  
close all;
clear;
clc;
%% Adding libraries
addpath('../BP_Functions');
% addpath('ROTATIONZOOM');
% addpath('LETTERMED');
% addpath('ROTATIONZOOM');
% addpath('ROTATIONZOOM');
% addpath('PALMPRINT');
% addpath('SAGRADAFAMILIA3D');
% addpath('HOUSEHOTEL');
%% LETTERLOW: Size of each set: 37500
%% LETTERMED: Size of each set: 37500
%% LETTERHIGH: Size of each set: 37500
%% ROTATIONZOOM: Size of each set: 80
%% PALMPRINT: Size of each set: 320 (except for validation which is empty)
%% SAGRADAFAMILIA3D: Size of each set: 18496
%% HOUSEHOTEL: Size of each set: 2627

attributes=3:66;
Num_Registers=5;
%%
% display('ROTATIONZOOM no learning');
% Kv=0.1; Ke=0.1; 
% w=ones(1,length(attributes));
% [hamming_ROTATIONZOOM_no_learn,~,~] = hammingDatabase_Clique_nD('ROTATIONZOOM',w,attributes,Kv,Ke,Num_Registers)

%%
display('ROTATIONZOOM learning kv and ke');
clear w;
clear Kv;
clear Ke;
load ../2017_PR_Learning_Insert_Delete_Costs/Results_Linear_Classifier_Kn_Ke_No_weights;
Kv=Kv_ROTATIONZOOM; Ke=Ke_ROTATIONZOOM;
[hamming_ROTATIONZOOM,~,~] = hammingDatabase_Clique('ROTATIONZOOM',Kv,Ke,Num_Registers)
%%
display('ROTATIONZOOM learning w, kv and ke');
clear w;
clear Kv;
clear Ke;
load ../2017_PR_Learning_Insert_Delete_Costs/Results_Linear_Classifier_w_Kn_Ke;
w=w_ROTATIONZOOM; Kv=Kv_ROTATIONZOOM; Ke=Ke_ROTATIONZOOM; 
[hamming_ROTATIONZOOM_nD,~,~] = hammingDatabase_Clique_nD('ROTATIONZOOM',w,attributes,Kv,Ke,Num_Registers)
%%
clear w;
clear Kv;
clear Ke;
clear w_Letter_Low;
clear Kv_Letter_Low;
clear Ke_Letter_Low;
clear attributes;
clear Database;
clear DB_Learning;
save Results_Hamming_ROTATIONZOOM;
display('ROTATIONZOOM Done');
