function [w, Kv, Ke] = Linear_Classier_learn_edit_costs_STAR_nD(data,Outlier,attributes)
        data1=[]; 
        data2=[];
        T=length(attributes);   
    for elem = 1:size(data,2)    
        %elem
        labelling = data{elem}.labelling;
        if(sum(labelling>0)>0)
        G1 = data{elem}.graph1;
        G2 = data{elem}.graph2;
        data1_elem=[]; 
        data2_elem=[];
        
         G1.nodes=G1.nodes(:,attributes);
         G2.nodes=G2.nodes(:,attributes);
       

        for label = 1:length(labelling)
             % calcultating Substitution points (first option)
             %label
            if(labelling(label)>0)
                s1=zeros(1,T);
                %n = sum(G1.edges(label,:));
                m = sum(G2.edges(labelling(label),:));
                [costStar , nn]= computeCostStar_with_lab_nD(G1, G2, label, labelling(label), labelling);
                ze=2*nn+1-m;
                zv=ze-1;
                if (zv ~= 0)
                    z1=(G1.nodes(label,:)-G2.nodes(labelling(label),:)).^2+costStar;
                    s1(1)=z1(1)/zv;
                    s1(2:end)=(z1(2:end)-z1(1))/zv;%W
                    s1(end+1)=ze/zv; %Se
                    data1_elem=[data1_elem;s1];
                end
            else
            % calculating deletion points (second option)
               for k = 1:length(G2.nodes(:,1))
                   s2=zeros(1,T);   
                    %n = sum(G1.edges(label,:));
                    m = sum(G2.edges(k,:));
                    [costStar , nn] = computeCostStar_with_lab_nD(G1, G2, label, k, labelling);                
                    ze=2*nn+1-m;
                    zv=ze-1;
                    if (zv ~= 0)
                        z2=(G1.nodes(label,:)-G2.nodes(k,:)).^2+costStar;
                        s2(1)=z2(1)/zv;
                        s2(2:end)=(z2(2:end)-z2(1))/zv; %W
                        s2(end+1)=ze/zv;
                        data2_elem=[data2_elem;s2];                
                    end
               end
            end
        end
%% if we want to consider the whole substitution combinations      
%             data1 = [data1; data1_elem];
%             data2 = [data2; data2_elem];
%% end if
%% if we want to consider the mean of the substitution combinations
        data1 = [data1; data1_elem]; %substitution
        if(~isempty(data2_elem))
             data2 = [data2; mean(data2_elem,1)];
        end
%% end if

%% if we want to obtain only two points for each pair of graphs
%         if(~isempty(data1_elem))&&(~isempty(data2_elem))
%              data1 = [data1; mean(data1_elem,1)];
%              data2 = [data2; mean(data2_elem,1)];
%         end
%% end if


        end
        
    end
    % Outlier rejection
    if Outlier > 0
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
    end
    %Training
    Training = [data1; data2];
    trueDecision = [ones(size(data1,1),1);-ones(size(data2,1),1)];
   
    %Training=[sqrt(Training(:,1).*Training(:,1)+Training(:,2).*Training(:,2)), Training(:,3), Training(:,4)];
    [w, Kv, Ke] = Linear_Coefficients_nD (Training,trueDecision);
end
