function [cost , nn] = computeCostStar_FEATURES(G1, G2, i, j,Features_Distance)
ii=find(G1.edges(i,:)>0);
jj=find(G2.edges(j,:)>0);
a=length(ii);
b=length(jj);
nn=min(a,b);
C=zeros(a,b);
  for i=1:a
    for j=1:b
        C(i,j)=Features_Distance(ii(i),jj(j));
    end
  end
  lab=Hungarian(C);
  cost=sum(sum(lab.*C));
end