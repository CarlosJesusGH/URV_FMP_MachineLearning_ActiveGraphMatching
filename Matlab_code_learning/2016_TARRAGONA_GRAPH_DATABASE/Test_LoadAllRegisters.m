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

Database='LETTERLOW';  Max_Register=10;
Database='LETTERMED';  Max_Register=10;
Database='LETTERHIGH'; Max_Register=10;
Database='ROTATIONZOOM'; Max_Register=10; %(x,y) not used. Only SIFTs
Database='PALMPRINT'; Max_Register=10;
Database='HOUSEHOTEL'; % There aren't insertion or deletions.
Database='SAGRADAFAMILIA3D'; % only 1 class.
%%
varname=[Database '.mat'];
load(varname);
data_Learning=LoadAllRegisters_Learning(Database,Max_Register);
data_Test=LoadAllRegisters_Test(Database,Max_Register);
data_Validation=LoadAllRegisters_Validation(Database,Max_Register);
