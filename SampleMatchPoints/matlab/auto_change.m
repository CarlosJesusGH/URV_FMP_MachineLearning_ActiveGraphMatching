function p2=auto_change(pointChanged,keypointToChange,n)

%rsalient point changing
p1=pointChanged;
p2=keypointToChange;


for ii=1:size(p2,2)/4
    flag=0;
    jj=1;
    while flag==0
        %find the camera 
        if (p2(n,1+(ii-1)*4)==p1(1+(jj-1)*3))
            flag=1;
            %change x and y
            p2(n,3+(ii-1)*4)=p1(2+(jj-1)*3);
            p2(n,4+(ii-1)*4)=p1(3+(jj-1)*3);
        end
        jj=jj+1;
    end
end
end
