clear
clc
addpath('../BP_Functions');
display('LETTERLOW no learning');
Num_Registers=10; % max 750
attributes= 2; 
Kv=0.5;
Ke=0.5; 
w=(1/length(attributes))*ones(1,length(attributes));
[hamming_LETTERLOW_no_learn,runtime_LETTERLOW_no_learn,hamming_Graph_LETTERLOW_no_learn] = hammingDatabase_Clique_nD('LETTERLOW',w,attributes,Kv,Ke,Num_Registers);
hamming_LETTERLOW_no_learn
