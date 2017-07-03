
function mat_lab = lab_to_mat(lab)
mat_lab = zeros(length(lab));
for i = 1:length(lab)
    mat_lab(i,lab(i)) = 1;
end
end
