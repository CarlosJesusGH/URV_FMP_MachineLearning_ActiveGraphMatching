function dist=Levenshtein(str1,str2,ElemCost)
    L1=size(str1,1)+1;
    L2=size(str2,1)+1;
    L=zeros(L1,L2);
    L(:,1)=([0:L1-1]*ElemCost)';
    L(1,:)=[0:L2-1]*ElemCost;
    for idx=2:L1;
        for idy=2:L2
            m1=L(idx-1,idy-1) + norm(str1((idx-1),:)-str2((idy-1),:));
            m2=L(idx-1,idy) + ElemCost;
            m3=L(idx,idy-1) + ElemCost;
            L(idx,idy)=min(m1,min(m2,m3));
        end
    end
    dist=L(L1,L2);
end