%function [AUC_test_max, AUC_test, AUC_train] = n_fold_CV_WLR(X,Y, n)
function [output] = n_fold_CV_WLR(X,Y, n, sw, data)
%X: Features
%Y: Class Variable

%PCA
%[coeff,score,latent,tsquared,explained] = pca(X);
%X_transformed = X*coeff

%sw = 0 => Non-weighted LR;
%sw = 1 => Weighted LR

b = n_fold(size(X, 1), n);
test_labels = zeros(size(X,1),1);
Y_PN = data.PU.entire_Y_true;


for i = 1 : n
    Xs = X(b{i}, :); % test data
    Xt = X(setdiff(1:size(X, 1), b{i}), :); % train data
    ys = Y(b{i}, :); % test data labels
    yt = Y(setdiff(1:size(Y, 1), b{i}), :); % train data labels
    
    ys_PN = Y_PN(b{i}, :); % PN test data labels
    
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
    
    
    output.pca_param{i} = T;
    Xst = Xs * T; %Transformed test data
    
    %Xtt = [ones(size(Xtt, 1), 1) Xtt];
    %Xst = [ones(size(Xst, 1), 1) Xst];
    
    if sw == 1
        c1 = 1/sum(yt);
        c0 = 1/(length(yt)-sum(yt));
        q = find(yt == 1);
        costs(q, 1) = c1;
        q = find(yt == 0);
        costs(q, 1) = c0;
        
    elseif sw == 0
        costs = ones(size(Xtt, 1), 1);
    end
    
    w = weighted_logreg(Xtt, yt, costs);
    output.w_param{i} = w;
    p(b{i}, 1) = logsig([ones(size(Xst, 1), 1) Xst] * w);
    [f_max(i), bacc_max(i), ~] = performance_measures(p(b{i}), ys);
    
    [~, ~, ~, auc(i)] = perfcurve(ys, p(b{i}), 1);
    [~, ~, ~, auc_PN(i)] = perfcurve(ys_PN, p(b{i}), 1);
    [~,~,~,AUCpr_test(i)] = perfcurve(ys, p(b{i}),  1, 'xCrit', 'reca', 'yCrit', 'prec');
    test_labels(b{i}) = ys;
    
    %Predict on train data also
    p_t = logsig([ones(size(Xtt, 1), 1) Xtt] * w);
    
    [~, ~, ~, auc_tr(i)] = perfcurve(yt, p_t,1);
    
    [~,~,~,AUCpr_tr(i)] = perfcurve(yt, p_t,  1, 'xCrit', 'reca', 'yCrit', 'prec');
    
    
end


output.X = X;
output.Y = Y;

output.testlabels = test_labels;
output.test_indices = b;
%output.test_predictions = p; %These are not cimulative as per present code
output.AUC_all_CV_test = auc;
output.AUC_CV_test_mean = mean(auc);
output.AUC_CV_test_mean_PN = mean(auc_PN);
output.f_max_CV_test_mean = mean(f_max);
output.bacc_max_CV_test_mean = mean(bacc_max);
output.AUC_CV_pr_test_mean = mean(AUCpr_test);
output.CI = 100 * std(auc) / sqrt(n);

output.AUC_CV_tr_mean = mean(auc_tr);
output.AUC_CV_pr_tr_mean = mean(AUCpr_tr);

%Now training on entire X & Y

if sw == 1
    c1 = 1/sum(Y);
    c0 = 1/(length(Y)-sum(Y));
    q = find(Y == 1);
    costs(q, 1) = c1;
    q = find(Y == 0);
    costs(q, 1) = c0;
    
elseif sw == 0
    costs = ones(size(X, 1), 1);
end
    
w = weighted_logreg(X, Y, costs);
output.w_param{i} = w;
p = logsig([ones(size(X, 1), 1) X] * w);

[~, ~, ~, output.AUC_tr] = perfcurve(Y, p, 1);
[~, ~, ~, output.AUC_tr_PN] = perfcurve(Y_PN, p, 1);
[~,~,~,output.AUC_pr_tr] = perfcurve(Y, p,  1, 'xCrit', 'reca', 'yCrit', 'prec');


[output.pos_PN, output.pos_PU, output.top_lab]  = position_in_top_n(p, data);
%fprintf(1, '\n\nThe AUC = %.1f +/- %.1f\n\n\n', 100* mean(auc), 100 * std(auc) / sqrt(n));

return

end

