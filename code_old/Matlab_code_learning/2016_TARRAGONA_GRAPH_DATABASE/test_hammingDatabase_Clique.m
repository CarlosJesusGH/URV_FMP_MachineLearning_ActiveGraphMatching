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
[hamming_LETTERLOW6,runtime_LETTERLOW6,hamming_Graph_LETTERLOW6] = hammingDatabase_Clique('LETTERLOW',Kv,Ke,0);
Kv=-0.0048; Ke=1.3542;
[hamming_LETTERLOW7,runtime_LETTERLOW7,hamming_Graph_LETTERLOW7] = hammingDatabase_Clique('LETTERLOW',Kv,Ke,0);

display('LETTERMED');
Kv=0.0506; Ke=1.4803;
[hamming_LETTERMED6,runtime_LETTERMED6,hamming_Graph_LETTERMED6] = hammingDatabase_Clique('LETTERMED',Kv,Ke,0);
Kv=0.0506; Ke=1.4803;
[hamming_LETTERMED7,runtime_LETTERMED7,hamming_Graph_LETTERMED7] = hammingDatabase_Clique('LETTERMED',Kv,Ke,0);

display('LETTERHIGH');
Kv=0.0260; Ke=1.3936;
[hamming_LETTERHIGH6,runtime_LETTERHIGH6,hamming_Graph_LETTERHIGH6] = hammingDatabase_Clique('LETTERHIGH',Kv,Ke,0);
Kv=0.0260; Ke=1.3936;
[hamming_LETTERHIGH7,runtime_LETTERHIGH7,hamming_Graph_LETTERHIGH7] = hammingDatabase_Clique('LETTERHIGH',Kv,Ke,0);

% display('PALMPRINT');
% Kv=1.0909; Ke=-1.7062;
% [hamming_PALMPRINT,runtime_PALMPRINT,hamming_Graph_PALMPRINT] = hammingDatabase_Clique('PALMPRINT',Kv,Ke,0);

display('ROTATIONZOOM');
Kv=-0.7413; Ke=1.3492;

[hamming_ROTATIONZOOM1,runtime_ROTATIONZOOM1,hamming_Graph_ROTATIONZOOM1] = hammingDatabase_Clique('ROTATIONZOOM',Kv,Ke,0);
Kv=0.9411; Ke=0.9423;
[hamming_ROTATIONZOOM2,runtime_ROTATIONZOOM2,hamming_Graph_ROTATIONZOOM2] = hammingDatabase_Clique('ROTATIONZOOM',Kv,Ke,0);

save Results_Hamming_Clique;