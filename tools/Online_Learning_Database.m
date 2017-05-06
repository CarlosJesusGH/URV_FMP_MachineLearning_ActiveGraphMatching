% Add external paths
addpath ./BP_Functions/;
addpath ./tools/;
% addpath ./datasets/LETTERLOW/;
addpath('./2016_TARRAGONA_GRAPH_DATABASE/LETTERHIGH');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/LETTERMED');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/LETTERLOW');
% addpath('./2016_TARRAGONA_GRAPH_DATABASE/');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/Utils');
addpath('Learning_Functions');
% close all; 
clc; clear;
% LETTERHIGH: Size of each set: 37500
% LETTERMED: Size of each set: 37500
% LETTERLOW: Size of each set: 37500
% ROTATIONZOOM: Size of each set: 80
% PALMPRINT: Size of each set: 320 (except for validation which is empty)
% SAGRADAFAMILIA3D: Size of each set: 18496
% HOUSEHOTEL: Size of each set: 2627
% ---------------------------------------------------------------------
attributes=1:2;
w=ones(1,length(attributes)); 
DatabaseName='LETTERHIGH'; 
outlier=0; % Outlier value is related to the points that are far from the average.
MIN_Selected_Registers= 2; % MIN_Selected_Registers= 2; 
MAX_Selected_Registers= MIN_Selected_Registers + 15; % MAX_Selected_Registers= 750;
display(DatabaseName + ": Linear classifier method: Learn insertion and deletion (without weights)");    
varname=[DatabaseName '.mat'];
load(varname);

% Initial hamming using Kv and Ke = 0.5
display("Before start learning Kv and Ke (both equal 0)");
[average_hamming,~,~] = hammingDatabase_Clique_nD(DatabaseName,w,attributes,0,0,10)

% Initialize learning vars and add comparing hamming test using 0 for kv and ke
Kv_Ke = [];
hammings = [];
Kv_Ke(end + 1, 1) = 0;
Kv_Ke(end, 2) = 0;
hammings(end + 1) = average_hamming;

% Start learning process
for Selected_Registers = MIN_Selected_Registers : 1: MAX_Selected_Registers  %minimum initial value is 2
    display(Selected_Registers);
    registers= 1:Selected_Registers;
    
    % LoadAllRegisters... simply go to the data base and read the registers according to the set limits
    DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,registers);
    
    % Sample plot a graph from database
    % [G1,G2,f,C,Index_G,Index_Gprime]=LoadRegister(Database,1,'Learning');
    % plotGraph(G1,'');    
    
    if Selected_Registers == 13
        Selected_Registers == 13
    end
    
    [Kv, Ke] = Linear_Classier_learn_edit_costs_STAR_partially(DB_Learning, outlier, 1);
    % If Kv or Ke are infinite, use 0.5 instead.
    if(Kv == Inf || Ke == Inf)
        Kv = 0; Ke = 0;
    end
    Kv_Ke(end + 1, 1) = Kv;
    Kv_Ke(end, 2) = Ke;
    
    % Compute hamming distance using new Kv and Ke
    [average_hamming,~,~] = hammingDatabase_Clique_nD(DatabaseName,w,attributes,Kv,Ke,10);
    hammings(end + 1) = average_hamming;
%     pause
end

% Display log of K's and hamming values
display(Kv_Ke);
display(hammings);