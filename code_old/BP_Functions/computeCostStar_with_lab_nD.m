function [cost, mapped_nodes] = computeCostStar_with_lab_nD(G1, G2, label1, label2, labelling)
%% Compute the cost of the external nodes of a star given a labelling
    mapped_nodes=0;
    T=size(G1.nodes,2);
    cost = zeros(1,T);
    star1 = G1.edges(label1,:);
    star2 = G2.edges(label2,:);
    for i = 1:length(labelling)
        if (labelling(i) > 0)
            if (star1(i) == 1) && (star2(labelling(i)) == 1)
                cost=cost+(G1.nodes(i,:)-G2.nodes(labelling(i),:)).^2;
                mapped_nodes=mapped_nodes+1;

            end
        end
    end
end