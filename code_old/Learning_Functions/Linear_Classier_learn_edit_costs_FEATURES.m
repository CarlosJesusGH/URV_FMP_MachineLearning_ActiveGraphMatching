function [Kv, Ke, data1, data2] = Linear_Classier_learn_edit_costs_FEATURES(data, Outlier)
 %    Outlier: Percentil. [1..99] 
 
    x1 = [];
    y1 = [];
    x2 = [];
    y2 = [];
                
    for elem = 1:size(data,2)    
        labelling = data{elem}.labelling;
        if(sum(labelling>0)>0)
        G1 = data{elem}.graph1;
        G2 = data{elem}.graph2;
        % x,y coordinades are not used
        Features_Distance=Compute_Features_Distance(G1.nodes(:,3:end),G2.nodes(:,3:end));
               xx2=[];
               yy2=[];
               xx1=[];
               yy1=[];

        for label = 1:length(labelling)
            % calcultating Substitution points (first option)
            if(labelling(label)>0)
                %n = sum(G1.edges(label,:));
                m = sum(G2.edges(labelling(label),:));
                
                [costStar , nn] = computeCostStar_with_lab_FEATURES(G1, G2, label, labelling(label), labelling,Features_Distance);
                DDD=(m-2*nn-1);
                if (DDD ~= 0)           
                    yy1(end+1) = -(Features_Distance(label,labelling(label))+ costStar) / DDD; % ***
                    xx1(end+1) = (m-2*nn) / DDD; % ***
                end
            else
            % calculating deletion points (second option)
               for k = 1:length(G2.nodes(:,1))
                    %n = sum(G1.edges(label,:));
                    m = sum(G2.edges(k,:));
            
                    [costStar , nn]  = computeCostStar_with_lab_FEATURES(G1, G2, label, k, labelling,Features_Distance);
                    DDD=(m-2*nn-1);
                    if (DDD ~= 0)                        
                         yy2(end+1) = -(Features_Distance(label,k)+ costStar) / DDD; % ***
                         xx2(end+1) = (m-2*nn) / DDD; % ***
                    end
               end
            end
        end
        if(~isempty(yy1))&&(~isempty(yy2))
             y1(end+1) = mean(yy1);
             x1(end+1) = mean(xx1);
        end
        if(~isempty(yy1))&&(~isempty(yy2))
             y2(end+1) = mean(yy2);
             x2(end+1) = mean(xx2);
        end        
    end
    end
        data1 = [x1;y1]';
        data2 = [x2;y2]';

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

x1=data1(:,1)';
y1=data1(:,2)';
x2=data2(:,1)';
y2=data2(:,2)';
% outliers have been removed           
        
        if (length(data1) == 0)
            Kv = -Inf;
            Ke = -Inf;
        else if(length(data2) == 0)
            Kv = Inf;
            Ke = Inf;
        else    
            trueDecision = [ones(length(x1),1);-ones(length(x2),1)];
            Training = [x1' y1' ; x2' y2'];

            [Ke, Kv] = Linear_Coefficients_2D (Training,trueDecision);
        end
end