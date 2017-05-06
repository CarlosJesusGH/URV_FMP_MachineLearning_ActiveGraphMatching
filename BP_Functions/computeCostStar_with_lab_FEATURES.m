function [cost, mapped_nodes] = computeCostStar_with_lab_FEATURES(G1, G2, label1, label2, labelling,Features_Distance)
%% Compute the cost of the external nodes of a star given a labelling
    mapped_nodes=0;
    cost = 0;
    star1 = G1.edges(label1,:);
    star2 = G2.edges(label2,:);
    for i = 1:length(labelling)
        if (labelling(i) > 0)
            if (star1(i) == 1) && (star2(labelling(i)) == 1)
                cost=cost+Features_Distance(i,labelling(i));
                mapped_nodes=mapped_nodes+1;

            end
        end
    end
end