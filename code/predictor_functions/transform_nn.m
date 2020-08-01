    function [output] =  transform_nn( X0, X1, opts, data)
    %Transforms multivariate data into univariate data.  Uses neural networks
    %to estimate posterior.

    %flag = 1 => First combine labeled and unlabeled and then sample
    %flag = 2 => Sample positives and negatives with replacement separately and
    %then combine
    %flag = 3 => Sample positives and negatives with replacement separately; multiply positives so that the number of positives and negatives is same, and
    %then combine

    %% Assign parameters
    DEF.B=100;% 100 bagged neural networks
    DEF.h=5;  % 5 hidden neurons
    DEF.l=2; %2 layers
    DEF.val_frac=0.25; % fraction of training data in the validation set
    if nargin < 3
        opts=DEF;
    end

    B = opts.B;
    h = opts.h;
    l=opts.l;
    val_frac = opts.val_frac;
    flag = opts.flag;
    epochs = opts.epochs;

    % X = training data, where rows are data points and columns are features
    X=[X0;X1];
    % s = class labels, where 0 means negatives and 1 means positives
    s=[zeros(size(X0,1),1);ones(size(X1,1),1)];
    % predictions (cummulative)
    pX = zeros(size(X, 1), 1);
    
    Y_PN = [data.PU.U.Y', data.PU.L.Y']';

    % number of predictions for each data point
    npX = zeros(size(X, 1), 1);

    % run training and testing
    for b = 1 : B
        %b
        if flag == 1

            %flag = 1 => First combine labeled and unlabeled and then sample


            % sample with replacement from the data
            q = ceil(rand(1, size(X, 1)) * size(X, 1));
            q_c = setdiff(1 : size(X, 1), q); % remaining data points
            Xb = X(q, :);

            % set class labels for training
            yb = s(q, :);

            % indices for the validation set
            qval = randperm(size(Xb, 1));
            val_ind = qval(1 : floor(val_frac * length(qval)));
            tra_ind = setdiff(1 : length(qval), val_ind);


        elseif flag ==2
            %flag = 2 => Sample positives and negatives with replacement separately and then combine


            %Note Index of a positive(labelled) in X is its index in X1+size(X0,1)

            % sample negatives with replacement from negatives
            q_n = ceil(rand(1, size(X0, 1)) * size(X0, 1));
            q_n_c = setdiff(1 : size(X0, 1), q_n); % remaining data points
            Xb_n = X(q_n, :);

            % sample positives with replacement from positives
            q_p = ceil(rand(1, size(X1, 1)) * size(X1, 1));
            q_p_c = setdiff(1 : size(X1, 1), q_p); % remaining data points
            Xb_p = X(q_p + size(X0,1), :);

            %Combine positives and negatives 
            q = [q_n, q_p+size(X0,1)];
            q_c = [q_n_c, q_p_c+size(X0,1)];
            Xb = vertcat(Xb_n, Xb_p);

            % set class labels for training
            yb = s(q, :);

            % indices for the validation set
            qval = randperm(size(Xb, 1));
            val_ind = qval(1 : floor(val_frac * length(qval)));
            tra_ind = setdiff(1 : length(qval), val_ind);

        elseif flag ==3
            %flag = 3 => Sample positives and negatives with replacement separately; multiply positives so that the number of positives and negatives is same, and then combine

            %Note Index of a positive(labelled) in X is its index in X1+size(X0,1)

            %Calculate multiplying factor
            mf = floor(size(X0,1)/size(X1,1));

            % sample negatives with replacement from negatives
            q_n = ceil(rand(1, size(X0, 1)) * size(X0, 1));
            q_n_c = setdiff(1 : size(X0, 1), q_n); % remaining data points
            Xb_n = X(q_n, :);

            % sample positives with replacement from positives
            q_p = ceil(rand(1, size(X1, 1)) * size(X1, 1));
            q_p_c = setdiff(1 : size(X1, 1), q_p); % remaining data points
            Xb_p = X(q_p + size(X0,1), :);

            %Multiply positives by multiplying factor
            q_p = repmat(q_p,1, mf);
            Xb_p = repmat(Xb_p,mf,1);

            %Combine positives and negatives 
            q = [q_n, q_p+size(X0,1)];
            q_c = [q_n_c, q_p_c+size(X0,1)];
            Xb = vertcat(Xb_n, Xb_p);

            % set class labels for training
            yb = s(q, :);

            % indices for the validation set
            qval = randperm(size(Xb, 1));
            val_ind = qval(1 : floor(val_frac * length(qval)));
            tra_ind = setdiff(1 : length(qval), val_ind);


        end


        % normalize training and test sets
        [mn, sd, Xb] = normalize(Xb, [], []);
        [~, ~, Xt] = normalize(X(q_c, :), mn, sd);

         %Store normalisation parameters
        nrm_param{b}.sd = sd;
        nrm_param{b}.mn = mn;

        % initialize and train b-th neural network
        %net{b} = newff(Xb', yb', h, {'tansig', 'tansig'}, 'trainrp');
        net{b} = feedforwardnet([h], 'trainrp');
        %net{b} = feedforwardnet([h], 'trainbr');
        for jj=1:l
            net{b}.layers{jj}.transferFcn = 'tansig';
        end
        %net{b}.layers{1}.transferFcn = 'tansig';
        %net{b}.layers{2}.transferFcn = 'tansig';

        net{b}.trainParam.epochs = epochs;
        net{b}.trainParam.show = NaN;
        net{b}.trainParam.showWindow = false;
        net{b}.trainParam.max_fail = 25;
        net{b}.divideFcn = 'divideind';
        %net{b}.divideParam.trainInd = 1 : size(Xb, 1);
        %net{b}.divideParam.valInd = [];
        net{b}.divideParam.trainInd = tra_ind;
        net{b}.divideParam.valInd = val_ind;
        net{b}.divideParam.testInd = [];
        net{b} = train(net{b}, Xb', yb');

        % apply the neural network to the out-of-bag data
        p = sim(net{b}, Xt');
        pX(q_c) = pX(q_c) + p';  % add predictions
        npX(q_c) = npX(q_c) + 1; % update counts
    end

    % this will produce values for function g, using out-of-bag data
    q = find(npX ~= 0); % just in case some data points haven't been selected
    g(q) = pX(q) ./ npX(q);
    if length(q) < size(X, 1)
        g(setdiff(1 : size(X, 1), q)) = mean(g(q));
    end

    auc = get_auc_ultra(g, s);
    auc_PN = get_auc_ultra(g, Y_PN);

    x_ind=1:size(X0,1);
    x=g(x_ind)';
    x1=g(setdiff(1:size(X,1),x_ind))';
    output.test_scores = g;
    output.test_labels = s;
    output.opts=opts;
    output.x=x;
    output.x1=x1;
    output.auc=auc;
    output.auc_PN=auc_PN;
    output.net = net;
    output.nrm_param = nrm_param;
    
    
    %Predict
    
    % predictions (cummulative)
    score_train = zeros(size(data.PU.entire_X, 1), 1);
    
    %Normalise and then Predict on training data
    for i = 1:opts.B
        [~, ~, train_nrml] = normalize(data.PU.entire_X, nrm_param{i}.mn, nrm_param{i}.sd);
        
        % apply the neural network to traing data
        p = sim(net{i}, train_nrml');
        score_train = score_train + p';  % add predictions
    end
    
    top_pos = position_in_top_n(score_train, data);
    auc_train = get_auc_ultra(score_train, data.PU.entire_Y_PU);
    auc_train_PN = get_auc_ultra(score_train, data.PU.entire_Y_true);
    
    output.X0 = X0;
    output.X1 = X1;
    output.score_train = score_train;
    
    [output.pos_PN, output.pos_PU, output.top_lab]  = position_in_top_n(score_train, data);
    output.AUC_tr = auc_train;
    output.AUC_tr_PN = auc_train_PN;
    
    [output.OOB_pos_PN, output.OOB_pos_PU, output.OOB_top_lab]  = position_in_top_n(g', data);
    
    end

