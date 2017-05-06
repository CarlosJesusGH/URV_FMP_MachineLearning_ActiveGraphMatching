function data =  LoadAllRegisters_Learning_Bijective_Selected_Registers(Database,Selected_Registers)
data=[];
Max_Register= size(Selected_Registers,2);
for i =1:Max_Register
    Register=Selected_Registers(i);
    [G1,G2,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning');
        data{end+1}.graph1.nodes=G1.Nodes;
        data{end}.graph2.nodes=G2.Nodes;
        data{end}.graph1.edges=G1.Edges;
        data{end}.graph2.edges=G2.Edges;
        data{end}.labelling=f;
end
for k=1:Max_Register
vector_substract=zeros(1,length(data{end}.labelling));
vector_insertion=zeros(1,size(data{end}.graph2.nodes,1));
substract=0;
for i=1:size(data{end}.graph2.nodes,1)
    value=find(data{k}.labelling==i);
    if isempty(value)
        substract=substract+1;
        vector_insertion(i)=1;
    else
        vector_substract(value)=substract;       
    end
end   
    vector_delete=find(data{k}.labelling==-1);
    data{k}.labelling=data{k}.labelling-vector_substract;
    data{k}.graph1.nodes(vector_delete,:)=[];
    data{k}.labelling(vector_delete)=[]; 
    data{k}.graph1.edges(vector_delete,:)=[];
    data{k}.graph1.edges(:,vector_delete)=[];
    
    vector_insertion=find(vector_insertion==1);
    data{k}.graph2.nodes(vector_insertion,:)=[];
    data{k}.graph2.edges(vector_insertion,:)=[];
    data{k}.graph2.edges(:,vector_insertion)=[]; 
end