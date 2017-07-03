function varargout = Gui01_BasicPlotAndCompute(varargin)
% GUI01_BASICPLOTANDCOMPUTE MATLAB code for Gui01_BasicPlotAndCompute.fig
%      GUI01_BASICPLOTANDCOMPUTE, by itself, creates a new GUI01_BASICPLOTANDCOMPUTE or raises the existing
%      singleton*.
%
%      H = GUI01_BASICPLOTANDCOMPUTE returns the handle to a new GUI01_BASICPLOTANDCOMPUTE or the handle to
%      the existing singleton*.
%
%      GUI01_BASICPLOTANDCOMPUTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI01_BASICPLOTANDCOMPUTE.M with the given input arguments.
%
%      GUI01_BASICPLOTANDCOMPUTE('Property','Value',...) creates a new GUI01_BASICPLOTANDCOMPUTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui01_BasicPlotAndCompute_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui01_BasicPlotAndCompute_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui01_BasicPlotAndCompute

% Last Modified by GUIDE v2.5 28-Mar-2017 19:30:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui01_BasicPlotAndCompute_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui01_BasicPlotAndCompute_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

% --- Executes on button press in pushbuttonPlot.
function pushbuttonPlot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Global variables
flagImage1Selected = 0;
flagImage2Selected = 0;
nrNodes = 3;
handles.selectedPointsImg1 = [];
handles.selectedPointsImg2 = [];
% Update handles
handles.flagImage1Selected = flagImage1Selected;
handles.flagImage2Selected = flagImage2Selected;
guidata(hObject, handles);

% Read images and get features
readImagesAndGetFeatures();

% Compute points and edges
computePointsAndEdges(I1, I2, surf1, surf2);

% Update handles
handles.I1 = I1;
handles.I2 = I2;
handles.matchedPoints1 = matchedPoints1;
handles.matchedPoints2 = matchedPoints2;
handles.array11 = array11;
handles.array12 = array12;
handles.array21 = array21;
handles.array22 = array22;
handles.triang_1 = triang_1;
handles.triang_2 = triang_2;
handles.triang_1_mat = triang_1_mat;
handles.triang_2_mat = triang_2_mat;
handles.adjMat_1 = adjMat_1;
handles.adjMat_2 = adjMat_2;
handles.edgeList_1 = edgeList_1;
handles.edgeList_2 = edgeList_2;
handles.surf_feats_01 = surf_feats_01;
handles.surf_feats_02 = surf_feats_02;
guidata(hObject, handles);

% Plot images
plotImagesVerticesAndEdges()

    function plotImagesVerticesAndEdges()
        axes(handles.axes1); cla;
        imageHandle1 = imshow(handles.I1); hold on;         
        set(imageHandle1,'ButtonDownFcn',{@ImageClickDown, handles.matchedPoints1, handles.matchedPoints2, 1});   
        % Add points and numbers to matches
        for i=1:size(handles.matchedPoints1,1)
            x = double(handles.matchedPoints1.Location(i,1));
            y = double(handles.matchedPoints1.Location(i,2));
            plot(x,y,'go');
            % plot number text
            % text(x+3,y,int2str(i),'Color','blue','FontSize',14);
        end            
        % Plot edges       
        %trisurf(handles.triang_1,handles.array11,handles.array12,zeros(size(handles.array11)));
        for i=1:size(handles.edgeList_1,1)
            iter = handles.edgeList_1(i,:);
            startPoint = handles.triang_1_mat.Points(iter(1),:);
            endPoint = handles.triang_1_mat.Points(iter(2),:);
            plot([startPoint(1) endPoint(1)], [startPoint(2) endPoint(2)], 'g');            
        end 
        % -------------------------
        axes(handles.axes2); cla;
        imageHandle2 = imshow(handles.I2); hold on;         
        set(imageHandle2,'ButtonDownFcn',{@ImageClickDown, handles.matchedPoints1, handles.matchedPoints2, 2});
        % Add points and numbers to matches
        for i=1:size(handles.matchedPoints2,1)
            x = double(handles.matchedPoints2.Location(i,1));
            y = double(handles.matchedPoints2.Location(i,2));
            plot(x,y,'go');
            % plot number text
            % text(x+3,y,int2str(i),'Color','blue','FontSize',14);
        end        
        % Plot edges       
        %trisurf(handles.triang_2,handles.array21,handles.array22,zeros(size(handles.array21)));       
        for i=1:size(handles.edgeList_2,1)          
            iter = handles.edgeList_2(i,:);
            startPoint = handles.triang_2_mat.Points(iter(1),:);
            endPoint = handles.triang_2_mat.Points(iter(2),:);
            plot([startPoint(1) endPoint(1)], [startPoint(2) endPoint(2)], 'g');            
        end 
        % -------------------------
    end

    function ImageClickDown ( objectHandle , eventData, matchedPoints1, matchedPoints2, imageNr)
            % Read handles to get updated
            handles = guidata(hObject);            
        
            % Get click coordinates
            axesHandles  = get(objectHandle,'Parent');
            coordinate = get(axesHandles,'CurrentPoint'); 
            x = coordinate(1,1);
            y = coordinate(1,2);                                    
            
            % Check image number
            if imageNr == 1              
                matchedPoints = matchedPoints1;
            else            
                matchedPoints = matchedPoints2;
            end           
            
            % Compute Euclidean distances to all matched points
            distances = sqrt(sum(bsxfun(@minus, matchedPoints.Location, [x,y]).^2,2));
            % Find the smallest distance and use that as an index into B:
            closestPos = find(distances==min(distances));
            closest = matchedPoints(closestPos,:);
                                    
            % Clear prior selection (remove this now that multiple
            % selection is allowed)
