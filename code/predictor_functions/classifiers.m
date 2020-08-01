function output = classifiers(data,N)

output.n_p = sum(data.PU.entire_Y_true);
output.n_l = sum(data.PU.entire_Y_PU);


%
%Non-weighted Logistic Regression with CV
% [output.Pred{1}] = n_fold_CV_WLR(data.PU.entire_X, data.PU.entire_Y_PU, N, 0, data);
% 
% %
% % % weighted Logistic Regression with CV
% [output.Pred{2}] = n_fold_CV_WLR(data.PU.entire_X, data.PU.entire_Y_PU, N, 1, data);

%kNN by CV, k = 1
n2 = 10;
opts_knn.k = [1]'; %no. of nearest neighbours
output.Pred{3} = train_CV_knn( data, n2, opts_knn);

%kNN by CV, k = 5
n2 = 10;
opts_knn.k = [5]'; %no. of nearest neighbours
output.Pred{4} = train_CV_knn( data, n2, opts_knn);

%kNN by CV, k = 25
n2 = 10;
opts_knn.k = [25]'; %no. of nearest neighbours
output.Pred{5} = train_CV_knn( data, n2, opts_knn);

%Linear SVM by CV; n = 1
n2 = 10;
info_l.kernel = 1;
info_l.parameter_vector = [1]';
info_l.pos_weight = 1;
info_l.SVMlightpath = './predictor_functions/svm_code/svm_light'

output.Pred{6} = train_CV_svm( data, n2, info_l);

%Linear SVM by CV; n = 2
n2 = 10;
info_l.kernel = 1;
info_l.parameter_vector = [2]';
info_l.pos_weight = 1;
info_l.SVMlightpath = './predictor_functions/svm_code/svm_light'

output.Pred{7} = train_CV_svm( data, n2, info_l);

% %Linear SVM by CV; n = 3
% n2 = 10;
% info_l.kernel = 1;
% info_l.parameter_vector = [3]';
% info_l.pos_weight = 1;
% info_l.SVMlightpath = './predictor_functions/svm_code/svm_light'
% 
% output.Pred{8} = train_CV_svm( data, n2, info_l);

% %Gaussian SVM by CV;sigm = 10^(-4)
% n2 = 10;
% info_g.kernel = 2;
% info_g.parameter_vector = [10^(-4)]';
% info_g.pos_weight = 1;
% info_g.SVMlightpath = './predictor_functions/svm_code/svm_light'
% 
% output.Pred{9} = train_CV_svm( data, n2, info_g);

% %Gaussian SVM by CV;sigm = 10^(-3)
% n2 = 10;
% info_g.kernel = 2;
% info_g.parameter_vector = [10^(-3)]';
% info_g.pos_weight = 1;
% info_g.SVMlightpath = './predictor_functions/svm_code/svm_light'
% 
% output.Pred{10} = train_CV_svm( data, n2, info_g);

%Gaussian SVM by CV;sigm = 10^(-2)
n2 = 10;
info_g.kernel = 2;
info_g.parameter_vector = [10^(-2)]';
info_g.pos_weight = 1;
info_g.SVMlightpath = './predictor_functions/svm_code/svm_light'

output.Pred{11} = train_CV_svm( data, n2, info_g);

% %Gaussian SVM by CV;sigm = (1/10)
% n2 = 10;
% info_g.kernel = 2;
% info_g.parameter_vector = [1/10]';
% info_g.pos_weight = 1;
% info_g.SVMlightpath = './predictor_functions/svm_code/svm_light'
% 
% output.Pred{12}= train_CV_svm( data, n2, info_g);

%Gaussian SVM by CV;sigm = 1
n2 = 10;
info_g.kernel = 2;
info_g.parameter_vector = [1]';
info_g.pos_weight = 1;
info_g.SVMlightpath = './predictor_functions/svm_code/svm_light'

output.Pred{13} = train_CV_svm( data, n2, info_g);


% %Gaussian SVM by CV;sigm = 10
% n2 = 10;
% info_g.kernel = 2;
% info_g.parameter_vector = [10]';
% info_g.pos_weight = 1;
% info_g.SVMlightpath = './predictor_functions/svm_code/svm_light'
% 
% output.Pred{14} = train_CV_svm( data, n2, info_g);

%Gaussian SVM by CV;sigm = 100
n2 = 10;
info_g.kernel = 2;
info_g.parameter_vector = [100]';
info_g.pos_weight = 1;
info_g.SVMlightpath = './predictor_functions/svm_code/svm_light'

output.Pred{15} = train_CV_svm( data, n2, info_g);

%Neural Network by CV, h = 1
n2 = 10;
opts_nn.l = 2; %No. of layers
opts_nn.h = [1]';
opts_nn.epochs =1000;
output.Pred{16} = train_CV_nn( data, n2, opts_nn);

%Neural Network by CV, h = 5
n2 = 10;
opts_nn.l = 2; %No. of layers
opts_nn.h = [5]';
opts_nn.epochs =1000;
output.Pred{17} = train_CV_nn( data, n2, opts_nn);

%Neural Network by CV, h = 25
n2 = 10;
opts_nn.l = 2; %No. of layers
opts_nn.h = [25]';
opts_nn.epochs =1000;
output.Pred{18} = train_CV_nn( data, n2, opts_nn);

%100 Bagged neural networks
%One hidden neuron
%
% Assign parameters
opts.B=100;% 100 neural networks
opts.h=1;  % 1 hidden neuron
opts.l=2; %2 layers
opts.val_frac=0.25; % fraction of training data in the validation set
opts.flag = 1;
opts.epochs = 1000;

output.Pred{19} = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);
output.Pred{19} = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);
output.Pred{19}.AUC_CV_test_mean = output.Pred{19}.auc;        
output.Pred{19}.AUC_CV_test_mean_PN = output.Pred{19}.auc_PN;

%100 Bagged neural networks
%Five hidden neuron
%
% Assign parameters
opts.B=100;% 100 neural networks
opts.h=5;  % 1 hidden neuron
opts.l=2; %2 layers
opts.val_frac=0.25; % fraction of training data in the validation set
opts.flag = 1;
opts.epochs = 1000;

output.Pred{20} = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);
output.Pred{20} = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);
output.Pred{20}.AUC_CV_test_mean = output.Pred{20}.auc;        
output.Pred{20}.AUC_CV_test_mean_PN = output.Pred{20}.auc_PN;

%100 Bagged neural networks
%twenty-five hidden neuron
%
% Assign parameters
opts.B=100;% 100 neural networks
opts.h=25;  % 1 hidden neuron
opts.l=2; %2 layers
opts.val_frac=0.25; % fraction of training data in the validation set
opts.flag = 1;
opts.epochs = 1000;

output.Pred{21} = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);
output.Pred{21} = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);
output.Pred{21}.AUC_CV_test_mean = output.Pred{21}.auc;        
output.Pred{21}.AUC_CV_test_mean_PN = output.Pred{21}.auc_PN;




%RT by n-fold CV
n=10;
[output.RT_nested_CV] = n_fold_CV_RT(data.PU.entire_X, data.PU.entire_Y_PU, N, data);


end
