function dist=Hausdorff(str1,str2,ElemCost)
    L1=size(str1,1)+1;
    L2=size(str2,1)+1;
    C=zeros(L1,L2);
    C(:,end)=ElemCost;
    C(end,:)=ElemCost;
    for idx=1:(L1-1)
        for idy=1:(L2-1)
            C(idx,idy)=0.5*norm(str1(idx,:)-str2(idy,:));
        end
    end
    A=min(C,[],1);
    A(end)=0;
    B=min(C,[],2);
    B(end)=0;
    dist=sum(A)+sum(B);
    dist=max(dist,abs(L1-L2)*ElemCost);
end