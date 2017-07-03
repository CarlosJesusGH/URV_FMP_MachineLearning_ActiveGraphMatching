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

display('LETTERLOW');
Kv=-0.0048; Ke=1.3542;
[classify_LETTERLOW6,runtime_LETTERLOW6,class_LETTERLOW6] = classifyDatabase_Clique('LETTERLOW',Kv,Ke,0);
Kv=-0.0048; Ke=1.3542;
[classify_LETTERLOW7,runtime_LETTERLOW7,class_LETTERLOW7] = classifyDatabase_Clique('LETTERLOW',Kv,Ke,0);

display('LETTERMED');
Kv=0.0506; Ke=1.4803;
[classify_LETTERMED6,runtime_LETTERMED6,class_LETTERMED6] = classifyDatabase_Clique('LETTERMED',Kv,Ke,0);
Kv=0.0506; Ke=1.4803;
[classify_LETTERMED7,runtime_LETTERMED7,class_LETTERMED7] = classifyDatabase_Clique('LETTERMED',Kv,Ke,0);

display('LETTERHIGH');
Kv=0.0260; Ke=1.3936;
[classify_LETTERHIGH6,runtime_LETTERHIGH6,class_LETTERHIGH6] = classifyDatabase_Clique('LETTERHIGH',Kv,Ke,0);
Kv=0.0260; Ke=1.3936;
[classify_LETTERHIGH7,runtime_LETTERHIGH7,class_LETTERHIGH7] = classifyDatabase_Clique('LETTERHIGH',Kv,Ke,0);

display('ROTATIONZOOM');
Kv=0.9411; Ke=0.9423;
[classify_ROTATIONZOOM1,runtime_ROTATIONZOOM1,class_ROTATIONZOOM1] = classifyDatabase_Clique('ROTATIONZOOM',Kv,Ke,0);
Kv=-0.7413; Ke=1.3492;
[classify_ROTATIONZOOM2,runtime_ROTATIONZOOM2,class_ROTATIONZOOM2] = classifyDatabase_Clique('ROTATIONZOOM',Kv,Ke,0);

% display('PALMPRINT');
% Kv=1.0909; Ke=-1.7062;
% [classify_PALMPRINT1,runtime_PALMPRINT1,class_PALMPRINT1] = classifyDatabase_Clique('PALMPRINT',Kv,Ke,0);


save Results_Classify_Clique;