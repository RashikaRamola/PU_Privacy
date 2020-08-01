% 
% addpath('./svm_code/')
% 
% bigtrain = [data.X, data.Y];
% bigtest = data.X;
% info.kernel = 2;
% info.parameter = 1.5;
% info.pos_weight = 1;
% info.SVMlightpath = './predictor_functions/svm_code/svm_light'
% [labels_test_predicted] = SVMprediction (bigtrain, bigtest, info)
% 
% 
% % info.kernel = 1 or 2; 1=> polynomial kernel; 2=> rbf
% % info.param = 1, 2 or 3 for polynomial kernel; info.param = sigma for rbf
% % kernel;
% % sigm = 10^(-4), 10^(-3), 10^(-2), (1/10), 1, 10, 100


function out = nested_CV_svm(X, Y, n1, n2, info)
%n1 => Number of folds in outer loop
%n2 => Number of folds in inner loop
%opts.k = [....]; a vector of values of hidden neurons to be tried

%first determine number of parameters


%HERE
param_size = size(info.parameter_vector,1);

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
        info.parameter = info.parameter_vector(par);
        
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
            
           
            bigtrain = [Xtf ytf];
            bigtest = [Xv];
             
            [p] = SVMprediction (bigtrain, bigtest, info);
            [~, ~, ~, auc(par, j)] = perfcurve(yv, p, 1);
            end
    end
        
    [~ , best_param_ind] = max(mean(auc'));
   
    best_param = info.parameter_vector(best_param_ind);
    
    %Use best_param to train Xt and test on Xs
    info.param = best_param;
    bigtrain = [Xt yt];
    bigtest = Xs;
    [p] = SVMprediction (bigtrain, bigtest, info);
    
    [~, ~, ~, auc_fold(i)] = perfcurve(ys, p, 1);
        
        
       
end
    out.auc_CV = mean(auc_fold);

    
end