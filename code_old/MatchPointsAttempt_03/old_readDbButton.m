%     display('LETTERLOW');
    Kv=50; Ke=50;
%     [hamming_LETTERLOW6,runtime_LETTERLOW6,hamming_Graph_LETTERLOW6] = hammingDatabase_Clique('LETTERLOW',Kv,Ke,1)
    databaseName = 'LETTERLOW';
    load(strcat(databaseName,'.mat'));
    errors = [];
    number_of_test=0;
    total_runtime=0;
    % ----
    length(Database.Test)
    for i = 1:1%length(Database.Test)
        currentElem = Database.Test{i}
        G1 = currentElem.Graph
        nodes = G1.Nodes
        corr = currentElem.Correspondences
        length(currentElem.Correspondences)
        for j = 1:length(currentElem.Correspondences)
            if (j ~= i)
                % ?
                G2 = Database.Test{currentElem.Correspondences{j}.InputGraph}.Graph;
                % ?
                idealMapping = currentElem.Correspondences{j}.Mappings;

                switch databaseName
                    case 'LETTERLOW'
                        NA = G1.Nodes;
                        NB = G2.Nodes;
                        EA = G1.Edges;
                        EB = G2.Edges;

                        KV = 1;
                        KE = 1;
                        
                        tic
                        [~,automaticMapping] = BP_Degree_Centrality_h(NA,NB,EA,EB,KV,KE);
                        errors(end + 1) = 1-(length(find(automaticMapping - idealMapping) ~= 0) / length(automaticMapping));
                        runtime=toc;
                        runtime
                        total_runtime=total_runtime+runtime;
                        number_of_test=number_of_test+1;
                        number_of_test
                        end
            end            
            mean(errors)
        end
    end
    
    % save Database Database;
    average_hamming = mean(errors);
    average_runtime=total_runtime/number_of_test;
    
%     [hamming_LETTERLOW,runtime_LETTERLOW] = hammingDatabase('LETTERLOW');
%     Kv=-0.0048; Ke=1.3542;
%     [hamming_LETTERLOW7,runtime_LETTERLOW7,hamming_Graph_LETTERLOW7] = hammingDatabase_Clique('LETTERLOW',Kv,Ke,0);