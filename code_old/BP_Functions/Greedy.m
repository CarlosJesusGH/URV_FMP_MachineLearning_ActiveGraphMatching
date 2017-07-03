function dist=Greedy(str1,str2,ElemCost)
dist=0;
    L1=size(str1,1);
    L2=size(str2,1);
if(L1>=L2)
    C=zeros(L1,L2+1);
    C(:,end)=ElemCost;
    for idx=1:L1
        for idy=1:L2
            C(idx,idy)=norm(str1(idx,:)-str2(idy,:));
        end
    end
    for idx=1:L1
        [Y,I] = min(C(idx,:));
        dist=dist+Y;
        if(I<=L2)
          C(idx:end,I)=10000000;
        end
    end
else
    C=zeros(L2,L1+1);
    C(:,end)=ElemCost;
    for idy=1:L2
        for idx=1:L1
            C(idy,idx)=norm(str2(idy,:)-str1(idx,:));
        end
    end
    for idy=1:L2
        [Y,I] = min(C(idy,:));
        dist=dist+Y;
        if(I<=L1)
          C(idy:end,I)=10000000;
        end
    end
end
 end