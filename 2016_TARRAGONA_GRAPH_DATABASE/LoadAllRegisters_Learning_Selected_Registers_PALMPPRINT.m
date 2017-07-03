function data =  LoadAllRegisters_Learning_Selected_Registers_PALMPPRINT(Database,Selected_Registers)
data=[];
Max_Register= size(Selected_Registers,2);
for i =1:Max_Register
    Register=Selected_Registers(i);
    [G1,G2,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning'); % Learning_Test: 'Learning' or 'Test'
        data{end+1}.graph1.nodes=G1.Nodes;
        data{end}.graph2.nodes=G2.Nodes;
        data{end}.graph1.edges=G1.Edges;
        data{end}.graph2.edges=G2.Edges;
        data{end}.labelling=f;
end
for k=1:Max_Register
vector_substract=zeros(1,length(data{k}.labelling));
vector_delete=zeros(1,length(data{k}.labelling));
vector_insertion=zeros(1,size(data{k}.graph2.nodes,1));
substract=0;
for i=1:size(data{k}.graph2.nodes,1) % Nodes G2
    value=find(data{k}.labelling==i); % Detect if is mapped from one in G1
    if isempty(value)
        if ((data{k}.graph2.nodes(i,4)==3)||(data{k}.graph2.nodes(i,5)==0))
        % The node G2(i) is an insertion and Low quality or Bifurcation
            substract=substract+1; % Number of nodes deleted in G2
            vector_insertion(i)=1;
        end
    else   % ~isempty(value)
       if ((data{k}.graph1.nodes(value,5)==0) || (data{k}.graph1.nodes(value,4)==3)||(data{k}.graph2.nodes(i,5)==0) || (data{k}.graph2.nodes(i,4)==3))
           %   Bifurcation or Low quality mapped to Bifurcation or Low quality.
            substract=substract+1; % Number of nodes deleted in G2
            vector_insertion(i)=1;
            vector_delete(value)=1;
       end
       vector_substract(value)=substract;   % G1(value) is mapped to G2(i)   
    end
end   
    % Low quality or Bifurcation Nodes in G1 are deleted

    vector_delete=find(vector_delete==1);
    data{k}.labelling=data{k}.labelling-vector_substract;
    data{k}.graph1.nodes(vector_delete,:)=[];
    data{k}.labelling(vector_delete)=[]; 
    data{k}.graph1.edges(vector_delete,:)=[];
    data{k}.graph1.edges(:,vector_delete)=[];
    
    vector_insertion=find(vector_insertion==1);
    data{k}.graph2.nodes(vector_insertion,:)=[];
    data{k}.graph2.edges(vector_insertion,:)=[];
    data{k}.graph2.edges(:,vector_insertion)=[];
%% Delete nodes in G1 that are send to null and (low quality or bifurcation)    

    vector_delete=find((data{k}.labelling(:)==0)&(data{k}.graph1.nodes(:,5)==0)|(data{k}.graph1.nodes(:,4)==3));    
    data{k}.graph1.nodes(vector_delete,:)=[];
    data{k}.labelling(vector_delete)=[]; 
    data{k}.graph1.edges(vector_delete,:)=[];
    data{k}.graph1.edges(:,vector_delete)=[];
   
    
    % Normalisation    
%     xy1=mean(data{k}.graph1.nodes(:,1:2));
%     data{k}.graph1.nodes(:,1)=data{k}.graph1.nodes(:,1)-xy1(1);
%     data{k}.graph1.nodes(:,2)=data{k}.graph1.nodes(:,2)-xy1(2);
%     xy2=mean(data{k}.graph2.nodes(:,1:2));
%     data{k}.graph2.nodes(:,1)=data{k}.graph2.nodes(:,1)-xy2(1);
%     data{k}.graph2.nodes(:,2)=data{k}.graph2.nodes(:,2)-xy2(2);   

end
end