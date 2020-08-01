function out = nested_CV_NN(X, Y, n1, n2, opts)
%n1 => Number of folds in outer loop
%n2 => Number of folds in inner loop
%opts.l => no. of layers
%opts.h => [....]; a vector of number of hidden neurons to be tried
%opts.epochs = number of epochs

b1 = n_fold(size(X, 1), n1);
for i = 1 : n1
    Xs = X(b1{i}, :); % test data
    Xt = X(setdiff(1:size(X, 1), b1{i}), :); % train data
    ys = Y(b1{i}, :); % test data labels
    yt = Y(setdiff(1:size(Y, 1), b1{i}), :); % train data labels
    b2 = n_fold(size(Xt, 1), n2);
    test_labels2 = zeros(size(Xt,1),1);
    
    
    
    for par = 1:size(opts.h)
        %Assign Parameters
        h = opts.h(par);
        l = opts.l;
        epochs = opts.epochs;
        for j = 1:n2
            Xv = Xt(b2{j}, :); % validation data
            Xtf = Xt(setdiff(1:size(Xt, 1), b2{j}), :); % train data for i-th fold
            yv = yt(b2{j}, :); % validation data labels
            ytf = yt(setdiff(1:size(yt, 1), b2{j}), :); % train data labels for i-th fold
            
            
            %Normalisation
            % normalize training and test sets
            [mn, sd, Xtf] = normalize(Xtf, [], []);
            [~, ~, Xv] = normalize(Xv, mn, sd);
            
            %Store normalisation parameters
            nrm_param{j}.sd = sd;
            nrm_param{j}.mn = mn;
            
            
            
            
            % initialize and train a neural network
            %net{b} = newff(Xb', yb', h, {'tansig', 'tansig'}, 'trainrp');
            net = feedforwardnet([h], 'trainrp');
            %net{b} = feedforwardnet([h], 'trainbr');
            for jj=1:l
                net.layers{jj}.transferFcn = 'tansig';
            end
            %net{b}.layers{1}.transferFcn = 'tansig';
            %net{b}.layers{2}.transferFcn = 'tansig';
            
            net.trainParam.epochs = epochs;
            net.trainParam.show = NaN;
            net.trainParam.showWindow = false;
            net.trainParam.max_fail = 25;
            net.divideFcn = 'divideind';
            %net{b}.divideParam.trainInd = 1 : size(Xb, 1);
            %net{b}.divideParam.valInd = [];
            net = train(net, Xtf', ytf');
            
            % apply the neural network to validation
            p = sim(net, Xv');
            auc(par,j) = get_auc_ultra(p, yv);
        end
    end
    
    [~ , best_param_ind] = max(mean(auc'));
    
    best_param = opts.h(best_param_ind);
    
    %Use best_param to train Xt and test on Xs
    
    
    %Normalisation
    % normalize training and test sets
    [mn, sd, Xt] = normalize(Xt, [], []);
    [~, ~, Xs] = normalize(Xs, mn, sd);
    
   
    
    
    % initialize and train a neural network
    %net{b} = newff(Xb', yb', h, {'tansig', 'tansig'}, 'trainrp');
    net = feedforwardnet([best_param], 'trainrp');
    %net{b} = feedforwardnet([h], 'trainbr');
    for jj=1:l
        net.layers{jj}.transferFcn = 'tansig';
    end
    %net{b}.layers{1}.transferFcn = 'tansig';
    %net{b}.layers{2}.transferFcn = 'tansig';
    
    net.trainParam.epochs = epochs;
    net.trainParam.show = NaN;
    net.trainParam.showWindow = false;
    net.trainParam.max_fail = 25;
    net.divideFcn = 'divideind';
    %net{b}.divideParam.trainInd = 1 : size(Xb, 1);
    %net{b}.divideParam.valInd = [];
    net = train(net, Xt', yt');
    
    % apply the neural network to validation
    p = sim(net, Xs');
    auc_fold(i) = get_auc_ultra(p, ys);
    
    
    
    
end
out.auc_CV = mean(auc_fold);

end