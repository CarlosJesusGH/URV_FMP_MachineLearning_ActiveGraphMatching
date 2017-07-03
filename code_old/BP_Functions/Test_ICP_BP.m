clear; clc;close all;
%addpath '../BP_Functions';
N=10;
InsDel=0.2;
A=rand(N,3);
B=A+0.4*rand(N,3);
[distance,lab]=ICP_BP(A,B,InsDel);


