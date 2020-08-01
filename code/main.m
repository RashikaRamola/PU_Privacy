addpath('../PU_datasets/')
addpath('./predictor_functions/')
addpath('./predictor_functions/svm_code/')
clear; clc;

fileList = dir('../PU_datasets/*.mat');
for i = 1:3
    file_name = fileList(i).name;
    file_path = [ '../PU_datasets/', file_name];
    load(file_path)
    
    
    %NOTE: Later Set n_l and n_p for each datset and save with data; ignore for
    %now
    
end

N = 10; % N-fold cross validation

n_u = 2000;n_l = 200;
runs = 1;
j=1; %j = run_no; i => for each combination of alpha, beta
i=1;

for j = 1:runs
    for alpha = [0 0.05 0.10 0.25]
        for beta = [1]
            output{j,i}.alpha = alpha;
            output{j, i}.beta = beta;
            [data.PU.L, data.PU.U] = make_PU(data, n_l, n_u, beta, alpha);
            data.PU.entire_X = vertcat(data.PU.L.X, data.PU.U.X);
            
            data.PU.entire_Y_true = vertcat(data.PU.L.Y, data.PU.U.Y);
            data.PU.entire_Y_PU = vertcat(ones(size(data.PU.L.X,1),1), zeros(size(data.PU.U.X,1),1));
            output{j,i}.data = data;
            
            output{j, i}.predictors = predictors_train_data(data);
            output{j, i}.CV = all_crossvalidation(data, N);
            i=i+1;
        end
        save('../results/current_out.mat');
    end
    j=j+1
    
end