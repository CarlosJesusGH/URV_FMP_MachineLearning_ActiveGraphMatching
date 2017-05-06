clear;
clc;
close all;
numberOfPoints1=3;
numberOfPoints2=3;
image1='image1.pgm';
image2='image2.pgm';
[magnitude1, features1, xy1 ] = SURF_Detect_Extract(image1,numberOfPoints1);
[magnitude2, features2, xy2 ] = SURF_Detect_Extract(image2,numberOfPoints2);
[Number_Matches_SURF, lab_surf] = SURF_Match_Matlab(features1,features2);
Print_Graph_Labelling(ixy1, xy2,lab_surf);
