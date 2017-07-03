%%
openExample('vision/FindCorrespondingPtsBetweenTwoImagesUsingHarrisFeaturesExample')

%%
openExample('vision/DisplayCorrespondingPtsBetweenTwoRotatedAndScaledImagesExample')

%%
I = imread('img_01.png');
I = rgb2gray(I);
points = detectSURFFeatures(I);

imshow(I); hold on;
plot(points.selectStrongest(10));

%%
x = 0:0.1:10;
y1 = sin(2*x);
y2 = cos(2*x);

figure
subplot(2,2,1)       % add first plot in 2 x 2 grid
plot(x,y1)           % line plot
title('Subplot 1')

subplot(2,2,2)       % add second plot in 2 x 2 grid
scatter(x,y2)        % scatter plot
title('Subplot 2')

subplot(2,2,3)       % add third plot in 2 x 2 grid
stem(x,y1)           % stem plot
title('Subplot 3')

subplot(2,2,4)       % add fourth plot in 2 x 2 grid
yyaxis left          % plot against left y-axis  
plot(x,y1)           
yyaxis right         % plot against right y-axis
plot(x,y2)


%%
clc; clearvars;
I1 = imread('img_01.png'); I1 = rgb2gray(I1); 
surf1 = detectSURFFeatures(I1);
surf1 = surf1.selectStrongest(10);
surf1_location = surf1.Location;
harris1 = detectHarrisFeatures(I1);
harris1 = harris1.selectStrongest(10);
harris1_location = harris1.Location;

I2 = imread('img_02.png'); I2 = rgb2gray(I2);
surf2 = detectSURFFeatures(I2);
surf2 = surf2.selectStrongest(10);
surf2_location = surf2.Location;
harris2 = detectHarrisFeatures(I2);
harris2 = harris2.selectStrongest(10);
harris2_location = harris2.Location;

% I3 = imread('img_03.png'); I3 = rgb2gray(I3);
% points3 = detectSURFFeatures(I3);
% 
% I4 = imread('img_04.png'); I4 = rgb2gray(I4);
% points4 = detectSURFFeatures(I4);
% --------------------------------------------------

figure
subplot(2,2,1)       % add first plot in 2 x 2 grid
imshow(I1); hold on; 
plot(surf1_location(:,1),surf1_location(:,2),'g*');
plot(harris1_location(:,1),harris1_location(:,2),'b*');
title('green=surf / blue=harris')

subplot(2,2,2)       % add second plot in 2 x 2 grid
imshow(I2); hold on; 
plot(surf2_location(:,1),surf2_location(:,2),'g*');
plot(harris2_location(:,1),harris2_location(:,2),'b*');
title('green=surf / blue=harris')

subplot(2,2,3)       % add third plot in 2 x 2 grid
% imshow(I3); hold on; 
[f1_surf,vpts1] = extractFeatures(I1,surf1);
[f2_surf,vpts2] = extractFeatures(I2,surf2);
indexPairs_surf = matchFeatures(f1_surf,f2_surf);
% indexPairs_surf
matchedPoints1 = vpts1(indexPairs_surf(:,1));
matchedPoints2 = vpts2(indexPairs_surf(:,2));
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
% legend('matched points 1','matched points 2');
title('Surf matching')

subplot(2,2,4)       % add fourth plot in 2 x 2 grid
% imshow(I4); hold on; 
[f1_harris,vpts1] = extractFeatures(I1,harris1);
[f2_harris,vpts2] = extractFeatures(I2,harris2);
indexPairs_harris = matchFeatures(f1_harris,f2_harris);
% indexPairs_harris
matchedPoints1 = vpts1(indexPairs_harris(:,1));
matchedPoints2 = vpts2(indexPairs_harris(:,2));
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
% legend('matched points 1','matched points 2');
title('Harris matching')

figure; ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage','Parent',ax);
% showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'Parent',ax);
title(ax, 'Candidate point matches');
legend(ax, 'Matched points 1','Matched points 2');


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
% function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% m=get(hObject,'CurrentPoint');

% set(imageHandle,'ButtonDownFcn',@ImageClickDown);
% function ImageClickDown ( objectHandle , eventData )
% axesHandles  = get(objectHandle,'Parent');
% coordinate = get(axesHandles,'CurrentPoint'); 
% coordinate

% function getMousePositionOnImage(src, event)
% handles = guidata(src);
% cursorPoint = get(handles.axesImage, 'CurrentPoint');
% curX = cursorPoint(1,1);
% curY = cursorPoint(1,2);
% msgbox('x=' + curX + ', Y=' + curY);
% end
