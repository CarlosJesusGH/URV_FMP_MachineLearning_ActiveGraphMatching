function Print_Graph_Labelling(P1, P2,L)
    maxX1=max(P1(:,1));  maxY1=max(P1(:,2));
    maxX2=max(P2(:,1));  maxY2=max(P2(:,2));
    maxX=max(maxX1,maxX2); maxY=maxY1+maxY2;
    I=zeros(fix(maxX)+1,fix(maxY)+1);
    imshow(I);
    hold on;  
    p1cols = size(P1,1);
    p2cols = size(P2,1);
    for i=1:p1cols
        plot(P1(i,2),P1(i,1),'sk', 'MarkerFaceColor','b');
    end
    for i=1:p2cols
            plot(P2(i,2)+maxY1,P2(i,1),'sk', 'MarkerFaceColor','g');
    end
%     % plotting correspondences
    for i = 1:length(L)
        if (L(i) >0)
                X = [P1(i,1); P2(L(i),1);];
                Y = [P1(i,2); P2(L(i),2)+maxY1;];
                line(Y,X,'LineWidth',1,'Color',[1 0 0]);
        end
    end
end