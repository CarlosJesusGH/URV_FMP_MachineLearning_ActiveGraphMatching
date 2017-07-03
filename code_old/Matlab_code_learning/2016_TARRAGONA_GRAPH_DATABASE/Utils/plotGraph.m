function plotGraph(Graph, Image)
    figure;

    if exist('Image', 'var')
        imshow(Image);
    end
    
    hold on;
    
    P1(1,:) = Graph.Nodes(:,1);
    P1(2,:) = Graph.Nodes(:,2);
    
  
    
    E1 = Graph.Edges;
    
    % plotting edges of the graph
    for i = 1:length(E1)
        for j = 1:length(E1)
            if (i ~= j)
                if E1(i,j) == 1
                    X = [P1(1,i); P1(1,j)];
                    Y = [P1(2,i); P1(2,j)];
                    line(X,Y,'LineWidth',2);
                end
            end
        end
    end
    
    %plotting nodes of the graph
      plot(P1(1,:),P1(2,:),'sk', 'MarkerFaceColor','r');
end