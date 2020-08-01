
clear; clc;
fileList = dir('../PU_datasets/*.mat');
for i = 1:size(fileList)
    file_name = fileList(i).name;
    file_path = [ '../PU_datasets/', file_name];
    load(file_path)
    
    
    %NOTE: Later Set n_l and n_p for each datset and save with data; ignore for
    %now
    
end

N = 10; % N-fold cross validation

i=1;
n_u = 2000;
n_l = 200;
i=1;
alpha = 0.05 ;
beta = 0.8;
runs = 50;

%Making simulated data
pos = normrnd(1,1, [100000, 10]);
neg = normrnd(-1,1, [100000, 10]);
data.X = vertcat(pos, neg);
data.Y = vertcat(ones(100000,1), zeros(100000,1 ));
n_u = 10000;
n_l = 1000;


for j = 1:runs
    j
 for alpha = [0 0.05 0.25]
     for beta = [1 0.95 0.75]
    output{j,i}.alpha = alpha;
    output{j, i}.beta = beta;
    [data.PU.L, data.PU.U] = make_PU(data, n_l, n_u, beta, alpha);
    data.PU.entire_X = vertcat(data.PU.L.X, data.PU.U.X);
    data.PU.entire_Y_true = vertcat(data.PU.L.Y, data.PU.U.Y);
    data.PU.entire_Y_PU = vertcat(ones(size(data.PU.L.X,1),1), zeros(size(data.PU.U.X,1),1));
    output{j, i}.predictors = predictors(data);
    output{j, i}.CV = all_crossvalidation(data, N);
    output{j, i}.data = data;
    
    i = i+1;
    
    end
 end
 j=j+1
end
save('output7.mat');

%Predict by using predictor obtained from each fold
% score_LR = zeros(size(data.PU.entire_X,1),1);
% for i = 1:N
%     X_transformed = data.PU.entire_X*pca_param{i};
%     score_LR = score_LR + logsig([ones(size(X_transformed, 1), 1) X_transformed] * w_param{i});
% end
% [sorted_score, I] = sort(score_LR);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% for i = 1:size(sorted_score)
%     pos_in_top_n_LR(i) = sum(true_labels(1:i));
% end





%Predict by using predictor obtained from each fold
% score_LR = zeros(size(data.PU.entire_X,1),1);
% for i = 1:N
%     X_transformed = data.PU.entire_X*pca_param{i};
%     score_LR = score_LR + logsig([ones(size(X_transformed, 1), 1) X_transformed] * w_param{i});
% end
% [sorted_score, I] = sort(score_LR);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% for i = 1:size(sorted_score)
%     pos_in_top_n_WLR(i) = sum(true_labels(1:i));
% end



% 
% %Predict using each tree of each of the n-folds
% score_DT = zeros(size(data.PU.entire_X,1),1);
% for i = 1:N
%     for j = 1:B
%         tree = trees_DT{i}{j};
%         score_DT = score_DT + predict(tree, data.PU.entire_X);
%     end
% end
% score_DT = score_DT/(N*B);
% [sorted_score, I] = sort(score_DT);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% for i = 1:size(sorted_score)
%     pos_in_top_n_DT(i) = sum(true_labels(1:i));
% end







% %Predict using all 1000 trees of each of the n-folds
% score_RF = zeros(size(data.PU.entire_X,1),1);
% for i = 1:N
%     for j = 1:B
%         tree = trees_RF{i}{j};
%         score_RF = score_RF + predict(tree, data.PU.entire_X);
%     end
% end
% score_RF = score_RF/(N*B);
% [sorted_score, I] = sort(score_RF);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% for i = 1:size(sorted_score)
%     pos_in_top_n_RF(i) = sum(true_labels(1:i));
% end


