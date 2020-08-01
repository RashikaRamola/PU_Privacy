function [output] = n_fold_CV_RT(X,Y, n, data)

Y = 1.0 * Y;
B = 1;
%B = how many trees

b = n_fold(size(X, 1), n);
test_labels = zeros(size(X,1),1);

for i = 1 : n
    Xs = X(b{i}, :); % test data
    Xt = X(setdiff(1:size(X, 1), b{i}), :); % train data
    ys = Y(b{i}, :); % test data labels
    yt = Y(setdiff(1:size(Y, 1), b{i}), :); % train data labels
   
    t = fitrtree(Xs, ys);
   
    % Store all t trees for i-th fold
    trees{i} = t;
    
    
    
    p = predict(t, Xs);
    
    
    
    [f_max(i), bacc_max(i), ~] = performance_measures(p, ys);
    
    [~, ~, ~, auc(i)] = perfcurve(ys, p, 1);
    [~,~,~,AUCpr_test(i)] = perfcurve(ys, p,  1, 'xCrit', 'reca', 'yCrit', 'prec');
    

    %Predict on train data
    [~,  p_t] = predict(t, Xt);
    [~, ~, ~, auc_tr(i)] = perfcurve(yt, p_t, 1);

end


output.X = X;
output.Y = Y;

out.auc_CV_test = mean(auc);
out.auc_CV_train = mean(auc_tr);

output.trees = trees;
output.all_aucs = auc;
output.auc_mean = mean(auc);
output.f_max_mean = mean(f_max);
output.bacc_max_mean = mean(bacc_max);
output.AUCpr_test_mean = mean(AUCpr_test);
CI = 100 * std(auc) / sqrt(n);
%fprintf(1, '\n\nThe AUC = %.1f +/- %.1f\n\n\n', 100* mean(auc), 100 * std(auc) / sqrt(n));

return



end