close all;
clc;
clear;
%% Adding libraries
addpath('./Utils');
addpath('./LETTERHIGH');
addpath('./LETTERMED');
addpath('./LETTERLOW');
addpath('./ROTATIONZOOM');
addpath('./PALMPRINT');
addpath('./SAGRADAFAMILIA3D');
addpath('./HOUSEHOTEL');
%% LETTERHIGH: Size of each set: 37500
%% LETTERMED: Size of each set: 37500
%% LETTERLOW: Size of each set: 37500
%% ROTATIONZOOM: Size of each set: 80
%% PALMPRINT: Size of each set: 320 (except for validation which is empty)
%% SAGRADAFAMILIA3D: Size of each set: 18496
%% HOUSEHOTEL: Size of each set: 2627

Max_Register=1;
 Database='LETTERLOW'; 
% Database='LETTERMED'; 
% Database='LETTERHIGH'; 
% Database='ROTATIONZOOM'; 
%Database='PALMPRINT';

varname=[Database '.mat'];
load(varname);
DB_Learning=LoadAllRegisters_Learning_Bijective(Database,Max_Register);
