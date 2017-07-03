

Data = [1:100 ; 51:150 ]';
Class=[ones(50,1) ; -ones(50,1)];
MdlLinear=fitcdiscr(Data,Class);
n = MdlLinear.Coeffs(1,2).Const;
m = MdlLinear.Coeffs(1,2).Linear;

X1=Data(Class==1,1);
Y1=Data(Class==1,2);
X2=Data(Class==-1,1);
Y2=Data(Class==-1,2);
plot(X1,Y1,'r+');
hold on;
plot(X2,Y2,'b*');
xMin_line=min(Data(:,1));
yMin_line=m*min(Data(:,1))+n;
xMax_line=max(Data(:,1));
yMax_line=m*max(Data(:,1))+n;
plot([xMin_line; xMax_line], [yMin_line; yMax_line]), 
