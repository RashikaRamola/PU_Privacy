function [output] = n_fold_CV_RF(X,Y, n, B, data)

Y = 1.0 * Y;

%B = how many trees

b = n_fold(size(X, 1), n);
test_labels = zeros(size(X,1),1);

for i = 1 : n
    Xs = X(b{i}, :); % training data
    Xt = X(setdiff(1:size(X, 1), b{i}), :); % test data
    ys = Y(b{i}, :); % training data labels
    yt = Y(setdiff(1:size(Y, 1), b{i}), :); % test data labels
    
    for bb = 1 : B
        % sample with replacement
        q = ceil(rand(1, size(Xs, 1)) * size(Xs, 1));
        
        % form a bootstrapped training set
        Xb = Xs(q, :);
        yb = ys(q, 1);
        
        % train b-th decision tree
        t{bb} = fitrtree(Xb, yb);
    end
    % Store all t trees for i-th fold
    trees{i} = t;
    
    p = zeros(size(Xt, 1), 1);
    for bb = 1 : length(t)
        p = p + predict(t{bb}, Xt);
    end
    p = p ./ length(t);
    
    [f_max(i), bacc_max(i), ~] = performance_measures(p, yt);
    
    [~, ~, ~, auc(i)] = perfcurve(yt, p, 1);
    [~,~,~,AUCpr_test(i)] = perfcurve(yt, p,  1, 'xCrit', 'reca', 'yCrit', 'prec');
    test_labels(b{i}) = ys;
end

%Select best model and use it to predict on training data
best_ind = select_best_model(auc);
best_trees = trees{best_ind};
p_train = zeros(size(X, 1), 1);
for bb = 1 : length(best_trees)
    p_train = p_train + predict(best_trees{bb}, X);
end
p_train = p_train ./ length(best_trees);
[~, ~, ~, auc_train] = perfcurve(Y, p_train, 1);
top_pos = position_in_top_n(p_train, data);

output.X = X;
output.Y = Y;
output.best_ind = best_ind;
output.best_trees = best_trees;
output.p_train = p_train;
output.auc_train = auc_train;
output.top_pos = top_pos;


output.testlabels = test_labels;
output.trees = trees;
output.test_indices = b;
output.test_predictions = p;
output.all_aucs = auc;
output.auc_mean = mean(auc);
output.f_max_mean = mean(f_max);
output.bacc_max_mean = mean(bacc_max);
output.AUCpr_test_mean = mean(AUCpr_test);
CI = 100 * std(auc) / sqrt(n);
fprintf(1, '\n\nThe AUC = %.1f +/- %.1f\n\n\n', 100* mean(auc), 100 * std(auc) / sqrt(n));

return



end