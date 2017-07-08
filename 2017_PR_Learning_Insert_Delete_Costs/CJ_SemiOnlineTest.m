% All this is obtained from All_Test script and inside methods
% Take into account that important scripts from code_old directory are:
%     SemiOnline_Learning_Database
%     Online_Learning_Database
%     Linear_Classier_learn_edit_costs_STAR_partially
%     Linear_Coefficients_2D
%%
% If already compiled and saved results
if 1
    load Results_Linear_Classifier_Kn_Ke_No_weights;
    figure(2);
    x = 0:length(hammings)-1;
    plot(x, hammings)
    refline(0,0.94) 
end


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
MIN_Selected_Registers= 2; N_Selected_Registers = 10;
MAX_Selected_Registers= MIN_Selected_Registers + N_Selected_Registers; % MAX_Selected_Registers= 750;

% Initialize learning vars and add comparing hamming test using 0 for kv and ke
Kv_Ke = [];
hammings = [];
Kv_Ke(end + 1, 1) = 0;
Kv_Ke(end, 2) = 0;
hammings(end + 1) = 0;

% Declare database and main variables
Database='LETTERLOW'; % MaxHammingBatch75: LETTERHIGH=0.4417 (0.4324 using all records), LETTERLOW=0.9470, LETTERMED=0.4334.
outlier=0; % Outlier value is related to the points that are far from the average.
% Selected_Registers= 1:100; %Selected_Registers= 1:75;
display(Database + ": NEW METHOD, Linear classifier method: Learn insertion and deletion (without weights)");    
varname=[Database '.mat']; 
load(varname);

DB_Learning_all= LoadAllRegisters_Learning_Selected_Registers(Database,1:37500);

% Start learning process
for Selected_Registers = MIN_Selected_Registers : 1: MAX_Selected_Registers  %minimum initial value is 2   
    display(Selected_Registers);
    
    % Include only registers holding substitution and deletion
    % TODO: remove the DB_Learning initialization and start from i=size(DB_Learning,2)
    if ~exist('DB_Learning') %variable DB_Learning doesn't exist
        DB_Learning = [];            
        i = 1;
%     else
%         i=size(DB_Learning,2)
    end
    while size(DB_Learning,2) < Selected_Registers || i == size(DB_Learning_all,2)
        if any(DB_Learning_all{i}.labelling == 0)
            DB_Learning{end+1}.graph1.nodes=DB_Learning_all{i}.graph1.nodes;
            DB_Learning{end}.graph2.nodes=DB_Learning_all{i}.graph2.nodes;
            DB_Learning{end}.graph1.edges=DB_Learning_all{i}.graph1.edges;
            DB_Learning{end}.graph2.edges=DB_Learning_all{i}.graph2.edges;
            DB_Learning{end}.labelling=DB_Learning_all{i}.labelling;
        end
        i=i+1;
    end
    
    % Compute the learning cost
    [Kv, Ke] = CJ_Linear_Classier_learn_edit_costs_STAR(DB_Learning, outlier,-100000,-100000, 1); title(Database.Name);

    % Clear values and save results
%     clear Database; clear DB_Learning; clear outlier; clear Selected_Registers; clear varname;
%     save Results_Linear_Classifier_Kn_Ke_No_weights; display('Learning Done');

    % Compute hamming distance
    [hamming,~,~] = CJ_hammingDatabase_Clique(Database.Name,Kv,Ke,10); %Num_Registers=10;
    
    % Save results on array
    Kv_Ke(end + 1, 1) = Kv;
    Kv_Ke(end, 2) = Ke;
    hammings(end + 1) = hamming;
end

% Display log of K's and hamming values
display(Kv_Ke);
display(hammings);
save Results_Linear_Classifier_Kn_Ke_No_weights;

figure(2);
x = 0:len(hammings)
plot(x, hammings)
refline(0,0.94)