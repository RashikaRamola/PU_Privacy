function [output] =  ensemble_RT( X, Y, B, data)

Y = 1.0 * Y;
pX_c = zeros(size(X, 1), 1); %To store sum of score of predictions on remaining data points
npX_c = zeros(size(X, 1), 1);

pX = zeros(size(X, 1), 1);%To store sum of score of predictions on entire data set
%B = how many trees
for bb = 1 : B
    
    % sample with replacement from the data
    q = ceil(rand(1, size(X, 1)) * size(X, 1));
    q_c = setdiff(1 : size(X, 1), q); % remaining data points
    
    
    
    % form a bootstrapped training set
    Xb = X(q, :);
    Yb = Y(q, 1);
    
    %make test set of remaining points
    X_c = X(q_c, :);
    Y_c = Y(q_c, 1);
    
    % train b-th decision tree
    t{bb} = fitrtree(Xb, Yb);
    
    %predict on remaining points
    p_c = predict(t{bb}, X_c);
    
    %add score for remaining points
    pX_c(q_c) = pX_c(q_c) + p_c;  % add predictions
    npX_c(q_c) = npX_c(q_c) + 1; % update counts
    
    
    %also predict on entire training data using each tree
    p_t = predict(t{bb}, X);
    
    %add score for prediction on entire training set
    pX = pX + p_t;  % add predictions
    
    
    
    
end

pX = pX/B;

% this will produce values for function g, using out-of-bag data
    q = find(npX_c ~= 0); % just in case some data points haven't been selected
    g(q) = pX_c(q) ./ npX_c(q);
    if length(q) < size(X, 1)
        g(setdiff(1 : size(X, 1), q)) = mean(g(q));
    end

output.auc_CV = get_auc_ultra(g, Y);
output.auc_train = get_auc_ultra(pX, Y);
output.unseen_scores = g;
output.train_scores = pX;
output.trees = t;
output.top_pos = position_in_top_n(pX, data);

return



end

