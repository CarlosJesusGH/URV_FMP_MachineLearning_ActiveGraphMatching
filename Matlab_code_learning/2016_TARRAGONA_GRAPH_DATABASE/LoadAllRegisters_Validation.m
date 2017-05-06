function data =  LoadAllRegisters_Validation(Database,Max_Register)
data=[];
for Register =1:Max_Register
    [G1,G2,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Validation');
        data{end+1}.graph1.nodes=G1.Nodes;
        data{end}.graph2.nodes=G2.Nodes;
        data{end}.graph1.edges=G1.Edges;
        data{end}.graph2.edges=G2.Edges;
        data{end}.labelling=f;
        lll=data{end}.labelling~=-1;
        data{end}.labelling=data{end}.labelling.*lll;
end
end