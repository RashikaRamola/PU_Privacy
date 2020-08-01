function out = nested_CV_knn(X, Y, n1, n2, opts)
%n1 => Number of folds in outer loop
%n2 => Number of folds in inner loop
%opts.k = [....]; a vector of values of hidden neurons to be tried


%first determine number of parameters
if classifier == 1
    param_size = size(param.HN,1);
elseif classifier ==2
    param_size = size(param.k,1);
end



b1 = n_fold(size(X, 1), n1);
test_labels1 = zeros(size(X,1),1);





for i = 1 : n1
    Xs = X(b1{i}, :); % test data
    Xt = X(setdiff(1:size(X, 1), b1{i}), :); % train data
    ys = Y(b1{i}, :); % test data labels
    yt = Y(setdiff(1:size(Y, 1), b1{i}), :); % train data labels
    
    b2 = n_fold(size(Xt, 1), n2);
    test_labels2 = zeros(size(Xt,1),1);
    
    
    
    for par = 1:param_size
        %Assign Parameters
        h = param.HN(par);
        l = 2;
        epochs = 1000;
        for j = 1:n2
            Xv = Xt(b2{j}, :); % validation data
            Xtf = Xt(setdiff(1:size(Xt, 1), b2{j}), :); % train data for i-th fold
            yv = yt(b2{i}, :); % validation data labels
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
                auc(par,j) = get_auc_ultra(p, yv)
            end
        end
    
        [~ , best_param_ind] = max(auc');
        best_param = param.HN(par);
        
        %     mu = mean(Xt, 1);
        %     sg = std(Xt, [], 1);
        %
        %     %Calculate z-score only if sigma is non-zero, else leave as it is.
        %     for j = 1:size(sg,2)
        %         if (sg(1,j)) ~= 0
        %             Xt(:,j) = (Xt(:,j)-mu(1,j)/sg(1,j));
        %             Xs(:,j) = (Xs(:,j)-mu(1,j)/sg(1,j));
        %         end
        %     end
        %
        %
        %     [Xtt, T] = pca_ret_var_noclass(Xt, 99);
        %
        %
        %     output.pca_param{i} = T;
        %     Xst = Xs * T; %Transformed test data
        
        %Xtt = [ones(size(Xtt, 1), 1) Xtt];
        %Xst = [ones(size(Xst, 1), 1) Xst];
        
        
        %     w = weighted_logreg(Xtt, yt, costs);
        %     output.w_param{i} = w;
        %     p(b{i}, 1) = logsig([ones(size(Xst, 1), 1) Xst] * w);
        %     [f_max(i), bacc_max(i), ~] = performance_measures(p(b{i}), ys);
        %
        %     [~, ~, ~, auc(i)] = perfcurve(ys, p(b{i}), 1);
        %     [~,~,~,AUCpr_test(i)] = perfcurve(ys, p(b{i}),  1, 'xCrit', 'reca', 'yCrit', 'prec');
        %     test_labels(b{i}) = ys;
        
    end
    
end