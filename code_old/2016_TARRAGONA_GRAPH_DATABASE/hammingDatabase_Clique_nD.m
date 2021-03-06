function [average_hamming,average_runtime,errors] = hammingDatabase_Clique_nD(databaseName,w,attributes,KV,KE,num_test_graphs)
    
% This function measures the average hamming distance (dissimilarity of mappings)
% between the ground truth correspondence and a correspondence generated by
% the Bipartite algorithm (using the degree centrality) for all registers of the
% Test set. It also measures the average runtime for each correspondence
% generation and comparison

    %addpath('Utils');
    %addpath(databaseName);
    load(strcat(databaseName,'.mat'));
    
    errors = [];
    number_of_test=0;
    total_runtime=0;
    if num_test_graphs==0
        num_test_graphs=length(Database.Test);
    end
    for i = 1:num_test_graphs
        %display(floor(100*i/num_test_graphs));
        currentElem = Database.Test{i};
        G1 = currentElem.Graph;
        for j = 1:length(currentElem.Correspondences)
            if (j ~= i)
                G2 = Database.Test{currentElem.Correspondences{j}.InputGraph}.Graph;
                idealMapping = currentElem.Correspondences{j}.Mappings;
                lll= idealMapping~=-1;
                idealMapping=idealMapping.*lll; % -1 converted to 0 in the database
                switch databaseName
                    case 'LETTERLOW'
                        NA = G1.Nodes;
                        NB = G2.Nodes;
                        EA = G1.Edges;
                        EB = G2.Edges;

                        tic
                        [~,automaticMapping] = BP_Clique_Centrality_h_nD(NA,NB,EA,EB,w,attributes,KV,KE);
                        errors(end + 1) = 1-(length(find(automaticMapping - idealMapping) ~= 0) / length(automaticMapping));
                        runtime=toc;
                        
                        total_runtime=total_runtime+runtime;
                        number_of_test=number_of_test+1;
                        
                        
                    case 'LETTERMED'
                        NA = G1.Nodes;
                        NB = G2.Nodes;
                        EA = G1.Edges;
                        EB = G2.Edges;

                          tic
                        [~,automaticMapping] = BP_Clique_Centrality_h_nD(NA,NB,EA,EB,w,attributes,KV,KE);
                        errors(end + 1) = 1-(length(find(automaticMapping - idealMapping) ~= 0) / length(automaticMapping));
                        runtime=toc;
                        
                        total_runtime=total_runtime+runtime;
                        number_of_test=number_of_test+1;
                        
                        
                    case 'LETTERHIGH'
                        NA = G1.Nodes;
                        NB = G2.Nodes;
                        EA = G1.Edges;
                        EB = G2.Edges;

                        tic
                        [~,automaticMapping] = BP_Clique_Centrality_h_nD(NA,NB,EA,EB,w,attributes,KV,KE);
                        errors(end + 1) = 1-(length(find(automaticMapping - idealMapping) ~= 0) / length(automaticMapping));
                        runtime=toc;
                        
                        total_runtime=total_runtime+runtime;
                        number_of_test=number_of_test+1;
                        
                        
                    case 'HOUSEHOTEL'
                        NA = G1.Nodes(:,3:62);
                        NB = G2.Nodes(:,3:62);
                        EA = G1.Edges;
                        EB = G2.Edges;

                        tic
                        [~,automaticMapping] = BP_Clique_Centrality_h_nD(NA,NB,EA,EB,w,attributes,KV,KE);
                        errors(end + 1) = 1-(length(find(automaticMapping - idealMapping) ~= 0) / length(automaticMapping));
                        runtime=toc;
                        
                        total_runtime=total_runtime+runtime;
                        number_of_test=number_of_test+1;
                        
                        
                    case 'SAGRADAFAMILIA3D'
                        NA = G1.Nodes;
                        NB = G2.Nodes;
                        EA = G1.Edges;
                        EB = G2.Edges;

                        tic
                        [~,automaticMapping] = BP_Clique_Centrality_h_nD(NA,NB,EA,EB,w,attributes,KV,KE);
                        errors(end + 1) = 1-(length(find(automaticMapping - idealMapping) ~= 0) / length(automaticMapping));    
                        runtime=toc;
                        
                        total_runtime=total_runtime+runtime;
                        number_of_test=number_of_test+1;
                        
                        
                    case 'PALMPRINT'
                        
                        NA = G1.Nodes;
                        NB = G2.Nodes;
                        EA = G1.Edges;
                        EB = G2.Edges;

                        tic
                        [~,automaticMapping] = BP_Clique_Centrality_h_nD(NA,NB,EA,EB,w,attributes,KV,KE);
                        errors(end + 1) = 1-(length(find(automaticMapping - idealMapping) ~= 0) / length(automaticMapping));
                        runtime=toc;
                        
                        total_runtime=total_runtime+runtime;
                        number_of_test=number_of_test+1;
                        
                        
                    case 'ROTATIONZOOM'
                        NA = G1.Nodes;
                        NB = G2.Nodes;
                        EA = G1.Edges;
                        EB = G2.Edges;

                        tic
                        [~,automaticMapping] = BP_Clique_Centrality_h_With_Weights_Features(NA,NB,EA,EB,w,attributes,KV,KE);
                        errors(end + 1) = 1-(length(find(automaticMapping - idealMapping) ~= 0) / length(automaticMapping));                   
                        runtime=toc;
                        
                        total_runtime=total_runtime+runtime;
                        number_of_test=number_of_test+1;
                        
                        
                    otherwise
                        error('Unexpected database name.');
                end
            end            
        end
    %display(floor(100*i/num_test_graphs));
    %mean(errors)
    end
    average_hamming = mean(errors);
    average_runtime=total_runtime/number_of_test;
end