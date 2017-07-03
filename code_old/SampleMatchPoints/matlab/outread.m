function [data,parmetersCam,rotationMatrix,translationVector,pointCoordinator3d,pointInfo,numViews]=outread(Path,Str)

%open file
[fid,Msg] = fopen(Path,'rt');	% open file in read text mode
if fid == -1, error('Image Set Error. Not enough images or not correlated'); end

%data
buf=fscanf(fid,'%s',4)
data= fscanf(fid,'%d',[2 1]);
cameraN=data(1);
keypointN=data(2);

%init
parmetersCam=zeros(cameraN,3);
rotationMatrix=zeros(0,0,cameraN);
translationVector=zeros(cameraN,3);
pointCoordinator3d=zeros(keypointN,3);
rgbPoint=zeros(keypointN,3);
pointInfo=-ones(keypointN,4*cameraN);

%camera features reading
for ii=1:cameraN
    parmetersCam(ii,:)=fscanf(fid,'%f',[1 3]);
    
    for jj=1:3
        for kk=1:3
            rotationMatrix(jj,kk,ii)=fscanf(fid,'%f',1);
        end
    end
    
    translationVector(ii,:)=fscanf(fid,'%f',[1 3]);
end

numViews=zeros(keypointN,1);

%keypoint reading
for ii=1:keypointN
    pointCoordinator3d(ii,:)=fscanf(fid,'%f',[1 3]);
    rgbPoint(ii,:)=fscanf(fid,'%d',[1 3]);
    pointcamerasviewN=fscanf(fid,'%d',[1]);
    for jj=1:pointcamerasviewN*4
     pointInfo(ii,jj)=fscanf(fid,'%f',1);
    end
numViews(ii)=pointcamerasviewN;
end

%file close
fclose(fid);


end