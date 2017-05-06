function [w, Kv, Ke] = Linear_Classier_learn_edit_costs_FEATURES_nD(data,Outlier)
        data1=[]; 
        data2=[];
           
    for elem = 1:size(data,2)  
        elem
        labelling = data{elem}.labelling;
        if(sum(labelling>0)>0)
        G1 = data{elem}.graph1;
        G2 = data{elem}.graph2;
        data1_elem=[]; 
        data2_elem=[];
        %Features_Distance=Compute_Features_Distance(G1.nodes(:,3:end),G2.nodes(:,3:end));
        G1.nodes=G1.nodes(:,3:end);
        G2.nodes=G2.nodes(:,3:end);
        for label = 1:length(labelling)
             % calcultating Substitution points (first option)
            if(labelling(label)>0)
                zz1=[];
                n = sum(G1.edges(label,:));
                m = sum(G2.edges(labelling(label),:));
                DDD=n+1-abs(n-m);
                if (DDD ~= 0)
                    
                    costStar  = computeCostStar_nD(G1, G2, label, labelling(label), labelling);
                    for t=1:length(costStar) % t: Number of attributes
                        zz1(t)=abs(G1.nodes(label,t)-G2.nodes(labelling(label),t))+costStar(t);
                    end
                    zz1(length(costStar)+1)=(n-abs(n-m)) / DDD; % Ke
                    data1_elem=[data1_elem;zz1];
                end
            else
            % calculating deletion points (second option)
               for k = 1:length(G2.nodes(:,1))
                   zz2=[];   
                    n = sum(G1.edges(label,:));
                    m = sum(G2.edges(k,:));
                    DDD=n+1-abs(n-m);
                    if (DDD ~= 0)
                        costStar  = computeCostStar_nD(G1, G2, label, k, labelling);
                        for t=1:length(costStar) % t: Number of attributes
                            zz2(t)=(abs(G1.nodes(label,t)-G2.nodes(k,t))+costStar(t))/DDD;
                        end
                        zz2(length(costStar)+1)=(n-abs(n-m)) / DDD; % Ke
                        data2_elem=[data2_elem;zz2];                
                    end
               end
            end
        end
        if(~isempty(data1_elem))&&(~isempty(data2_elem))
             data1 = [data1; mean(data1_elem,1)];
             data2 = [data2; mean(data2_elem,1)];
        end        
        end
        
    end
    % Outlier rejection
percntiles = prctile(data1,[Outlier 100-Outlier]); %5th and 95th percentile
outlierIndexA(:,1) = data1(:,1) < percntiles(1,1) | data1(:,1) > percntiles(2,1);
outlierIndexA(:,2) = data1(:,2) < percntiles(1,2) | data1(:,2) > percntiles(2,2);
outlierIndexA(:,1) = outlierIndexA(:,1) | outlierIndexA(:,2);
data1(outlierIndexA(:,1),:) = [];

percntiles = prctile(data2,[Outlier 100-Outlier]); %5th and 95th percentile
outlierIndexB(:,1) = data2(:,1) < percntiles(1,1) | data2(:,1) > percntiles(2,1);
outlierIndexB(:,2) = data2(:,2) < percntiles(1,2) | data2(:,2) > percntiles(2,2);
outlierIndexB(:,1) = outlierIndexB(:,1) | outlierIndexB(:,2);
data2(outlierIndexB(:,1),:) = [];

    %Training
    Training = [data1; data2];
    trueDecision = [ones(size(data1,1),1);-ones(size(data2,1),1)];
   
    %Training=[sqrt(Training(:,1).*Training(:,1)+Training(:,2).*Training(:,2)), Training(:,3), Training(:,4)];
    [m, Kv] = Linear_Coefficients_nD (Training,trueDecision);
    Ke=m(end);
    w=m(1:end-1);
end
