clear; clc;





fileList = dir('../PU_datasets/*.mat');
for i = 1:size(fileList)
    file_name = fileList(i).name;
    file_path = [ '../PU_datasets/', file_name];
    load(file_path)
    
    
    %NOTE: Later Set n_l and n_p for each datset and save with data; ignore for
    %now
    
end

N = 10; % N-fold cross validation

i=1;
n_u = 2000;
n_l = 200;
i=1;
alpha = 0.05 ;
beta = 0.8;
runs = 1;

% %Making simulated data
% pos = normrnd(1,1, [100000, 10]);
% neg = normrnd(0,1, [100000, 10]);
% data.X = vertcat(pos, neg);
% data.Y = vertcat(ones(100000,1), zeros(100000,1 ));
% n_u = 10000;
% n_l = 1000;

j=1;
for j = 1:runs
    
    for alpha = [0 0.05 0.25]
        for beta = [1 0.95 0.75]
            output{j,i}.alpha = alpha;
            output{j, i}.beta = beta;
            [data.PU.L, data.PU.U] = make_PU(data, n_l, n_u, beta, alpha);
            data.PU.entire_X = vertcat(data.PU.L.X, data.PU.U.X);
            data.PU.entire_Y_true = vertcat(data.PU.L.Y, data.PU.U.Y);
            data.PU.entire_Y_PU = vertcat(ones(size(data.PU.L.X,1),1), zeros(size(data.PU.U.X,1),1));
            
            n1 = 10; n2 = 10;
            opts.k = [1 5 25]'; %no. of nearest neighbours
            out{j,i}.knn_nested_CV = nested_CV_knn(data.PU.entire_X , data.PU.entire_Y_PU, n1, n2, opts);
            
            out{j,i}.knn_CV = train_CV_knn( data, n2, opts);
            
            n1 = 10; n2 = 10;
            opts.l = 2; %No. of layers
            opts.h = [1 5 25]';
            opts.epochs =1000;
            out{j,i}.nn_nested_CV = nested_CV_NN(data.PU.entire_X , data.PU.entire_Y_PU, n1, n2, opts);
            
            out{j,i}.nn_CV = train_CV_nn( data, n2, opts);
            i = i+1;
            
        end
    end
    j=j+1
    i=1;
end