%             for i=1:length(matchedPoints)
%                     x = double(matchedPoints.Location(i,1));
%                     y = double(matchedPoints.Location(i,2));
%                     plot(x,y,'g*');                    
%             end                        
            
            % Update handles after changing values
            % Check image number
            printNumber = false;
            if imageNr == 1 
                imgNr = length(handles.selectedPointsImg1);
                % Check if point already exists in array
                is_member = ismember(closestPos, handles.selectedPointsImg1);   
                if imgNr==0 || ~is_member
                    handles.selectedPointsImg1(end+1) = closestPos;
                    imgNr = imgNr + 1;
                    printNumber = true;
                    % handles.flagImage1Selected = closestPos;                
                end
                
            else
                imgNr = length(handles.selectedPointsImg2);
                % Check if point already exists in array
                is_member = ismember(closestPos, handles.selectedPointsImg2);
                if imgNr==0 || ~is_member
                    handles.selectedPointsImg2(end+1) = closestPos;                  
                    imgNr = imgNr + 1;
                    printNumber = true;
                    % handles.flagImage2Selected = closestPos;    
                end
            end                                                  
            guidata(hObject, handles);
            
            % Print new selection
            x = double(closest.Location(1));
            y = double(closest.Location(2));
            plot(x,y,'ro'); 
            if printNumber
                text(x+3,y,int2str(imgNr),'Color','blue','FontSize',14);
                fprintf('selectedPointsImg1:\n'); display(handles.selectedPointsImg1)
                fprintf('selectedPointsImg2:\n'); display(handles.selectedPointsImg2)
            end
            
            
            
    end

    function computePointsAndEdges(I1, I2, features1, features2)
        % Get matches points
%         [f1,vpts1] = extractFeatures(I1,features1);
%         [f2,vpts2] = extractFeatures(I2,features2);
%         indexPairs_features = matchFeatures(f1,f2);
%         matchedPoints1 = vpts1(indexPairs_features(:,1));
%         matchedPoints2 = vpts2(indexPairs_features(:,2)); 
        matchedPoints1 = features1;
        matchedPoints2 = features2; 

        % Transform points to graph using delaunay triangulation
        array11 = double(matchedPoints1.Location(:,1));
        array12 = double(matchedPoints1.Location(:,2));
        triang_1 = delaunay(array11, array12);
        triang_1_mat = delaunayTriangulation(double(matchedPoints1.Location()));
        % 
        array21 = double(matchedPoints2.Location(:,1));
        array22 = double(matchedPoints2.Location(:,2));
        triang_2 = delaunay(array21, array22);
        triang_2_mat = delaunayTriangulation(double(matchedPoints2.Location()));

        % Get edges and adjacency matrices from triangulations
        edgeList_1 = edges(triang_1_mat);
        adjMat_1 = sparse(edgeList_1(:, 1), edgeList_1(:, 2), 1, size(array11,1), size(array11,1));
        adjMat_1 = full(adjMat_1);
        % 
        edgeList_2 = edges(triang_2_mat);
        adjMat_2 = sparse(edgeList_2(:, 1), edgeList_2(:, 2), 1, size(edgeList_2,1), size(edgeList_2,1));
        adjMat_2 = full(adjMat_2);
        % Recreate adjMat2 if random edges is enabled
        if get(handles.cbRandEdges,'value')
            edgeList_2 = [];
            for i=1:size(adjMat_2,1)
                for j=1:size(adjMat_2,1)
                    if rand < 0.5 && i~=j && i<j
                        edgeList_2 = [edgeList_2 ; [i j]];
                    end
                end
            end            
            adjMat_2 = sparse(edgeList_2(:, 1), edgeList_2(:, 2), 1, size(array21,1), size(array21,1));
            adjMat_2 = full(adjMat_2)
        end
    end

    function readImagesAndGetFeatures()
        image1Path = get(handles.editImage1, 'string');
        I1 = imread(image1Path); I1 = rgb2gray(I1); 
        surf1 = detectSURFFeatures(I1);
        surf1 = surf1.selectStrongest(nrNodes);
        [surf_feats_01, valid_points_01] = extractFeatures(I1, surf1);
        %harris1 = detectHarrisFeatures(I1);
        %harris1 = harris1.selectStrongest(10);
        % Read image and get features
        image2Path = get(handles.editImage2, 'string');
        I2 = imread(image2Path); I2 = rgb2gray(I2);
        surf2 = detectSURFFeatures(I2);
        surf2 = surf2.selectStrongest(nrNodes);
        [surf_feats_02, valid_points_02] = extractFeatures(I2, surf2);
        %harris2 = detectHarrisFeatures(I2);
        %harris2 = harris2.selectStrongest(10);             
    end    

