function output = crossvalidation(data, N)
% Non-weighted Logistic Regression
[output.LR] = n_fold_CV_WLR(data.PU.entire_X, data.PU.entire_Y_PU, N, 0, data);


% Weighted Logistic Regression
[output.WLR] = n_fold_CV_WLR(data.PU.entire_X, data.PU.entire_Y_PU, N, 1, data);

%Decision Tree
B = 1; %One Tree
 
[output.DT]  = n_fold_CV_RF(data.PU.entire_X, data.PU.entire_Y_PU, N, B, data);

%Random Forest
B = 1000; %Thousand Trees

[output.RF]  = n_fold_CV_RF(data.PU.entire_X, data.PU.entire_Y_PU, N, B, data);



%One Neural Network

% Assign parameters
opts.B=1;% 1 neural networks
opts.h=5;  % 5 hidden neurons
opts.l=2; %2 layers
opts.val_frac=0.25; % fraction of training data in the validation set
opts.flag = 1;
opts.epochs = 1000;

[output.NN1] = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);


%100 bagged Neural Networks

% Assign parameters
opts.B=100;% 100 bagged neural networks
opts.h=5;  % 5 hidden neurons
opts.l=2; %2 layers
opts.val_frac=0.25; % fraction of training data in the validation set
opts.flag = 1;
opts.epochs = 1000;

[output.NN100] = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);

%Linear kernel SVM
sw = 0; %switch for linear kernel

[output.lSVM] = n_fold_CV_SVM(data.PU.entire_X, data.PU.entire_Y_PU, N, 0, data);

%RBF Kernel SVM

sw = 1; %switch for gaussian kernel

[output.rbfSVM] = n_fold_CV_SVM(data.PU.entire_X, data.PU.entire_Y_PU, N, sw, data);

% kNN; k = 1
k=1;
[output.knn1] = n_fold_CV_knn(data.PU.entire_X, data.PU.entire_Y_PU, N, k, data);

% kNN; k = 5;
k=5;
[output.knn5] = n_fold_CV_knn(data.PU.entire_X, data.PU.entire_Y_PU, N, k, data);


% kNN; k = 25
k=25;
[output.knn25] = n_fold_CV_knn(data.PU.entire_X, data.PU.entire_Y_PU, N, k, data);


end