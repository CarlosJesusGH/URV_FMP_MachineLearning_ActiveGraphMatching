
clear;
clc;
%close all;

NodeInsDel = 50;
ArcInsDel = 50;
Degree = 0.5;
Nodes1 = 3;
Nodes2 = 3;
Attributes = 1;
%tic
  [N1, E1] = Random_Graph(Nodes1, Attributes, Degree);
  [N2, E2] = Random_Graph(Nodes2, Attributes, Degree);
%   N2(1,:)=N1(1,:);
%   N2(2,:)=N1(2,:);
%   E2=E1;
  lab=1:Nodes1;
  cost = Edit_Cost(N1, N2, E1, E2, NodeInsDel, ArcInsDel,lab)
  lab=[1 1 2];
  cost = Edit_Cost(N1, N2, E1, E2, NodeInsDel, ArcInsDel,lab)
%toc
