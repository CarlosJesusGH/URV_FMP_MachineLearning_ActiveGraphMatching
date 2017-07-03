function cost = Edit_Cost_Features(AA,BB,A,B,NodeInsDel,ArcInsDel,lab)
% francesc.serratosa@urv.cat
% cost = Edit_Cost(AA,BB,A,B,NodeInsDel,ArcInsDel,lab)
% NA, NB: Matrices that are the attributes on nodes.
% NA(i): N-dimensional attribute of node i in the first graph.
% EA, EB: Adjacency matrices. EA(i,j)=1: There is an edge between node i and j. 0: No edge.
% NO attributes on edges
% NodeInsDel: Cost of deleting or inserting a node
% ArcInsDel: Cost of deleting or inserting an edge
% lab: labelling between graphs.

a=size(AA,1); 
b=size(BB,1);
NumEdgesA=sum(A,2);
NumEdgesB=sum(B,2);
Features_Distance=Compute_Distance_Features(AA,BB);  

nul_b=ones(b,1);% 1: Has to be inserted
cost=0;
% Subtitute and Delete Nodes
for i=1:a
    if(lab(i)>0)
        cost=cost+Features_Distance(i,lab(i));
        nul_b(lab(i))=0; % 0: Not inserted
    end
    if(lab(i)==0)
        cost=cost+NodeInsDel; %Delete Nodes
    end
end
%Insert Nodes
cost=cost+NodeInsDel*sum(nul_b);
% Delete Edges & Insert if nodes substituted
for i=1:a
        for j=1:a
            if((lab(i)>0)&&(lab(j)>0)&&(A(i,j)~=B(lab(i),lab(j)))) 
                    cost=cost+ArcInsDel; % Insert edge if nodes substituted
            end
            if(lab(i)==0)
                cost=cost+ArcInsDel*A(i,j);
            end
            if((lab(i)>0)&&(lab(j)==0))
                cost=cost+ArcInsDel*A(i,j);
            end
        end
end

%Insert Edges
cost=cost+ArcInsDel*sum(nul_b.*NumEdgesB);
% Insert Edges from labelled in B to non-labelled in B
for i=1:b
    if((nul_b(i)==0)) % Not inserted
        for j=1:b
            if((nul_b(j)==1)) % Inserted
                if(B(i,j)==1)
                    cost=cost+ArcInsDel;
                end
            end
        end
    end
end
end