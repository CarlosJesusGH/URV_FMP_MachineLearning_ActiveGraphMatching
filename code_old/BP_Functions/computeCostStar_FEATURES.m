function [cost , nn] = computeCostStar_FEATURES(G1, G2, i, j,Features_Distance)
    star1 = G1.edges(i,:);
    star2 = G2.edges(j,:);
a=size(star1,1);
b=size(star2,1);
nn=min(a,b);
C=zeros(a,b);
  for i=1:a
    for j=1:b      
        C=(NeighboursA(i,:)-NeighboursB(j,:)).^2;
    end
  end
    lab=Hungarian(C);
    cost=sum(sum(lab.*C));
end



%% Compute the cost of the external nodes of a star given a labelling
    cost = 0;
    star1 = G1.edges(label1,:);
    star2 = G2.edges(label2,:);
    for i = 1:length(labelling)
        if (labelling(i) > 0)
            if (star1(i) == 1) && (star2(labelling(i)) == 1)
                cost = cost+Features_Distance(i,labelling(i));
            end
        end
    end
end