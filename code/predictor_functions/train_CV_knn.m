function out = train_CV_knn( data, n, opts)
%shuffle X & Y
idx = randperm(size(data.PU.entire_X,1)) ;
X = data.PU.entire_X(idx,:);
Y = data.PU.entire_Y_PU(idx,:);
Y_PN = data.PU.entire_Y_true(idx,:);

b2 = n_fold(size(X, 1), n);

for par = 1:size(opts.k)
    %Assign Parameters
    
    k = opts.k(par);
    
    for j = 1:n
        Xs = X(b2{j}, :); % test
        Xt = X(setdiff(1:size(X, 1), b2{j}), :); % train data for i-th fold
        ys = Y(b2{j}, :); % test data labels
        yt = Y(setdiff(1:size(Y, 1), b2{j}), :); % train data labels for i-th fold
        
        ys_PN = Y_PN(b2{j}, :); % PN test data labels
        
        %Normalisation
        % normalize training and test sets
        [mn, sd, Xt] = normalize(Xt, [], []);
        [~, ~, Xs] = normalize(Xs, mn, sd);
        
        %Store normalisation parameters
        nrm_param{j}.sd = sd;
        nrm_param{j}.mn = mn;
        
        knn.Mdl = fitcknn(Xt, yt,'NumNeighbors',k);
        [label,  p] = predict(knn.Mdl, Xs);
        [~, ~, ~, auc(par, j)] = perfcurve(ys, p(:,2), 1);
        
        [~, ~, ~, auc_PN(par, j)] = perfcurve(ys_PN, p(:,2), 1);
        
        
        %Predict on train data
        [~,  p_t] = predict(knn.Mdl, Xt);
        [~, ~, ~, auc_tr(par, j)] = perfcurve(yt, p_t(:,2), 1);
        
    end
end

[~ , best_param_ind] = max(mean(auc'));

best_param = opts.k(best_param_ind);

out.AUC_CV_test_mean = mean(auc(best_param_ind,:));
out.AUC_CV_test_mean_PN = mean(auc_PN(best_param_ind,:));
out.AUC_CV_tr_mean = mean(auc_tr(best_param_ind,:));

%Use best parameters to train on entire data
%Normalisation
% normalize training and test sets
[mn, sd, X] = normalize(X, [], []);

%Use best_param to train Xt and test on Xs
knn.Mdl = fitcknn(X, Y,'NumNeighbors',best_param);
[label,  p] = predict(knn.Mdl, X);
[~, ~, ~, out.AUC_tr] = perfcurve(Y, p(:,2), 1);
[~, ~, ~, out.AUC_tr_PN] = perfcurve(Y_PN,p(:,2),  1);

[~,~,~,out.AUC_pr_tr] = perfcurve(Y, p(:, 2),  1, 'xCrit', 'reca', 'yCrit', 'prec');

out.p = p;
data.PU.entire_Y_true = Y_PN;
data.PU.entire_Y_PU = Y;
[out.pos_PN, out.pos_PU, out.top_lab]  = position_in_top_n(p(:,2), data);

end