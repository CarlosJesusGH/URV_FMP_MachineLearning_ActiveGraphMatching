function [w , Kv , Ke] = Linear_Coefficients_nD (Data,Class)
MdlLinear=fitcdiscr(Data,Class);
n = MdlLinear.Coeffs(1,2).Const;
m = MdlLinear.Coeffs(1,2).Linear;
%% Data: x,y,z,...g,t
% m(1)·x+m(2)·y+...+m(end-1)·g+m(end)·t+n=0
Kv=n/m(1);
Ke=m(end)/m(1);
w=m(2:end-1)/m(1);
w1=1 - sum(w);
w = [w1 w'];
%%
% if(mean(m(1:end-2)<0)) % weights w are negative
%     m=-m;
%     n=-n;
% end

%% Plot 3D figure
if size(Data,2) == 3
X1=Data(Class==1,1);
Y1=Data(Class==1,2);
Z1=Data(Class==1,3);
X2=Data(Class==-1,1);
Y2=Data(Class==-1,2);
Z2=Data(Class==-1,3);
hold on

nxz=-n/m(1);
my=-m(2)/m(1);
mz=-m(3)/m(1);

zmin=min(Data(:,3));
zmax=max(Data(:,3));
ymin=min(Data(:,2));
ymax=max(Data(:,2));
[yy,zz]=meshgrid([ymin ymax],[zmin zmax]);
xx=yy*my+zz*mz+nxz;
surf(xx,yy,zz);

plot3(X1,Y1,Z1,'r+');
plot3(X2,Y2,Z2,'b*');
xlabel('S1');
ylabel('S2');
zlabel('Se');
end
end
