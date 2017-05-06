function [average_accuracy,average_runtime,accuracy] = classifyDatabase_Point(databaseName,KV,num_test_graphs)

% This function measures the classification accuracy using a 1NN 
% classifier computing the distances through the Bipartite algorithm
% (using the Clique centrality

    load(strcat(databaseName,'.mat'));
    accuracy = [];
    costsMatrix = [];
    number_of_test=0;
    total_runtime=0;
    if num_test_graphs==0
        num_test_graphs=length(Database.Test);
    end
    for i = 1:num_test_graphs
        currentElem = Database.Test{i};
        G1 = currentElem.Graph;
        if strcmp(databaseName,'PALMPRINT')==1
            [G1.Nodes,G1.Edges]=Palmprint_Minutiae_Selection(G1.Nodes,G1.Edges);
        end

        for j = 1:length(Database.Learning)

            currentElem = Database.Learning{j};
            G2 = currentElem.Graph;

            switch databaseName
                case 'LETTERLOW'
                    NA = G1.Nodes;
                    NB = G2.Nodes;
                    EA = G1.Edges;
                    EB = G2.Edges;

                    tic
                    [cost,~] = BP_Points_Centrality_h(NA,NB,KV);
                    runtime=toc;
%                     runtime
                    total_runtime=total_runtime+runtime;
                    number_of_test=number_of_test+1;
%                     number_of_test

                case 'LETTERMED'
                    NA = G1.Nodes;
                    NB = G2.Nodes;
                    EA = G1.Edges;
                    EB = G2.Edges;

                    tic
                    [cost,~] = BP_Points_Centrality_h(NA,NB,KV);
                    runtime=toc;
%                     runtime
                    total_runtime=total_runtime+runtime;
                    number_of_test=number_of_test+1;
%                     number_of_test

                case 'LETTERHIGH'
                    NA = G1.Nodes;
                    NB = G2.Nodes;
                    EA = G1.Edges;
                    EB = G2.Edges;

                    tic
                    [cost,~] = BP_Points_Centrality_h(NA,NB,KV);
                    runtime=toc;
%                     runtime
                    total_runtime=total_runtime+runtime;
                    number_of_test=number_of_test+1;
%                     number_of_test

                case 'HOUSEHOTEL'
                    NA = G1.Nodes;
                    NB = G2.Nodes;
                    EA = G1.Edges;
                    EB = G2.Edges;

                      tic
                    [cost,~] = BP_Points_Centrality_h_Features(NA,NB,KV);
                    runtime=toc;
%                     runtime
                    total_runtime=total_runtime+runtime;
                    number_of_test=number_of_test+1;
%                     number_of_test

                case 'SAGRADAFAMILIA3D'
                    NA = G1.Nodes;
                    NB = G2.Nodes;
                    EA = G1.Edges;
                    EB = G2.Edges;

                      tic
                    [cost,~] = BP_Points_Centrality_h(NA,NB,KV);
                    runtime=toc;
%                     runtime
                    total_runtime=total_runtime+runtime;
                    number_of_test=number_of_test+1;
%                     number_of_test

                case 'PALMPRINT'
                    
                    NA = G1.Nodes;
                    NB = G2.Nodes;
                    EA = G1.Edges;
                    EB = G2.Edges;

                    tic
                    [cost,~] = BP_Points_Centrality_jv_Palmprint(NA,NB,KV);
                    runtime=toc;
%                     runtime
                    total_runtime=total_runtime+runtime;
                    number_of_test=number_of_test+1;
%                     number_of_test

                case 'ROTATIONZOOM'
                    NA = G1.Nodes;
                    NB = G2.Nodes;
                    EA = G1.Edges;
                    EB = G2.Edges;

                    
                    tic
                    [cost,~] = BP_Points_Centrality_h_Features(NA,NB,KV);
                    runtime=toc;
%                     runtime
                    total_runtime=total_runtime+runtime;
                    number_of_test=number_of_test+1;
%                     number_of_test

                otherwise
                    error('Unexpected database name.');
            end

            costsMatrix(i, j) = cost;
            display(j);
        end
        
        [~, pos] = min(costsMatrix(i,:));
        if (Database.Learning{pos}.Class == Database.Test{i}.Class)
            accuracy(end+1) = 1;
        else
            accuracy(end+1) = 0;
        end            
        display(floor(100*i/num_test_graphs));
    end
    average_accuracy = mean(accuracy);
    average_runtime=total_runtime/number_of_test;
end