function [distance,lab]=Optimal_GED_Perms(NA,NB,EA,EB,NodeInsDel,ArcInsDel)
vB=1:size(NB,1);
vA=zeros(size(NA,1),1);
v=[vB  vA'];
P=perms(v);
s=size(P,1);
k=1;
while k<=s
  j=k+1;
  while j<=s
    if P(k,:)==P(j,:)
        P(j,:)=[];
        s=size(P,1);
    end
    j=j+1;
  end
  k=k+1;
end

distance=100000;
for i=1:s
    cost = Edit_Cost(NA,NB,EA,EB,NodeInsDel,ArcInsDel,P(i,:));
    if cost<distance
		distance = cost;
		lab=P(i,:);
    end
end
lab=lab(1:size(NA,1));
end
		
