function out = nested_CV_knn(X, Y, n1, n2, opts)
%n1 => Number of folds in outer loop
%n2 => Number of folds in inner loop
%opts.k = [....]; a vector of values of hidden neurons to be tried

%first determine number of parameters
param_size = size(opts.k,1);

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
        k = opts.k(par);
        
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
            
           
                
                
            knn.Mdl = fitcknn(Xtf, ytf,'NumNeighbors',k);
            [label,  p] = predict(knn.Mdl, Xv);
            [~, ~, ~, auc(par, j)] = perfcurve(yv, p(:,2), 1);

            
            end
    end
        
    [~ , best_param_ind] = max(mean(auc'));
   
    best_param = opts.k(best_param_ind);
    
    %Use best_param to train Xt and test on Xs
    knn.Mdl = fitcknn(Xt, yt,'NumNeighbors',best_param);
    [label,  p] = predict(knn.Mdl, Xt);
    [~, ~, ~, auc_fold(i)] = perfcurve(yt, p(:,2), 1);
        
        
       
end
    out.auc_CV = mean(auc_fold);

    
end