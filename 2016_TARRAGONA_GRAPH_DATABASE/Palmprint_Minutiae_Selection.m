function [N1,N2,E1,E2,lab] =  Palmprint_Minutiae_Selection(N1,N2,E1,E2,lab)
vector_substract=zeros(1,size(E1,1));
vector_delete=zeros(1,length(lab));
vector_insertion=zeros(1,size(E2,1));
substract=0;
for i=1:size(N2,1) % Nodes G2
    value=find(lab==i); % Detect if is mapped from one in G1
    if isempty(value)
        if ((N2(i,4)==3)||(N2(i,5)==0))
        % The node G2(i) is an insertion and Low quality or Bifurcation
            substract=substract+1; % Number of nodes deleted in G2
            vector_insertion(i)=1;
        end
    else   % ~isempty(value)
       if ((N1(value,5)==0) || (N1(value,4)==3)||(N2(i,5)==0) || (N2(i,4)==3))
           %   Bifurcation or Low quality mapped to Bifurcation or Low quality.
            substract=substract+1; % Number of nodes deleted in G2
            vector_insertion(i)=1;
            vector_delete(value)=1;
       end
       vector_substract(value)=substract;   % G1(value) is mapped to G2(i)   
    end
end   
    % Low quality or Bifurcation Nodes in G1 are deleted

    lab=lab-vector_substract;
    vector_delete=find(vector_delete==1);
    N1(vector_delete,:)=[];
    lab(vector_delete)=[]; 
    E1(vector_delete,:)=[];
    E1(:,vector_delete)=[];
    
    vector_insertion=find(vector_insertion==1);
    N2(vector_insertion,:)=[];
    E2(vector_insertion,:)=[];
    E2(:,vector_insertion)=[];
    
 %% Delete nodes in G1 that are send to null and (low quality or bifurcation)    

    vector_delete=find((lab(:)==0)&(N1(:,5)==0)|(N1(:,4)==3));    
    N1(vector_delete,:)=[];
    lab(vector_delete)=[]; 
    E1(vector_delete,:)=[];
    E1(:,vector_delete)=[];

% Normalisation    
%     xy1=mean(N1(:,1:2));
%     N1(:,1)=N1(:,1)-xy1(1);
%     N1(:,2)=N1(:,2)-xy1(2);
%     xy2=mean(N2(:,1:2));
%     N2(:,1)=N2(:,1)-xy2(1);
%     N2(:,2)=N2(:,2)-xy2(2);   
end