% % predictions (cummulative)
%     score_NN1 = zeros(size(data.PU.entire_X, 1), 1);
% 
% %Normalise and then Predict on training data
% for i = 1:opts.B
%     [~, ~, train_nrml] = normalize(data.PU.entire_X, nrm_param{i}.mn, nrm_param{i}.sd);
%    
%     % apply the neural network to traing data
%         p = sim(net{i}, train_nrml');
%         score_NN1 = score_NN1 + p';  % add predictions
% end
% 
% %Top N calculations
% score_NN1 = score_NN1/(opts.B);
% [sorted_score, I] = sort(score_NN1);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% for i = 1:size(sorted_score)
%     pos_in_top_n_NN1(i) = sum(true_labels(1:i));
% end



% 
% % predictions (cummulative)
%     score_NN100 = zeros(size(data.PU.entire_X, 1), 1);
% 
% %Normalise and then Predict on training data
% for i = 1:opts.B
%     [~, ~, train_nrml] = normalize(data.PU.entire_X, nrm_param{i}.mn, nrm_param{i}.sd);
%    
%     % apply the neural network to traing data
%         p = sim(net{i}, train_nrml');
%         score_NN100 = score_NN100 + p';  % add predictions
% end
% 
% %Top N calculations
% score_NN100 = score_NN100/(opts.B);
% [sorted_score, I] = sort(score_NN100);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% for i = 1:size(sorted_score)
%     pos_in_top_n_NN100(i) = sum(true_labels(1:i));
% end




% %Predict by using predictor obtained from each fold
% score_lSVM = zeros(size(data.PU.entire_X,1),1);
% for i = 1:N
%     X_transformed = data.PU.entire_X*pca_param{i};
%     [label, scores]  = predict(SVM{i}.Model, X_transformed);
%     score_lSVM = score_lSVM + scores;
%     positive_SVs(i) = sum(SVM{i}.Model.SupportVectorLabels==1)
% end
% [sorted_score, I] = sort(score_lSVM);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% avg_SVs_revealed = sum(positive_SVs)/N;
% for i = 1:size(sorted_score)
%     pos_in_top_n_lSVM(i) = sum(true_labels(1:i));
%     pos_in_top_n_lSVM_with_SVs(i) = sum(true_labels(1:i)) + avg_SVs_revealed;
% end




% %Predict by using predictor obtained from each fold
% score_kSVM = zeros(size(data.PU.entire_X,1),1);
% for i = 1:N
%     X_transformed = data.PU.entire_X*pca_param{i};
%     [label, scores]  = predict(kSVM{i}.Model, X_transformed);
%     score_kSVM = score_kSVM + scores;
%     positive_SVs(i) = sum(kSVM{i}.Model.SupportVectorLabels==1)
% end
% [sorted_score, I] = sort(score_kSVM);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% avg_SVs_revealed = sum(positive_SVs)/N;
% for i = 1:size(sorted_score)
%     pos_in_top_n_kSVM(i) = sum(true_labels(1:i));
%     pos_in_top_n_kSVM_with_SVs(i) = sum(true_labels(1:i)) + avg_SVs_revealed;
% end




% %Predict by using predictor obtained from each fold
% score_knn1 = zeros(size(data.PU.entire_X,1),1);
% for i = 1:N
%     X_transformed = data.PU.entire_X*pca_param{i};
%     [label, scores]  = predict(knn1{i}.Mdl, X_transformed);
%     score_knn1 = score_knn1 + scores;
%     
% end
% [sorted_score, I] = sort(score_knn1);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% for i = 1:size(sorted_score)
%     pos_in_top_n_knn1(i) = sum(true_labels(1:i));
%     
% end





% %Predict by using predictor obtained from each fold
% score_knn5 = zeros(size(data.PU.entire_X,1),1);
% for i = 1:N
%     X_transformed = data.PU.entire_X*pca_param{i};
%     [label, scores]  = predict(knn5{i}.Mdl, X_transformed);
%     score_knn5 = score_knn5 + scores;
%     
% end
% [sorted_score, I] = sort(score_knn5);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% for i = 1:size(sorted_score)
%     pos_in_top_n_knn5(i) = sum(true_labels(1:i));
%     
% end





% %Predict by using predictor obtained from each fold
% score_knn25 = zeros(size(data.PU.entire_X,1),1);
% for i = 1:N
%     X_transformed = data.PU.entire_X*pca_param{i};
%     [label, scores]  = predict(knn25{i}.Mdl, X_transformed);
%     score_knn25 = score_knn25 + scores;
%     
% end
% [sorted_score, I] = sort(score_knn25);
% true_labels = data.PU.entire_Y_true(I);
% PU_labels = data.PU.entire_Y_true(I);
% for i = 1:size(sorted_score)
%     pos_in_top_n_knn25(i) = sum(true_labels(1:i));
%     
% end


