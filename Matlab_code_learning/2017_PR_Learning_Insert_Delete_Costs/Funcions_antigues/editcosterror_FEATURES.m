function F = editcosterror_FEATURES(x)
    global LEARNING_SET;   
    global LAMBDA;
    
    Kn = x(1);
    Ke = x(2);          
    F = 0;
    tic
    for iter = 1:size(LEARNING_SET,2)    
        elem = LEARNING_SET(iter);
        G1 = elem{1}.graph1;
        G2 = elem{1}.graph2;
        LabIdeal = elem{1}.labelling; 
        [distanceAuto,LabAuto]=BP_Clique_Centrality_h_Features(G1.nodes, G2.nodes,G1.edges, G2.edges, Kn, Ke);        
        distanceIdeal = Edit_Cost_FEATURES(G1.nodes, G2.nodes,G1.edges, G2.edges, Kn, Ke,LabIdeal);
        distanceAuto = Edit_Cost_FEATURES(G1.nodes, G2.nodes,G1.edges, G2.edges, Kn, Ke,LabAuto);       
        F = F + (distanceAuto - distanceIdeal)^2;        
    end
    F = (F/ length(LEARNING_SET))+LAMBDA * (Kn^2 + Ke^2)
    toc
    [Kn Ke]
end