function [m , n] = Linear_Coefficients_nD (Data,Class)
MdlLinear=fitcdiscr(Data,Class);
n = MdlLinear.Coeffs(1,2).Const;
m = MdlLinear.Coeffs(1,2).Linear;
%% Data: x,y,z,...g,t
% m(1)·x+m(2)·y+m(3)·z+...+m(end)·g+n·t

%% Plot 3D figure
nn=-n/m(1); 
mm=-m/m(1); 

if size(Data,2) == 3
X1=Data(Class==1,1);
Y1=Data(Class==1,2);
Z1=Data(Class==1,3);
X2=Data(Class==-1,1);
Y2=Data(Class==-1,2);
Z2=Data(Class==-1,3);
hold on

% [yy,zz]=meshgrid(Y1,Z1);
% [yy1,zz1]=meshgrid(Y2,Z2);
% xx=yy*mm(2)+zz*mm(3)+nn;
% surf(xx,yy,zz);
% xx1=yy1*mm(2)+zz1*mm(3)+nn;
% surf(xx1,yy1,zz1);

zmin=min(Data(:,3));
zmax=max(Data(:,3));
ymin=min(Data(:,1));
ymax=max(Data(:,1));
[yy,zz]=meshgrid([ymin ymax],[zmin zmax]);
xx=yy*mm(2)+zz*mm(3)+nn;
% zminmin=ymin*mm(2)+xmin*mm(3)+nn;
% zminmax=ymin*mm(2)+xmax*mm(3)+nn;
% zmaxmin=ymax*mm(2)+xmin*mm(3)+nn;
% zmaxmax=ymax*mm(2)+xmax*mm(3)+nn;
% xx1=[xmin xmin xmax xmax];
% yy1=[ymin ymax ymin ymax];
% zz1=[zminmin , zmaxmin ; zmaxmin , zmaxmax];
surf(xx,yy,zz);

plot3(X1,Y1,Z1,'r+');
plot3(X2,Y2,Z2,'b*');
xlabel('x axis');
ylabel(' Y axis');
zlabel(' Z axis');
end
end
