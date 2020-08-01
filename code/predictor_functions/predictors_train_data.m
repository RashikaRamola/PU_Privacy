function output = predictors(data)

output.n_p = sum(data.PU.entire_Y_true);
output.n_l = sum(data.PU.entire_Y_PU);



%Train & Predict LR
c = ones(size(data.PU.entire_X,1),1);
w = weighted_logreg(data.PU.entire_X, data.PU.entire_Y_PU, c);
output.w_LR = w;
scores_LR = logsig([ones(size(data.PU.entire_X, 1), 1) data.PU.entire_X] * w);
output.scores_LR = scores_LR;
output.pos_LR = position_in_top_n(scores_LR, data);
[~, ~, ~, output.auc_LR] = perfcurve(data.PU.entire_Y_PU, scores_LR, 1);


%Train & Predict WLR

c1 = 1/sum(data.PU.entire_Y_PU);
c0 = 1/(length(data.PU.entire_Y_PU)-sum(data.PU.entire_Y_PU));
q = find(data.PU.entire_Y_PU == 1);
costs(q, 1) = c1;
q = find(data.PU.entire_Y_PU == 0);
costs(q, 1) = c0;

w_wlr = weighted_logreg(data.PU.entire_X, data.PU.entire_Y_PU, costs);
output.w_WLR = w_wlr;
scores_WLR = logsig([ones(size(data.PU.entire_X, 1), 1) data.PU.entire_X] * w_wlr);
output.scores_WLR = scores_WLR;
output.pos_WLR = position_in_top_n(scores_WLR, data);
[~, ~, ~, output.auc_WLR] = perfcurve(data.PU.entire_Y_PU, scores_WLR, 1);



%Neural Network by CV, h = 1, 5 or 25
n2 = 10;
opts_nn.l = 2; %No. of layers
opts_nn.h = [1 5 25]';
opts_nn.epochs =5000;
output.nn_CV = train_CV_nn( data, n2, opts_nn);

%kNN by CV, k = 1, 5 or 25
n2 = 10;
opts_knn.k = [1 5 25]'; %no. of nearest neighbours
output.knn_CV = train_CV_knn( data, n2, opts_knn);


%Linear SVM by CV; n = 1, 2 or 3
n2 = 10;
info_l.kernel = 1;
info_l.parameter_vector = [1 2 3]';
info_l.pos_weight = 1;
info_l.SVMlightpath = './predictor_functions/svm_code/svm_light'

output.SVM_l_CV = train_CV_svm( data, n2, info_l);


%Gaussian SVM by CV; sigm = 10^(-4), 10^(-3), 10^(-2), (1/10), 1, 10, 100
n2 = 10;

info_g.kernel = 2;
info_g.parameter_vector = [10^(-4) 10^(-3) 10^(-2) (1/10) 1 10 100]';
info_g.pos_weight = 1;
info_g.SVMlightpath = './predictor_functions/svm_code/svm_light'

output.SVM_g_CV = train_CV_svm( data, n2, info_g);


% RT by training on entire train data, and then predicting on entire train
% data
t = fitrtree(data.PU.entire_X, data.PU.entire_Y_PU);
p = predict(t, data.PU.entire_X);
output.pos_RT = position_in_top_n(p, data);
[~, ~, ~, output.auc_RT] = perfcurve(data.PU.entire_Y_PU, p, 1);


% Random Forest by training on entire train data, and then predicting on entire train
% data
B=100;
Tbl_train = array2table([data.PU.entire_X, data.PU.entire_Y_PU]);
Tbl_train.Properties.VariableNames(size(Tbl_train,2)) = {'Y'};

RFMdl = TreeBagger(B,Tbl_train, 'Y', 'Method','regression')

%Predict
p = predict(RFMdl, data.PU.entire_X);
output.RF_p = p;
output.pos_RF = position_in_top_n(p, data);
[~, ~, ~, output.auc_RF] = perfcurve(data.PU.entire_Y_PU, p, 1);


end
