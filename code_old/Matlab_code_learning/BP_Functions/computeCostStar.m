function cost = computeCostStar(G1, G2, label1, label2, labelling)
%% Compute the cost of the external nodes of a star given a labelling
    cost = 0;
    star1 = G1.edges(label1,:);
    star2 = G2.edges(label2,:);
    for i = 1:length(labelling)
        if (labelling(i) > 0)
            if (star1(i) == 1) && (star2(labelling(i)) == 1)
                cost = cost+norm(G1.nodes(i,:)-G2.nodes(labelling(i),:));
            end
        end
    end
end