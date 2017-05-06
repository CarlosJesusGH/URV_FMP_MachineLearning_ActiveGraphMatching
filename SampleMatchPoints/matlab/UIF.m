
function varargout = UIF(varargin)
% UIF MATLAB code for UIF.fig
%      UIF, by itself, creates a new UIF or raises the existing
%      singleton*.
%
%      H = UIF returns the handle to a new UIF or the handle to
%      the existing singleton*.
%
%      UIF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UIF.M with the given input arguments.
%
%      UIF('Property','Value',...) creates a new UIF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UIF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UIF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UIF

% Last Modified by GUIDE v2.5 26-Jan-2016 15:56:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @UIF_OpeningFcn, ...
    'gui_OutputFcn',  @UIF_OutputFcn, ...
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




% --- Executes just before UIF is made visible.
function UIF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UIF (see VARARGIN)

%global var
global pointerM mapping indexF
indexF=1;
mapping=[0 0 0];
pointerM=zeros(1,4);


%% folder image
system('RD /S /Q ..\images')
system('cd .. & mkdir images & mkdir images\human')
for ii=1:4
    system(sprintf('cd images%d & copy kermit00%d.jpg /d ..\\..\\images',ii,ii-1));
end

%% IMAGES INFO
%images path
images_name_R1=dir('images1/*.jpg');
images_name_R2=dir('images2/*.jpg');
images_name_R3=dir('images3/*.jpg');
images_name_R4=dir('images4/*.jpg');


%all images info (no sense warning calling the function)
warning off
image_info=imfinfo(sprintf('images1/%s',images_name_R1(1).name));

%images resolution
resolution=[image_info.Width image_info.Height];

%% Initialization
%[camNum,H,Pose,points3D]=Initialization();





%% IMAGES
axes(handles.axes2)
hold off
imshow(sprintf('images1/%s',images_name_R1(1).name))
axes(handles.axes3)
hold off
imshow(sprintf('images2/%s',images_name_R2(1).name))
axes(handles.axes4)
hold off
imshow(sprintf('images3/%s',images_name_R3(1).name))
axes(handles.axes5)
hold off
imshow(sprintf('images4/%s',images_name_R4(1).name))







% Choose default command line output for UIF
handles.output = hObject;

guidata(hObject, handles);
% UIWAIT makes UIF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UIF_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonPlot.
function buttonPlot_Callback(hObject, eventdata, handles)
global pointerM mapping indexF
% hObject    handle to buttonPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB


%% IMAGES INFO
%images path
images_name_R1=dir('images1/*.jpg');
images_name_R2=dir('images2/*.jpg');
images_name_R3=dir('images3/*.jpg');
images_name_R4=dir('images4/*.jpg');


%all images info (no sense warning calling the function)
warning off
image_info=imfinfo(sprintf('images1/%s',images_name_R1(1).name));

%images resolution
resolution=[image_info.Width image_info.Height];

%% PROCESS
mapping
pointerM
if sum(pointerM)==0 | sum(pointerM)==4
    
    
    indexF=indexF+1;
    %% IMAGES
    axes(handles.axes2)
    hold off
    imshow(sprintf('images1/%s',images_name_R1(indexF).name))
    axes(handles.axes3)
    hold off
    imshow(sprintf('images2/%s',images_name_R2(indexF).name))
    axes(handles.axes4)
    hold off
    imshow(sprintf('images3/%s',images_name_R3(indexF).name))
    axes(handles.axes5)
    hold off
    imshow(sprintf('images4/%s',images_name_R4(indexF).name))
    
    %% SYSTEM
    if size(mapping,1)>4
        imposed=reshapeToAdapt(mapping(2:end,:),resolution);
        [NumCam,Homo,Pose,point3D,matching]=homographies(imposed);
    else
        [camNum,H,Pose,points3D]=Initialization();
    end
    
    %% POSE
    axes(handles.axes1)
    hold off
    scatter(Pose(:,1),Pose(:,3),'filled','g^');
    axis([min(Pose(:,1))-.5 max(Pose(:,1))+.5 min(Pose(:,3))-.5 max(Pose(:,3))+.5])
    
    
    %% folder image
    system('RD /S /Q ..\images')
    system('cd .. & mkdir images & mkdir images\human')
    for ii=1:4
        system(sprintf('cd images%d & copy kermit00%d.jpg /d ..\\..\\images',ii,ii-1));
    end
    
    
