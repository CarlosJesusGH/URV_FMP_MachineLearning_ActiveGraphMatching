function [distance,lab]=ICP_BP(A,B,InsDel)
% A and B are three dimensional point clouds
[R,T]=icp(A',B');
BP=R*B'+repmat(T,1,size(B',2));
[distance,lab]=BP_Points_Centrality_h(A,BP',InsDel);
end
