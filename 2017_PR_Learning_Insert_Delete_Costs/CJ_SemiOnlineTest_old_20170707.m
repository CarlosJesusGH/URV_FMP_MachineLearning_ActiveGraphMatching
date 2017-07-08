% All this is obtained from All_Test script and inside methods
% Take into account that important scripts from code_old directory are:
%     SemiOnline_Learning_Database
%     Online_Learning_Database
%     Linear_Classier_learn_edit_costs_STAR_partially
%     Linear_Coefficients_2D

%%
% ***** Learn Edit Cost Table1 ****
close all;
clc;
clear;
%% Adding libraries
addpath('../BP_Functions');
addpath('../2016_TARRAGONA_GRAPH_DATABASE');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/Utils');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/LETTERHIGH');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/LETTERMED');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/LETTERLOW');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/ROTATIONZOOM');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/PALMPRINT');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/SAGRADAFAMILIA3D');
addpath('../2016_TARRAGONA_GRAPH_DATABASE/HOUSEHOTEL');
addpath('Learning_Functions');
%% LETTERHIGH: Size of each set: 37500
%% LETTERMED: Size of each set: 37500
%% LETTERLOW: Size of each set: 37500
%% ROTATIONZOOM: Size of each set: 80
%% PALMPRINT: Size of each set: 320 (except for validation which is empty)
%% SAGRADAFAMILIA3D: Size of each set: 18496
%% HOUSEHOTEL: Size of each set: 2627

% Declare loop increasing variables and load db
MIN_Selected_Registers= 70; N_Selected_Registers = 20;
MAX_Selected_Registers= MIN_Selected_Registers + N_Selected_Registers; % MAX_Selected_Registers= 750;

% varname=[DatabaseName '.mat'];
% load(varname);

% Initial hamming using Kv and Ke = 0.5
% display("Before start learning Kv and Ke (both equal 0)");
% [average_hamming,~,~] = hammingDatabase_Clique_nD(DatabaseName,w,attributes,0,0,10)

% Initialize learning vars and add comparing hamming test using 0 for kv and ke
% Kv_Ke = [];
% hammings = [];
% Kv_Ke(end + 1, 1) = 0;
% Kv_Ke(end, 2) = 0;
% hammings(end + 1) = average_hamming;



% --------------------- original

Database='LETTERHIGH'; % MaxHammingBatch75: LETTERHIGH=0.4417, LETTERLOW=0.9470, LETTERMED=0.4334.
outlier=0; % Outlier value is related to the points that are far from the average.
% Selected_Registers= 1:100; %Selected_Registers= 1:75;
display(Database + ": NEW METHOD, Linear classifier method: Learn insertion and deletion (without weights)");    
varname=[Database '.mat']; 
load(varname);

% Start learning process
for Selected_Registers = MIN_Selected_Registers : 1: MAX_Selected_Registers  %minimum initial value is 2
    % This worked, but was difficult to know how many substitution and deletion were used
    display(Selected_Registers);
    registers= 1:Selected_Registers;
    DB_Learning= LoadAllRegisters_Learning_Selected_Registers(Database,registers);            
    % Remove all registers without deletions    
    for elem = size(DB_Learning,2):-1:1
        if ~any(DB_Learning{elem}.labelling == 0)
            DB_Learning(elem) = [];
        end
    end   

    % Compute the learning cost
    [Kv, Ke] = CJ_Linear_Classier_learn_edit_costs_STAR(DB_Learning, outlier,-100000,-100000, 1); title(Database.Name);

    % Clear values and save results
%     clear Database; clear DB_Learning; clear outlier; clear Selected_Registers; clear varname;
%     save Results_Linear_Classifier_Kn_Ke_No_weights; display('Learning Done');

    % Compute hamming distance
    [hamming,~,~] = CJ_hammingDatabase_Clique(Database.Name,Kv,Ke,10); %Num_Registers=10;
    display(hamming)
end
