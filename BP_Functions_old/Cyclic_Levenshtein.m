function dmin=Cyclic_Levenshtein(str1,str2,ElemCost)
    L=size(str1,1);
    dmin=Levenshtein(str1,str2,ElemCost);
    for i=1:(L-1)
        str2 = [str2(2:end,:); str2(1,:)];
        d=Levenshtein(str1,str2,ElemCost);
        if(dmin>d)
            dmin=d;
        end
    end
end