function out = train_CV_nn( data, n, opts)
X = data.PU.entire_X;
Y = data.PU.entire_Y_PU;

b2 = n_fold(size(X, 1), n);

for par = 1:size(opts.h)
    %Assign Parameters
    
    epochs = opts.epochs;
    h = opts.h(par);
    l = opts.l;
    for j = 1:n
        Xs = X(b2{j}, :); % test
        Xt = X(setdiff(1:size(X, 1), b2{j}), :); % train data for i-th fold
        ys = Y(b2{j}, :); % test data labels
        yt = Y(setdiff(1:size(Y, 1), b2{j}), :); % train data labels for i-th fold
        
        
        %Normalisation
        % normalize training and test sets
        [mn, sd, Xt] = normalize(Xt, [], []);
        [~, ~, Xs] = normalize(Xs, mn, sd);
        
        
        
        
        % initialize and train a neural network
    %net{b} = newff(Xb', yb', h, {'tansig', 'tansig'}, 'trainrp');
    
    net = feedforwardnet(h, 'trainrp');
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
    auc(par,j) = get_auc_ultra(p, ys);
        
    end
end

[~ , best_param_ind] = max(mean(auc'));

best_param = opts.h(best_param_ind);


%Use best parameters to train on entire data
%Normalisation
    % normalize training and test sets
    [mn, sd, X] = normalize(X, [], []);
    
    
   
    
    
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
    net = train(net, X', Y');
    
    % apply the neural network to validation
    p = sim(net, X');
    out.auc = get_auc_ultra(p', Y);
    out.pos_in_top = position_in_top_n(p', data);

end