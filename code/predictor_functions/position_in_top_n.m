function [pos_PN, pos_PU, top_lab] = position_in_top_n(score, data)

[sorted_score, I] = sort(score, 'descend');

true_labels = data.PU.entire_Y_true(I);
PU_labels = data.PU.entire_Y_PU(I);
for i = 1:size(sorted_score)
    pos_PN(i) = sum(true_labels(1:i));
    pos_PU(i) = sum(PU_labels(1:i) & true_labels(1:i) );
    top_lab(i) = sum(PU_labels(1:i));
    
end

end