end

% --- Executes on button press in pbNullImg1.
function pbNullImg1_Callback(hObject, eventdata, handles)
    % hObject    handle to pbNullImg1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % To simulate an empty surf point just return the surf point in
    % location [1 1] (first pixel)    
    handles.selectedPointsImg1(end+1) = 0;   
    fprintf('selectedPointsImg1:\n'); display(handles.selectedPointsImg1)
    fprintf('selectedPointsImg2:\n'); display(handles.selectedPointsImg2)
    guidata(hObject, handles);    
end

% --- Executes on button press in pbNullImg1.
function pbNullImg2_Callback(hObject, eventdata, handles)
    % hObject    handle to pbNullImg1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
%     handles.selectedPointsImg2(end+1) = SURFPoints([1 1])
%     guidata(hObject, handles);

    % To simulate an empty surf point just return the surf point in
    % location [1 1] (first pixel)
    handles.selectedPointsImg2(end+1) = 0;  
    fprintf('selectedPointsImg1:\n'); display(handles.selectedPointsImg1)
    fprintf('selectedPointsImg2:\n'); display(handles.selectedPointsImg2)
    guidata(hObject, handles);  
end

% --- Executes on button press in pushbuttonLocalDist.
function pushbuttonLocalDist_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLocalDist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Compute local distance
computeLocalDistance();

    function computeLocalDistance()  
        % FROM: Test_Graph_Matching.m
        % Parameters of error-tolerant graph matching
        Cost_NodeInsDel = get(handles.editKv, 'string');
        Cost_ArcInsDel = get(handles.editKe, 'string');        
        
        % Check that K's are numerical values
        if isempty(str2num(Cost_NodeInsDel)) || isempty(str2num(Cost_ArcInsDel))
            set(handles.editKv,'string','50');
            set(handles.editKe,'string','50');
            set(handles.textDistance,'string','X');
            warndlg('Kv and Ke must be numerical');
            % Go out from button callback
            return;
        else
            Cost_NodeInsDel= str2num(Cost_NodeInsDel);
            Cost_ArcInsDel= str2num(Cost_ArcInsDel);
        end                  
        
        % Check flags to know if point was selected in both images     
        if length(handles.selectedPointsImg1) == 0 || length(handles.selectedPointsImg1) ~= length(handles.selectedPointsImg2)
            warndlg('Number of selected points must be the same in both images');
            return;
        end
        
        % Here re-compute the points and the edges according to user matches
        
        %local_points_1 = 
        
        % Compute distance
        feats_01 = handles.surf_feats_01;
        feats_02 = handles.surf_feats_02;  
        [d_clique_BP,labelling]=BP_Clique_Centrality_h_matched(feats_01, feats_02, ...
                            handles.adjMat_1, handles.adjMat_2, Cost_NodeInsDel, Cost_ArcInsDel, ...
                            handles.selectedPointsImg1, handles.selectedPointsImg2);
        %
        cost_clique_BP = Edit_Cost(feats_01, feats_02, handles.adjMat_1, ...
                            handles.adjMat_2, Cost_NodeInsDel, Cost_ArcInsDel, labelling);
        %
        display(labelling);
        fprintf('BP Clique: %i\n',cost_clique_BP);
        set(handles.textDistance,'string',num2str(cost_clique_BP));        
    end
end

