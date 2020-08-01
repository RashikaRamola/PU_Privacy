    function output = crossvalidation(data, N)
    % Non-weighted Logistic Regression
    [output.LR] = n_fold_CV_WLR(data.PU.entire_X, data.PU.entire_Y_PU, N, 0, data);


    % Weighted Logistic Regression
    [output.WLR] = n_fold_CV_WLR(data.PU.entire_X, data.PU.entire_Y_PU, N, 1, data);

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

    [output.NNh1] = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);

    % predictions (cumulative)
    scores_NNh1 = zeros(size(data.PU.entire_X, 1), 1);

    %Normalise and then Predict on training data
    for i = 1:opts.B
        [~, ~, train_nrml] = normalize(data.PU.entire_X, output.NNh1.nrm_param{i}.mn, output.NNh1.nrm_param{i}.sd);

        % apply the neural network to traing data
        p = sim(output.NNh1.net{i}, train_nrml');
        scores_NNh1 = scores_NNh1 + p';  % add predictions
    end

    output.NNh1.pos_NN1 = position_in_top_n(scores_NNh1, data);
    [~, ~, ~, output.NNh1.auc_NN1] = perfcurve(data.PU.entire_Y_PU, scores_NNh1,1);

    %Five hidden neurons

    % Assign parameters
    opts.B=100;% 1 neural networks
    opts.h=5;  % 5 hidden neurons
    opts.l=2; %2 layers
    opts.val_frac=0.25; % fraction of training data in the validation set
    opts.flag = 1;
    opts.epochs = 1000;

    [output.NNh5] = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);


    % predictions (cummulative)
    scores_NNh5 = zeros(size(data.PU.entire_X, 1), 1);

    %Normalise and then Predict on training data
    for i = 1:opts.B
        [~, ~, train_nrml] = normalize(data.PU.entire_X, output.NNh5.nrm_param{i}.mn, output.NNh5.nrm_param{i}.sd);

        % apply the neural network to traing data
        p = sim(output.NNh5.net{i}, train_nrml');
        scores_NNh5 = scores_NNh5 + p';  % add predictions
    end
    output.NNh5.pos_NN5.scores = scores_NNh5;
    output.NNh5.pos_NN5 = position_in_top_n(scores_NNh5, data);
    [~, ~, ~, output.NNh5.auc_NN5] = perfcurve(data.PU.entire_Y_PU, scores_NNh5,1);


    %Twenty-five hidden neurons

    % Assign parameters
    opts.B=100;% 100 bagged neural networks
    opts.h=25;  % 5 hidden neurons
    opts.l=2; %2 layers
    opts.val_frac=0.25; % fraction of training data in the validation set
    opts.flag = 1;
    opts.epochs = 1000;

    [output.NNh25] = transform_nn(data.PU.U.X,data.PU.L.X, opts, data);

    % predictions (cummulative)
    scores_NNh25 = zeros(size(data.PU.entire_X, 1), 1);

    %Normalise and then Predict on training data
    for i = 1:opts.B
        [~, ~, train_nrml] = normalize(data.PU.entire_X, output.NNh25.nrm_param{i}.mn, output.NNh25.nrm_param{i}.sd);

        % apply the neural network to traing data
        p = sim(output.NNh25.net{i}, train_nrml');
        scores_NNh25 = scores_NNh25 + p';  % add predictions
    end

    output.NNh25.pos_NN25 = position_in_top_n(scores_NNh25, data);
    [~, ~, ~, output.NNh25.auc_NN25] = perfcurve(data.PU.entire_Y_PU, scores_NNh25,1);




    %kNN by CV, k = 1, 5 or 25
    n1 = 10; n2 = 10;
    opts.k = [1 5 25]'; %no. of nearest neighbours
    output.knn_nested_CV = nested_CV_knn(data.PU.entire_X , data.PU.entire_Y_PU, n1, n2, opts);

    %Neural Network by CV, h = 1, 5 or 25
    n1 = 10; n2 = 10;
    opts.l = 2; %No. of layers
    opts.h = [1 5 25]';
    opts.epochs =1000;
    output.nn_nested_CV = nested_CV_NN(data.PU.entire_X , data.PU.entire_Y_PU, n1, n2, opts);

    %Linear SVM by nested CV, h = 1, 5 or 25
    n1 = 10; n2 = 10;
    info_l.kernel = 1;
    info_l.parameter_vector = [1 2 3]';
    info_l.pos_weight = 1;
    info_l.SVMlightpath = './predictor_functions/svm_code/svm_light';
    output.svm_l_nested_CV = nested_CV_svm(data.PU.entire_X , data.PU.entire_Y_PU, n1, n2, info_l);

    %Gaussian SVM by CV ;Sigma in [10^(-4) 10^(-3) 10^(-2) (1/10) 1 10 100]';
    n1 = 10; n2 = 10;
    info_g.kernel = 2;
    info_g.parameter_vector = [10^(-4) 10^(-3) 10^(-2) (1/10) 1 10 100]';
    info_g.pos_weight = 1;
    info_g.SVMlightpath = './predictor_functions/svm_code/svm_light';
    output.svm_g_nested_CV = nested_CV_svm(data.PU.entire_X , data.PU.entire_Y_PU, n1, n2, info_g);

    %RT by n-fold CV
    n=10;
   [output.RT_nested_CV] = n_fold_CV_RT(data.PU.entire_X, data.PU.entire_Y_PU, N, data);

    %Ensemble of RTs
    B=100;
    [output.ensemble_RT] =  ensemble_RT( data.PU.entire_X, data.PU.entire_Y_PU, B, data)


    %Random forests of Regression Trees
    B=100;
    n=10;
    [output.RandomForest] = n_fold_CV_RF(data.PU.entire_X, data.PU.entire_Y_PU, n, B);

        end