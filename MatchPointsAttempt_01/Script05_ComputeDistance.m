function Script05_ComputeDistance()
% -------------------------------------------------
% Clear all
clc; clearvars; close all; 
% Add external paths
addpath ./BP_Functions/;
addpath ./tools/;
% Global variables
flagImage1Selected = 0;
flagImage2Selected = 0;

% Read images and get features
readImagesAndGetFeatures()

% Get matches points
[f1,vpts1] = extractFeatures(I1,harris1);
[f2,vpts2] = extractFeatures(I2,harris2);
indexPairs_harris = matchFeatures(f1,f2);
matchedPoints1 = vpts1(indexPairs_harris(:,1));
matchedPoints2 = vpts2(indexPairs_harris(:,2)); 

% Transform points to graph using delaunay triangulation
array11 = double(matchedPoints1.Location(:,1));
array12 = double(matchedPoints1.Location(:,2));
triang_1 = delaunay(array11, array12);
triang_1_mat = delaunayTriangulation(double(matchedPoints1.Location()));
% 
array21 = double(matchedPoints2.Location(:,1));
array22 = double(matchedPoints2.Location(:,2));
triang_2 = delaunay(array21, array22);
triang_2_mat = delaunayTriangulation(double(matchedPoints1.Location()));

% Get edges and adjacency matrices from triangulations
edgeList_1 = edges(triang_1_mat);
adjMat_1 = sparse(edgeList_1(:, 1), edgeList_1(:, 2), 1, size(edgeList_1,1), size(edgeList_1,1));
adjMat_1 = full(adjMat_1)
% 
edgeList_2 = edges(triang_2_mat);
adjMat_2 = sparse(edgeList_2(:, 1), edgeList_2(:, 2), 1, size(edgeList_1,1), size(edgeList_1,1));
adjMat_2 = full(adjMat_2)

% Plot matches points with numbers
plotMatchesNumbers(I1, I2);

% Compute distance
computeDistance();

    function computeDistance()  
        % FROM: Test_Graph_Matching.m
        % Parameters of error-tolerant graph matching
        Cost_NodeInsDel=50;
        Cost_ArcInsDel=50;
        % [d_clique_BP,labelling]=BP_Clique_Centrality_h(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel);
        [d_clique_BP,labelling]=BP_Clique_Centrality_h(triang_1_mat.Points,triang_2_mat.Points, adjMat_1, adjMat_2, Cost_NodeInsDel, Cost_ArcInsDel);                
        % cost_clique_BP = Edit_Cost(N1,N2,E1,E2, Cost_NodeInsDel, Cost_ArcInsDel,labelling);
        cost_clique_BP = Edit_Cost(triang_1_mat.Points,triang_2_mat.Points, adjMat_1, adjMat_2, Cost_NodeInsDel, Cost_ArcInsDel,labelling);
        display(labelling);
        fprintf('BP Clique: %i\n',cost_clique_BP);
    end

    function plotMatchesNumbers(I1, I2)           
        % Plot matches points
        figure;
        % -------------------------
        subplot1 = subplot(1,2,1);       % add plot in 1 x 2 grid
        imageHandle1 = imshow(I1); hold on;         
        set(imageHandle1,'ButtonDownFcn',{@ImageClickDown, matchedPoints1, matchedPoints2, 1});   
        % Add points and numbers to matches
        for i=1:length(matchedPoints1)
            x = double(matchedPoints1.Location(i,1));
            y = double(matchedPoints1.Location(i,2));
            plot(x,y,'g*');
            text(x+3,y,int2str(i),'Color','blue','FontSize',14);
        end    
        trisurf(triang_1,array11,array12,zeros(size(array11)));
        title('Image1')
        % -------------------------
        subplot2 = subplot(1,2,2);       % add plot in 1 x 2 grid
        imageHandle2 = imshow(I2); hold on;         
        set(imageHandle2,'ButtonDownFcn',{@ImageClickDown, matchedPoints1, matchedPoints2, 2});
        % Add points and numbers to matches
        for i=1:length(matchedPoints2)
            x = double(matchedPoints2.Location(i,1));
            y = double(matchedPoints2.Location(i,2));
            plot(x,y,'g*');
            text(x+3,y,int2str(i),'Color','blue','FontSize',14);
        end
        trisurf(triang_2,array21,array22,zeros(size(array21)));
        title('Image2')
    

    function ImageClickDown ( objectHandle , eventData, matchedPoints1, matchedPoints2, imageNr)
        % Get click coordinates
        axesHandles  = get(objectHandle,'Parent');
        coordinate = get(axesHandles,'CurrentPoint'); 
        x = coordinate(1,1);
        y = coordinate(1,2);

        if imageNr == 1              
            matchedPoints = matchedPoints1;
            flagImage1Selected = 1;
        end
        if imageNr == 2               
            matchedPoints = matchedPoints2;
            flagImage2Selected = 1;
        end
        %compute Euclidean distances:
        distances = sqrt(sum(bsxfun(@minus, matchedPoints.Location, [x,y]).^2,2));
        %find the smallest distance and use that as an index into B:
        closest = matchedPoints(find(distances==min(distances)),:);
        % Clear prior selection
        for i=1:length(matchedPoints)
                x = double(matchedPoints.Location(i,1));
                y = double(matchedPoints.Location(i,2));
                plot(x,y,'g*');
                %text(x+3,y,int2str(i),'Color','blue','FontSize',14);
        end
        % Print new selection
        plot(closest.Location(1),closest.Location(2),'r*');        
        % Check flags to know if point was selected in both images
        if flagImage1Selected == flagImage2Selected
           button = questdlg('Do you want to force the matched points','Force assignment','Yes','No','No')
           button
           flagImage1Selected = 0;
           flagImage2Selected = 0;
           subplot(subplot1)
           for i=1:length(matchedPoints1)
                x = double(matchedPoints1.Location(i,1));
                y = double(matchedPoints1.Location(i,2));
                plot(x,y,'g*');
                %text(x+3,y,int2str(i),'Color','blue','FontSize',14);
           end
           subplot(subplot2) 
           for i=1:length(matchedPoints)
                x = double(matchedPoints2.Location(i,1));
                y = double(matchedPoints2.Location(i,2));
                plot(x,y,'g*');
                %text(x+3,y,int2str(i),'Color','blue','FontSize',14);
            end
        end
    end
    end    

    function readImagesAndGetFeatures()
        I1 = imread('img_01.png'); I1 = rgb2gray(I1); 
        surf1 = detectSURFFeatures(I1);
        surf1 = surf1.selectStrongest(20);
        harris1 = detectHarrisFeatures(I1);
        harris1 = harris1.selectStrongest(20);
        % Read image and get features
        I2 = imread('img_02.png'); I2 = rgb2gray(I2);
        surf2 = detectSURFFeatures(I2);
        surf2 = surf2.selectStrongest(20);
        harris2 = detectHarrisFeatures(I2);
        harris2 = harris2.selectStrongest(20);
    end
end