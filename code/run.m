function run(filename, n_l, n_u, runs, alpha_val, beta_val, N)

addpath('../PU_datasets/')
addpath('./predictor_functions/')
addpath('./predictor_functions/svm_code/')

result_filename = horzcat('../results/',filename, num2str(n_l),'_',num2str(n_u), '.mat');
file_path = [ '../PU_datasets/', filename];
load(file_path);



n_comb = size(alpha_val,2)*size(beta_val,2);



for j = 1:runs
    j
    i = 1;
    for alpha = alpha_val
        for beta = beta_val
            output{j,i}.alpha = alpha
            output{j, i}.beta = beta
            [data.PU.L, data.PU.U] = make_PU(data, n_l, n_u, beta, alpha);
            data.PU.entire_X = vertcat(data.PU.L.X, data.PU.U.X);
            
            data.PU.entire_Y_true = vertcat(data.PU.L.Y, data.PU.U.Y);
            data.PU.entire_Y_PU = vertcat(ones(size(data.PU.L.X,1),1), zeros(size(data.PU.U.X,1),1));
            output{j,i}.data = data;
            
            output{j, i}.predictors = classifiers(data, N);
            
            i=i+1;
        end
        save(result_filename);
    end
    j=j+1
    
end


for i = 1:21
    for j = 1:n_comb
        top = zeros(n_l+n_u, 3);
        for k = 1:runs
            PM_each(k,:) = get_PM(output{k,j}.predictors.Pred{i});
            top(:,1) = top(:,1) + output{k,j}.predictors.Pred{i}.top_lab';
            top(:,2) = top(:,2) + output{k,j}.predictors.Pred{i}.pos_PU';
            top(:,3) = top(:,3) + output{k,j}.predictors.Pred{i}.pos_PN';
        end
        top = top/runs;
        PM{i}.val(j,:) = [mean(PM_each), std(PM_each)];
        PM{i}.top(j, :) = top(n_l, :);
    end
    
end


save(result_filename);
end