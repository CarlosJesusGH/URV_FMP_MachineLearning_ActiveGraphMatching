addpath('Utils');

close all;
i=13; %number of graph to be loaded


%% LETTERHIGH
% addpath('LETTERHIGH')
% load LETTERHIGH;
% G = Database.Learning{i}.Graph;
% plotGraph(G);

%% LETTERMED
% addpath('LETTERMED')
% load LETTERMED;
% G = Database.Learning{i}.Graph;
% plotGraph(G);

%% LETTERLOW
% addpath('LETTERLOW')
% load LETTERLOW;
% G = Database.Learning{i}.Graph;
% plotGraph(G);

%% ROTATIONZOOM
% addpath('ROTATIONZOOM')
% load IMAGES_ROTATIONZOOM;
% load ROTATIONZOOM;
% I = Image_Database.Learning{i};
% G = Database.Learning{i}.Graph;
% plotGraph(G,I);

%% PALMPRINT
addpath('PALMPRINT')    
load IMAGES_PALMPRINT;
load PALMPRINT;
I = Image_Database.Learning{i};
G = Database.Learning{i}.Graph;
imshow(I);
plotGraph(G);

%% SAGRADAFAMILIA3D
% addpath('SAGRADAFAMILIA3D')
% load SAGRADAFAMILIA3D;
% G = Database.Learning{i}.Graph;
% plotGraph(G);