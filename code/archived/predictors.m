function output = predictors(data)

output.n_p = sum(data.PU.entire_Y_true);
output.n_l = sum(data.PU.entire_Y_PU);



%Train & Predict LR
c = ones(size(data.PU.entire_X,1),1);
w = weighted_logreg(data.PU.entire_X, data.PU.entire_Y_PU, c);
scores_LR = logsig([ones(size(data.PU.entire_X, 1), 1) data.PU.entire_X] * w);
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
scores_WLR = logsig([ones(size(data.PU.entire_X, 1), 1) data.PU.entire_X] * w_wlr);
output.pos_WLR = position_in_top_n(scores_WLR, data);
[~, ~, ~, output.auc_WLR] = perfcurve(data.PU.entire_Y_PU, scores_WLR, 1);


%Train & Predict DT
t = fitrtree(data.PU.entire_X,  data.PU.entire_Y_PU);
scores_DT = predict(t, data.PU.entire_X);
output.pos_DT = position_in_top_n(scores_DT, data);
[~, ~, ~, output.auc_DT] = perfcurve(data.PU.entire_Y_PU, scores_DT, 1);

%Train & Predict RF
scores_RF = zeros(size(data.PU.entire_Y_PU,1),1);
for i = 1:1000
   t = fitrtree(data.PU.entire_X,  data.PU.entire_Y_PU); 
   scores_RF = scores_RF + predict(t, data.PU.entire_X);
end
output.pos_RF = position_in_top_n(scores_RF, data);
[~, ~, ~, output.auc_RF] = perfcurve(data.PU.entire_Y_PU, scores_RF, 1);


%1 neural network
%One Neural Network

% Assign parameters
    opts.B=1;% 1 neural networks
    opts.h=5;  % 5 hidden neurons
    opts.l=2; %2 layers
    opts.val_frac=0.25; % fraction of training data in the validation set
    opts.flag = 1;
    opts.epochs = 1000;

[output_NN1] = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);

% predictions (cummulative)
    scores_NN1 = zeros(size(data.PU.entire_X, 1), 1);

%Normalise and then Predict on training data
for i = 1:opts.B
    [~, ~, train_nrml] = normalize(data.PU.entire_X, output_NN1.nrm_param{i}.mn, output_NN1.nrm_param{i}.sd);
   
    % apply the neural network to traing data
        p = sim(output_NN1.net{i}, train_nrml');
        scores_NN1 = scores_NN1 + p';  % add predictions
end

output.pos_NN1 = position_in_top_n(scores_NN1, data);
[~, ~, ~, output.auc_NN1] = perfcurve(data.PU.entire_Y_PU, scores_NN1,1);



%100 bagged Neural Networks

% Assign parameters
    opts.B=100;% 100 bagged neural networks
    opts.h=5;  % 5 hidden neurons
    opts.l=2; %2 layers
    opts.val_frac=0.25; % fraction of training data in the validation set
    opts.flag = 1;
    opts.epochs = 1000;

[output_NN100] = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);

% predictions (cummulative)
    scores_NN100 = zeros(size(data.PU.entire_X, 1), 1);

%Normalise and then Predict on training data
for i = 1:opts.B
    [~, ~, train_nrml] = normalize(data.PU.entire_X, output_NN100.nrm_param{i}.mn, output_NN100.nrm_param{i}.sd);
   
    % apply the neural network to traing data
        p = sim(output_NN100.net{i}, train_nrml');
        scores_NN100 = scores_NN100 + p';  % add predictions
end

%Top N calculations
output.pos_NN100 = position_in_top_n(scores_NN100, data);
[~, ~, ~, output.auc_NN100] = perfcurve(data.PU.entire_Y_PU, scores_NN100,1);





%Linear kernel SVM
SVM_linear.Model = fitcsvm(data.PU.entire_X, data.PU.entire_Y_PU);
[label,  scores_SVM_linear(:,1:2)] = predict(SVM_linear.Model, data.PU.entire_X);
output.pos_SVM_linear = position_in_top_n(scores_SVM_linear(:,2), data);
[~, ~, ~, output.auc_SVM_l] = perfcurve(data.PU.entire_Y_PU, scores_SVM_linear(:,2),1);

%RBF kernel SVM
SVM_rbf.Model = fitcsvm(data.PU.entire_X, data.PU.entire_Y_PU, 'KernelFunction','rbf');
[label,  scores_SVM_rbf(:,1:2)] = predict(SVM_rbf.Model, data.PU.entire_X);
output.pos_SVM_rbf = position_in_top_n(scores_SVM_rbf(:,2), data);
[~, ~, ~, output.auc_SVM_rbf] = perfcurve(data.PU.entire_Y_PU, scores_SVM_rbf(:,2),1);

%Train & Predict kNN - 1 neighbour
k=1;
knn1 = fitcknn(data.PU.entire_X, data.PU.entire_Y_PU,'NumNeighbors',k);
[label,  scores_knn1(:,1:2)] = predict(knn1, data.PU.entire_X);
output.pos_knn1 = position_in_top_n(scores_knn1(:,2), data);
[~, ~, ~, output.auc_knn1] = perfcurve(data.PU.entire_Y_PU, scores_knn1(:,2),1);

%Train & Predict kNN - 5 neighbour
k=5;
knn5 = fitcknn(data.PU.entire_X, data.PU.entire_Y_PU,'NumNeighbors',k);
[label,  scores_knn5(:,1:2)] = predict(knn5, data.PU.entire_X);
output.pos_knn5 = position_in_top_n(scores_knn5(:,2), data);
[~, ~, ~, output.auc_knn5] = perfcurve(data.PU.entire_Y_PU, scores_knn5(:,2),1);

%Train & Predict kNN - 25 neighbour
k=25;
knn25 = fitcknn(data.PU.entire_X, data.PU.entire_Y_PU,'NumNeighbors',k);
[label,  scores_knn25(:,1:2)] = predict(knn25, data.PU.entire_X);
output.pos_knn25 = position_in_top_n(scores_knn25(:,2), data);
[~, ~, ~, output.auc_knn25] = perfcurve(data.PU.entire_Y_PU, scores_knn25(:,2),1);


end
