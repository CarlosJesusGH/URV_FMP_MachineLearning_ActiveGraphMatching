

%% homographies
function [camNum,H,camPos,point3D]=homographies(keyPoints)
%% FUNCTION Initialization 
%input: in the folder 'images' must be images files to process
%output: camNum-->number of images processed
%        H-->all the images homographies from the wordl to the cameras
%        camPos--> Camera Position view 
%        M-->matrix of matched points
%        point3D-->3D points processed
%        matched-->points matched between images

%% IMAGES INFO
%images path
images_name=dir('images/*.jpg');
%all images info (no sense warning calling the function)
warning off
image_info=imfinfo(sprintf('images/%s',images_name(1).name));
%images resolution
resolution=[image_info.Width image_info.Height];

%% UNIX SHELL FROM CYGWIN
%Please instal cygwin64 and insert the instal path
%in my case 'C:\cygwin64\bin\bash' in the first column
path_cygwin='C:\cygwin64\bin\bash --login -c "';

%images folder (must be images file in images folder)
temp_path=cd;   ind=strfind(cd,'\');    temp_path(ind)='/';
images_path=['cd ',temp_path,'/images'];

%shell + images path
path_system=strcat(path_cygwin,images_path);

%software running
system(sprintf('%s;../bundler/RunBundler.sh"',path_system));

%% STRUCT FROM EMOTION READING
[N,P,R,T,D,I,NI]=outread('images/bundle/bundle.out');
%N=[Ncameras,NkeypointsMatched]
%P=[focal lenght, coef. distorsionX,coef.distorisionY]--> 3xNcameras
%R=AllCameraRotationMatrix-->3x3xNcameras
%T=AllCameraTraslationVector-->Ncamerasx3 (it is the camera coodinates)
%D=3dKeypointsCoordinates-->NkeypointsMatched x 3
%I=keypointInfo[cameraView1,key,X,Y,cameraView2,key,....]->4x Ncameras x NkeypointsMatched
%NI=Number of camera for a 3D-point


%%HUMAN IMPOSE
%extract the best,save the bestkeypoints index
[~,ind]=find(max(NI)==NI');
bestKeypoint= I(ind,1:(max(NI)*4));

%changes keypoints
for ii=1:size(keyPoints,1)
keypointChanged=auto_change(keyPoints(ii,:),bestKeypoint,ii);
end

%database changing 
folderInput='images';
folderOutput='images/human';

disp('inizio')
%input for changing keypoints
coordinatorChanges(NI,ind,bestKeypoint,keypointChanged,...
     folderInput,folderOutput,resolution,path_system);


%% unix shell for bundler 
bundleCommand='../bundler/bin/Bundler.exe list.txt --options_file options.txt > bundle/out"';
system(sprintf('%s;%s',path_system,bundleCommand));

disp('prima')

% read file adapted from Bundler
[N,P,R,T,D,I,NI]=outread('images/bundle/bundle.out');


%% CAMERA POSITIONS
%cameras position by system
for ii=1:size(T,1)
    camPos_system(ii,:)=(-(R(:,:,ii)')*(T(ii,:)'))';
    camPos_system(ii,1)=-camPos_system(ii,1);
end

disp('secondo')
%% OUTPUT

%homographies
for ii=1:N(1)
    H(:,:,ii)=[R(:,:,ii) T(ii,:)';0 0 0 1];
end
disp('terzo')
%cameras positions
camPos=camPos_system;

%cameras numbers
camNum=N(1);

%3D POINTS
point3D=D;


end