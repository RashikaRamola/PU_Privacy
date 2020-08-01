function out = train_CV_svm(data, n, info)
X = data.PU.entire_X;
Y = data.PU.entire_Y_PU;
Y_PN = data.PU.entire_Y_true;

b2 = n_fold(size(X, 1), n);

for par = 1:size(info.parameter_vector)
    %Assign Parameters
    
    info.parameter = info.parameter_vector(par);
    
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
        
        %Use best_param to train Xt and test on Xs
        
        bigtrain = [Xt yt];
        bigtest = Xs;
        [p] = SVMprediction (bigtrain, bigtest, info);
        
        
        [~, ~, ~, auc(par, j)] = perfcurve(ys, p, 1);
        
        [~, ~, ~, auc_PN(par, j)] = perfcurve(ys_PN, p, 1);
        
        %Predict on train data
        [p_t] = SVMprediction (bigtrain, Xt, info);
        [~, ~, ~, auc_tr(par, j)] = perfcurve(yt, p_t, 1);
        
    end
end

[~ , best_param_ind] = max(mean(auc'));

best_param = info.parameter_vector(best_param_ind);

out.AUC_CV_test_mean = mean(auc(best_param_ind,:));
out.AUC_CV_test_mean_PN = mean(auc_PN(best_param_ind,:));

out.AUC_CV_tr_mean = mean(auc_tr(best_param_ind,:));

%Use best parameters to train on entire data and make final predictor, and
%then use final predictor to predict on entire training data;
%Normalisation
% normalize training and test sets
[mn, sd, X] = normalize(X, [], []);

%Use final predictor to predict on entire data
info.parameter = info.parameter_vector(best_param_ind);
bigtrain = [X Y];
bigtest = X;
[p] = SVMprediction (bigtrain, bigtest, info);
out.p_train = p;
[~, ~, ~, out.AUC_tr] = perfcurve(Y, p, 1);
[~, ~, ~, out.AUC_tr_PN] = perfcurve(Y_PN,p,  1);

out.pos_in_top = position_in_top_n(p, data);
[out.pos_PN, out.pos_PU, out.top_lab]  = position_in_top_n(p, data);
end