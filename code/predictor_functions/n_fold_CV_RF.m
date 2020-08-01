function [output] = n_fold_CV_RF(X,Y, n, B)

%B = No. of trees

b = n_fold(size(X, 1), n);
test_labels = zeros(size(X,1),1);

for i = 1 : n
    Xs = X(b{i}, :); % test data
    Xt = X(setdiff(1:size(X, 1), b{i}), :); % train data
    ys = Y(b{i}, :); % test data labels
    yt = Y(setdiff(1:size(Y, 1), b{i}), :); % train data labels
    
    %Train a model on training data
    Tbl_train = array2table([Xt, yt]);
    
    Tbl_train.Properties.VariableNames(size(Tbl_train,2)) = {'Y'};
    Mdl{i} = TreeBagger(B,Tbl_train, 'Y', 'Method','regression')
 
    %Predict on test data
    p{i} = predict(Mdl{i}, Xs);
    [f_max(i), bacc_max(i), ~] = performance_measures(p{i}, ys);
    
    [~, ~, ~, auc(i)] = perfcurve(ys, p{i}, 1);
    [~,~,~,AUCpr_test(i)] = perfcurve(ys, p{i},  1, 'xCrit', 'reca', 'yCrit', 'prec');
    test_labels(b{i}) = ys;
    
end


output.Mdl = Mdl;
output.test_indices = b;
output.test_predictions = p;
output.all_aucs = auc;
output.auc_mean = mean(auc)
output.f_max_mean = mean(f_max);
output.bacc_max_mean = mean(bacc_max);
output.AUCpr_test_mean = mean(AUCpr_test);
output.CI = 100 * std(auc) / sqrt(n);



fprintf(1, '\n\nThe AUC = %.1f +/- %.1f\n\n\n', 100* mean(auc), 100 * std(auc) / sqrt(n));    
    
return

    
    
end


    



