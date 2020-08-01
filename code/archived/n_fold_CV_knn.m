%function [AUC_test_max, AUC_test, AUC_train] = n_fold_CV_WLR(X,Y, n)
function [output] = n_fold_CV_knn(X,Y, n, k, data)
%X: Features
%Y: Class Variable

%PCA
%[coeff,score,latent,tsquared,explained] = pca(X);
%X_transformed = X*coeff

%sw = 0 => Linear kernel
%sw = 1 => RBF kernel

b = n_fold(size(X, 1), n);
test_labels = zeros(size(X,1),1);


for i = 1 : n
    Xs = X(b{i}, :); % test data
    Xt = X(setdiff(1:size(X, 1), b{i}), :); % train data
    ys = Y(b{i}, :); % test data labels
    yt = Y(setdiff(1:size(Y, 1), b{i}), :); % train data labels
    
    mu = mean(Xt, 1);
    sg = std(Xt, [], 1);
    
    %Calculate z-score only if sigma is non-zero, else leave as it is.
    for j = 1:size(sg,2)
        if (sg(1,j)) ~= 0
            Xt(:,j) = (Xt(:,j)-mu(1,j)/sg(1,j));
            Xs(:,j) = (Xs(:,j)-mu(1,j)/sg(1,j));
        end
    end
    
        
    [Xtt, T] = pca_ret_var_noclass(Xt, 99);
    
    
    output.pca_param{i} = T
    Xst = Xs * T; %Transformed test data
    
    %Xtt = [ones(size(Xtt, 1), 1) Xtt];
    %Xst = [ones(size(Xst, 1), 1) Xst];
    
   
    knn{i}.Mdl = fitcknn(Xtt, yt,'NumNeighbors',k)
    [label,  p(b{i},1:2)] = predict(knn{i}.Mdl, Xst);
    [f_max(i), bacc_max(i), ~] = performance_measures(p(b{i},2), ys);
    
    [~, ~, ~, auc(i)] = perfcurve(ys, p(b{i},2), 1);
    [~,~,~,AUCpr_test(i)] = perfcurve(ys, p(b{i},2),  1, 'xCrit', 'reca', 'yCrit', 'prec');
    test_labels(b{i}) = ys;
    
end
%Select best model and use it to predict on training data
best_ind = select_best_model(auc);
T_best = output.pca_param{best_ind};
X_trans = X*T_best;
knn_best = knn{best_ind}.Mdl;
[~, p_train(:,1:2)] = predict(knn_best, X_trans);
[~, ~, ~, auc_train] = perfcurve(Y, p_train(:,2), 1);
top_pos = position_in_top_n(p_train(:,2), data);

output.X = X;
output.Y = Y;
output.best_ind = best_ind
output.T_best = T_best;
output.knn_best = knn_best;
output.p_train = p_train;
output.auc_train = auc_train;
output.top_pos = top_pos;




output.knn_model = knn;
output.testlabels = test_labels;
output.test_indices = b;
output.test_predictions = p;
output.all_aucs = auc;
output.auc_mean = mean(auc);
output.f_max_mean = mean(f_max);
output.bacc_max_mean = mean(bacc_max);
output.AUCpr_test_mean = mean(AUCpr_test);
output.CI = 100 * std(auc) / sqrt(n);
fprintf(1, '\n\nThe AUC = %.1f +/- %.1f\n\n\n', 100* mean(auc), 100 * std(auc) / sqrt(n));    
    
return

    
    
end


    



