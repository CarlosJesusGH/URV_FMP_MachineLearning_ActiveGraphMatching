function [cost, mapped_nodes] = computeCostStar_with_lab_nD_FEATURES(G1, G2, label1, label2, labelling,Features_Distance_nD)
%% Compute the cost of the external nodes of a star given a labelling
    mapped_nodes=0;
T=size(Features_Distance_nD,1);
cost = zeros(T,1);
    star1 = G1.edges(label1,:);
    star2 = G2.edges(label2,:);
    for i = 1:length(labelling)
        if (labelling(i) > 0)
            if (star1(i) == 1) && (star2(labelling(i)) == 1)
                cost=cost+Features_Distance_nD(:,i,labelling(i));
                mapped_nodes=mapped_nodes+1;

            end
        end
    end
end