else
    disp('MUST SELECT ALL THE IMAGES OR NO ONE')
    %% IMAGES
    axes(handles.axes2)
    hold off
    imshow(sprintf('images1/%s',images_name_R1(1).name))
    axes(handles.axes3)
    hold off
    imshow(sprintf('images2/%s',images_name_R2(1).name))
    axes(handles.axes4)
    hold off
    imshow(sprintf('images3/%s',images_name_R3(1).name))
    axes(handles.axes5)
    hold off
    imshow(sprintf('images4/%s',images_name_R4(1).name))
end

mapping=[0 0 0];














pointerM=zeros(1,4);

guidata(hObject, handles);


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m=get(hObject,'CurrentPoint');
global pointerM mapping

%to check again
if sum(pointerM)==4
    pointerM=zeros(1,4);
end

%axes2
pos=get(handles.axes2,'Position');
if checkPointAxes(m,pos)==1 & pointerM(1,1)==0
    pointerM(1,1)=1;
    axes(handles.axes2)
    m1=get(handles.axes2,'Currentpoint');
    hold on
    plot(m1(1,1),m1(1,2),'*','LineWidth',10,'MarkerSize',10);
    mapping=[mapping;0 m1(1,1) m1(1,2)];
end

%axes3
pos=get(handles.axes3,'Position');
if checkPointAxes(m,pos)==1 & pointerM(1,2)==0
    pointerM(1,2)=1;
    axes(handles.axes3)
    m1=get(handles.axes3,'Currentpoint');
    hold on
    plot(m1(1,1),m1(1,2),'*','LineWidth',10,'MarkerSize',10);
    mapping=[mapping;1 m1(1,1) m1(1,2)];
end

%axes4
pos=get(handles.axes4,'Position');
if checkPointAxes(m,pos)==1 & pointerM(1,3)==0
    pointerM(1,3)=1;
    axes(handles.axes4)
    m1=get(handles.axes4,'Currentpoint');
    hold on
    plot(m1(1,1),m1(1,2),'*','LineWidth',10,'MarkerSize',10);
    mapping=[mapping;2 m1(1,1) m1(1,2)];
end

%axes5
pos=get(handles.axes5,'Position');
if checkPointAxes(m,pos)==1 & pointerM(1,4)==0
    pointerM(1,4)=1;
    axes(handles.axes5);
    m1=get(handles.axes5,'Currentpoint');
    hold on
    plot(m1(1,1),m1(1,2),'*','LineWidth',10,'MarkerSize',10);
    mapping=[mapping;3 m1(1,1) m1(1,2)];
end



get(hObject , 'CurrentPoint');
guidata(hObject, handles);

% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function result=checkPointAxes(m,pos)
min_v_w=pos(1);
max_v_w=pos(1)+pos(3);
min_v_h=pos(2);
max_v_h=pos(2)+pos(4);
if m(1)>min_v_w & m(1)<max_v_w & m(2)>min_v_h & m(2)<max_v_h
    result=1;
else
    result=0;
end

function imposed=reshapeToAdapt(a,resolution)
%fix image center
Xfix=resolution(1,1)/2;
Yfix=resolution(1,2)/2;

%Correction
a(:,2)=a(:,2)-Xfix;
a(:,3)=-a(:,3)+Yfix;

%reshape
k=0;
for ii=1:4:size(a,1)
    k=k+1;
    for jj=1:4
        for xx=1:3
            b(k,3*(jj-1)+xx)=a(ii+jj-1,xx);
        end
    end
end
imposed=b;
