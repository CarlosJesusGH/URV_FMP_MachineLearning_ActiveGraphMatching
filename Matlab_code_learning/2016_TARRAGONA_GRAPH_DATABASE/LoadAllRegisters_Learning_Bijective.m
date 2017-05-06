function data =  LoadAllRegisters_Learning_Bijective(Database,Max_Register)
data=[];
for Register =1:Max_Register
    [G1,G2,f,C,Index_G,Index_Gprime]=LoadRegister(Database,Register,'Learning');
        data{end+1}.graph1.nodes=G1.Nodes;
        data{end}.graph2.nodes=G2.Nodes;
        data{end}.graph1.edges=G1.Edges;
        data{end}.graph2.edges=G2.Edges;
        data{end}.labelling=f;
end
for k=1:length(Max_Register)
data{k}.vector_substrac=[];
data{k}.new_labelling=[];
substract=0;
for i=1:length(data{end}.labelling)
%     s=DB_Learning{end}.graph2.nodes(i);
    value=find( data{k}.labelling(i)==i);
    if value== true;
        data{k}.vector_substrac(i)=substract;
    else
        substract=substract+1;
        data{k}.vector_substrac(i)=substract;
    end 

  data{k}.new_labelling(i)=data{k}.labelling(i)-data{k}.vector_substrac(i);
end   

  for yy=1:length(data{k}.new_labelling)
    s=data{k}.new_labelling(yy);
    if s<0;
       data{k}.graph1.nodes(yy,:)=[];
       data{k}.new_labelling(yy)=[]; 
       data{k}.graph1.edges(yy,:)=[];
       data{k}.graph1.edges(:,yy)=[];    
   end      
  end
 for r=1:length(data{k}.new_labelling)     
    uu=find (data{k}.new_labelling ==r);
    ss=isempty(uu);
   if ss==1;
       data{k}.graph2.nodes(r,:)=[];
       data{k}.graph2.edges(r,:)=[];
       data{k}.graph2.edges(:,r)=[]; 
   end 
 end 
end

end