% --- Executes on button press in pushbuttonGlobalDist.
function pushbuttonGlobalDist_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonGlobalDist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Compute global distance
computeGlobalDistance();

    function computeGlobalDistance()  
        % FROM: Test_Graph_Matching.m
        % Parameters of error-tolerant graph matching
        Cost_NodeInsDel = get(handles.editKv, 'string');
        Cost_ArcInsDel = get(handles.editKe, 'string');
        
        % Check that K's are numerical values
        if isempty(str2num(Cost_NodeInsDel)) || isempty(str2num(Cost_ArcInsDel))
            set(handles.editKv,'string','50');
            set(handles.editKe,'string','50');
            set(handles.textDistance,'string','X');
            warndlg('Kv and Ke must be numerical');
            % Go out from button callback
            return;
        else
            Cost_NodeInsDel= str2num(Cost_NodeInsDel);
            Cost_ArcInsDel= str2num(Cost_ArcInsDel);
        end                                                
        %
        %feats_01 = handles.triang_1_mat.Points
        %feats_02 = handles.triang_2_mat.Points
        feats_01 = handles.surf_feats_01;
        feats_02 = handles.surf_feats_02;
        [d_clique_BP,labelling]=BP_Clique_Centrality_h(feats_01, feats_02, ...
                            handles.adjMat_1, handles.adjMat_2, Cost_NodeInsDel, Cost_ArcInsDel);                
        %
        cost_clique_BP = Edit_Cost(feats_01, feats_02, handles.adjMat_1, ...
                            handles.adjMat_2, Cost_NodeInsDel, Cost_ArcInsDel, labelling);
        %
        display(labelling);
        %display(handles.triang_1_mat.Points);
        %display(handles.adjMat_1);
        fprintf('BP Clique: %i\n',cost_clique_BP);
        set(handles.textDistance,'string',num2str(cost_clique_BP));
        
    end
end


% -------------------------------------------------------------------------
% NOT USING THIS METHODS---------------------------------------------------
% --- Executes just before Gui01_BasicPlotAndCompute is made visible.
function Gui01_BasicPlotAndCompute_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui01_BasicPlotAndCompute (see VARARGIN)

% Choose default command line output for Gui01_BasicPlotAndCompute
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui01_BasicPlotAndCompute wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Calls before start GUI
% Clear all
clc; % clearvars; % close all; 
% Add external paths
addpath ./BP_Functions/;
% addpath ./tools/;
% addpath ./datasets/LETTERLOW/;
addpath('./2016_TARRAGONA_GRAPH_DATABASE/LETTERHIGH');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/LETTERMED');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/LETTERLOW');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/');
addpath('./2016_TARRAGONA_GRAPH_DATABASE/Utils');
addpath('Learning_Functions');
end

% --- Outputs from this function are returned to the command line.
function varargout = Gui01_BasicPlotAndCompute_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function editImage1_Callback(hObject, eventdata, handles)
% hObject    handle to editImage1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of editImage1 as text
%        str2double(get(hObject,'String')) returns contents of editImage1 as a double
end

% --- Executes during object creation, after setting all properties.
function editImage1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editImage1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function editImage2_Callback(hObject, eventdata, handles)
% hObject    handle to editImage2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editImage2 as text
%        str2double(get(hObject,'String')) returns contents of editImage2 as a double
end

% --- Executes during object creation, after setting all properties.
function editImage2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editImage2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function editKv_Callback(hObject, eventdata, handles)
    % hObject    handle to editKv (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editKv as text
    %        str2double(get(hObject,'String')) returns contents of editKv as a double
end

% --- Executes during object creation, after setting all properties.
function editKv_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to editKv (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function editKe_Callback(hObject, eventdata, handles)
    % hObject    handle to editKe (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of editKe as text
    %        str2double(get(hObject,'String')) returns contents of editKe as a double
end

% --- Executes during object creation, after setting all properties.
function editKe_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to editKe (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes on button press in cbRandEdges.
function cbRandEdges_Callback(hObject, eventdata, handles)
% hObject    handle to cbRandEdges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbRandEdges
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
end

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)    
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
    Database='LETTERHIGH'; outlier=0; MAX_Selected_Registers= 750;
    display('LETTERHIGH: Linear classifier method: Learn insertion and deletion (without weights)');    
    varname=[Database '.mat'];
    load(varname);
    for Selected_Registers = 100 : 1: MAX_Selected_Registers
        registers = 1 :Selected_Registers;
        DB_Learning=LoadAllRegisters_Learning_Selected_Registers(Database,registers);
        [Kv_Letter_Low, Ke_Letter_Low] = Linear_Classier_learn_edit_costs_STAR(DB_Learning, outlier)
        w=ones(1,length(attributes));
        Kv=Kv_Letter_Low; Ke=Ke_Letter_Low;
        [hamming_LETTERHIGH_wight_learn_kv_Ke_No_weights,runtime_LETTERHIGH_wight_learn_kv_Ke_No_weights,hamming_Graph_LETTERHIGH_wight_learn_kv_Ke_No_weights] = hammingDatabase_Clique_nD('LETTERHIGH',w,attributes,Kv,Ke,10);
        hamming_LETTERHIGH_wight_learn_kv_Ke_No_weights
        pause
    end
end
