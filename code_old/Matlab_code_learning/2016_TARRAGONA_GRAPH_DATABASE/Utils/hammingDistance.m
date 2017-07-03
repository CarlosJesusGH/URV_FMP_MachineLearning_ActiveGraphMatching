function HD = hammingDistance(f1,f2)

% carlosfrancisco.moreno@estudiants.urv.cat

% This function obtains the Hamming Distance between two 1xn
% correspondences WITHOUT considering mappings from outlier elements from
% the first set to any type element of the second set.
% Therefore, these input correspondences f1 and f2 must be bijective 
% functions (no element can be mapped twice) and bijective between them 
% (the first column must be equal for both).

% Otherwise, the method may deliver a false hamming distance.

%% Hamming Distance Calculation
HD=0;

if size(f1,2)~=size(f2,2)
    error('Error. Input size missmatch.')
else
    for i=1:size(f1,2)
        if f1(1,i)~=f2(1,i)
            HD=HD+1;
        else
        end
    end
end