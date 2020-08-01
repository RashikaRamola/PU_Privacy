function pos = position_in_top_n(score, data)

[sorted_score, I] = sort(score, 'descend');

true_labels = data.PU.entire_Y_true(I);
PU_labels = data.PU.entire_Y_true(I);
for i = 1:size(sorted_score)
    pos(i) = sum(true_labels(1:i));
end
end