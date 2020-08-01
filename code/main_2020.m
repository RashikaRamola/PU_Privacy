for j = 1:5
    j
    j=j+1;
end
for i = 1:2
    for j = 1:2 %n_comb
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

addpath('../PU_datasets/')
addpath('./predictor_functions/')
addpath('./predictor_functions/svm_code/')
clear; clc;

runs = 1;
n_u = 2000;n_l = 200;

file_name = 'activity_recognition_s1.mat'

N = 10; % N-fold cross validation

alpha_val = [0.05]% 0.25]; %[0 0.05 0.10 0.25];
beta_val = [1]% 0.75]; %[1 0.95 0.75];
run(file_name, n_l, n_u, runs, alpha_val, beta_val, N);

fileList = dir('../PU_datasets/*.mat');
for i = 1:3
    file_name = fileList(i).name;
end

run(filename, n_l, n_p, N_runs, alpha_val, beta_val)




% 
% Positives_in_top_agg = zeros(2200,15);
% for i = 1:12
%     PM.LR(i, :) = get_PM(output{1,i}.predictors.LR);
%     PM.WLR(i, :) = get_PM(output{1,i}.predictors.WLR);
%     
%     PM.knn_1(i, :) = get_PM(output{1,i}.predictors.knn_CV_1);
%     PM.knn_5(i, :) = get_PM(output{1,i}.predictors.knn_CV_5);
%     PM.knn_25(i, :) = get_PM(output{1,i}.predictors.knn_CV_25);
%     
%     PM.SVM_l_1(i, :) = get_PM(output{1,i}.predictors.SVM_l_CV_1);
%     PM.SVM_l_2(i, :) = get_PM(output{1,i}.predictors.SVM_l_CV_2);
%     PM.SVM_l_3(i, :) = get_PM(output{1,i}.predictors.SVM_l_CV_3);
%     
%     PM.SVM_g_4(i,:) = get_PM(output{1,i}.predictors.SVM_g_CV_4);
%     PM.SVM_g_3(i,:) = get_PM(output{1,i}.predictors.SVM_g_CV_3);
%     PM.SVM_g_2(i,:) = get_PM(output{1,i}.predictors.SVM_g_2);
%     PM.SVM_g_1(i,:) = get_PM(output{1,i}.predictors.SVM_g_CV_1);
%     
%     PM.SVM_g_11(i,:) = get_PM(output{1,i}.predictors.SVM_g_CV_11);
%     PM.SVM_g_10(i,:) = get_PM(output{1,i}.predictors.SVM_g_CV_10);
%     PM.SVM_g_100(i,:) = get_PM(output{1,i}.predictors.SVM_g_CV_100);
%     
%     
%     Positives_in_top_agg = Positives_in_top_agg + [output{1,i}.predictors.LR.pos_in_top', output{1,i}.predictors.WLR.pos_in_top', output{1,i}.predictors.knn_CV_1.pos_in_top', output{1,i}.predictors.knn_CV_5.pos_in_top', output{1,i}.predictors.knn_CV_25.pos_in_top', output{1,i}.predictors.SVM_l_CV_1.pos_in_top', output{1,i}.predictors.SVM_l_CV_2.pos_in_top', output{1,i}.predictors.SVM_l_CV_3.pos_in_top', output{1,i}.predictors.SVM_g_CV_4.pos_in_top', output{1,i}.predictors.SVM_g_CV_3.pos_in_top', output{1,i}.predictors.SVM_g_2.pos_in_top', output{1,i}.predictors.SVM_g_CV_1.pos_in_top', output{1,i}.predictors.SVM_g_CV_11.pos_in_top', output{1,i}.predictors.SVM_g_CV_10.pos_in_top', output{1,i}.predictors.SVM_g_CV_100.pos_in_top'];
%     Positives_in_top{i} = [output{1,i}.predictors.LR.pos_in_top', output{1,i}.predictors.WLR.pos_in_top', output{1,i}.predictors.knn_CV_1.pos_in_top', output{1,i}.predictors.knn_CV_5.pos_in_top', output{1,i}.predictors.knn_CV_25.pos_in_top', output{1,i}.predictors.SVM_l_CV_1.pos_in_top', output{1,i}.predictors.SVM_l_CV_2.pos_in_top', output{1,i}.predictors.SVM_l_CV_3.pos_in_top', output{1,i}.predictors.SVM_g_CV_4.pos_in_top', output{1,i}.predictors.SVM_g_CV_3.pos_in_top', output{1,i}.predictors.SVM_g_2.pos_in_top', output{1,i}.predictors.SVM_g_CV_1.pos_in_top', output{1,i}.predictors.SVM_g_CV_11.pos_in_top', output{1,i}.predictors.SVM_g_CV_10.pos_in_top', output{1,i}.predictors.SVM_g_CV_100.pos_in_top'];
%     %Positives_in_top = [output{1,i}.predictors.LR.pos_in_top', output{1,i}.predictors.WLR.pos_in_top', output{1,i}.predictors.knn_CV_1.pos_in_top', output{1,i}.predictors.knn_CV_5.pos_in_top', output{1,i}.predictors.knn_CV_25.pos_in_top', output{1,i}.predictors.SVM_l_CV_1.pos_in_top', output{1,i}.predictors.SVM_l_CV_2.pos_in_top', output{1,i}.predictors.SVM_l_CV_3.pos_in_top', output{1,i}.predictors.SVM_g_CV_4.pos_in_top', output{1,i}.predictors.SVM_g_CV_3.pos_in_top', output{1,i}.predictors.SVM_g_2.pos_in_top', output{1,i}.predictors.SVM_g_CV_1.pos_in_top', output{1,i}.predictors.SVM_g_CV_11.pos_in_top', output{1,i}.predictors.SVM_g_CV_10.pos_in_top', output{1,i}.predictors.SVM_g_CV_100.pos_in_top'];
%     
% end
% %alpha = [0.05 0.05 0.25 0.25];
% %beta = [1 0.75 1 0.75]
% 
% Positives_in_top_agg = Positives_in_top_agg/12;
% 
% AUC_tr = [PM.LR(:,1), PM.WLR(:,1), PM.knn_1(:,1), PM.knn_5(:,1), PM.knn_25(:,1), PM.SVM_l_1(:,1), PM.SVM_l_2(:,1), PM.SVM_l_3(:,1), PM.SVM_g_4(:,1), PM.SVM_g_3(:,1), PM.SVM_g_2(:,1), PM.SVM_g_1(:,1), PM.SVM_g_11(:,1), PM.SVM_g_10(:,1), PM.SVM_g_100(:,1)];
% AUC_ts_CV = [PM.LR(:,2), PM.WLR(:,2), PM.knn_1(:,2), PM.knn_5(:,2), PM.knn_25(:,2), PM.SVM_l_1(:,2), PM.SVM_l_2(:,2), PM.SVM_l_3(:,2), PM.SVM_g_4(:,2), PM.SVM_g_3(:,2), PM.SVM_g_2(:,2), PM.SVM_g_1(:,2), PM.SVM_g_11(:,2), PM.SVM_g_10(:,2), PM.SVM_g_100(:,2)];
% AUC_diff = [PM.LR(:,3), PM.WLR(:,3), PM.knn_1(:,3), PM.knn_5(:,3), PM.knn_25(:,3), PM.SVM_l_1(:,3), PM.SVM_l_2(:,3), PM.SVM_l_3(:,3), PM.SVM_g_4(:,3), PM.SVM_g_3(:,3), PM.SVM_g_2(:,3), PM.SVM_g_1(:,3), PM.SVM_g_11(:,3), PM.SVM_g_10(:,3), PM.SVM_g_100(:,3)];
% Alg = ['LR'	'WLR'	'knn (k =1)'	'knn (k =5)'	'knn (k =25)'	'SVM (n=1)'	'SVM (n=2)'	'SVM (n=3)'	'SVM (sigma=10^-4)'	'SVM (sigma=10^-3)'	'SVM (sigma=10^-2)'	'SVM (sigma=10)'	'SVM (sigma=1)'	'SVM (sigma=10)'	'SVM (sigma=100)'];
% 
% 
% alpha = [0 0 0 0.05 0.05 0.05 0.10 0.10 0.10 0.25 0.25 0.25];
% beta = [1 0.95 0.75 1 0.95 0.75 1 0.95 0.75 1 0.95 0.75]
% 
% [Model_corr_alpha(1, :), Model_corr_beta(1, :)] = get_PM_corr(alpha', beta', PM.LR);
% [Model_corr_alpha(2, :), Model_corr_beta(2, :)] = get_PM_corr(alpha', beta', PM.WLR);
% [Model_corr_alpha(3, :), Model_corr_beta(3, :)] = get_PM_corr(alpha', beta', PM.knn_1);
% [Model_corr_alpha(4, :), Model_corr_beta(4, :)] = get_PM_corr(alpha', beta', PM.knn_5);
% [Model_corr_alpha(5, :), Model_corr_beta(5, :)] = get_PM_corr(alpha', beta', PM.knn_25);
% [Model_corr_alpha(6, :), Model_corr_beta(6, :)] = get_PM_corr(alpha', beta', PM.SVM_l_1);
% [Model_corr_alpha(7, :), Model_corr_beta(7, :)] = get_PM_corr(alpha', beta', PM.SVM_l_2);
% [Model_corr_alpha(8, :), Model_corr_beta(8, :)] = get_PM_corr(alpha', beta', PM.SVM_l_3);
% [Model_corr_alpha(9, :), Model_corr_beta(9, :)] = get_PM_corr(alpha', beta', PM.SVM_g_4);
% [Model_corr_alpha(10, :), Model_corr_beta(10, :)] = get_PM_corr(alpha', beta', PM.SVM_g_3);
% [Model_corr_alpha(11, :), Model_corr_beta(11, :)] = get_PM_corr(alpha', beta', PM.SVM_g_2);
% [Model_corr_alpha(12, :), Model_corr_beta(12, :)] = get_PM_corr(alpha', beta', PM.SVM_g_1);
% [Model_corr_alpha(13, :), Model_corr_beta(13, :)] = get_PM_corr(alpha', beta', PM.SVM_g_11);
% [Model_corr_alpha(14, :), Model_corr_beta(14, :)] = get_PM_corr(alpha', beta', PM.SVM_g_10);
% [Model_corr_alpha(15, :), Model_corr_beta(15, :)] = get_PM_corr(alpha', beta', PM.SVM_g_100);
% 
% top_pos = [Positives_in_top(200,:)', Positives_in_top(400,:)', Positives_in_top(600,:)', Positives_in_top(800,:)', Positives_in_top(1000,:)',Positives_in_top(1200,:)',Positives_in_top(1400,:)', Positives_in_top(1600,:)', Positives_in_top(1800,:)', Positives_in_top(2000,:)',Positives_in_top(2200,:)'];
% legend('');
% 
% plot(1:2200, Positives_in_top_agg(:,1), 1:2200, Positives_in_top_agg(:,2), 1:2200, Positives_in_top_agg(:,3),  1:2200, Positives_in_top_agg(:,4),  1:2200, Positives_in_top_agg(:,5), 1:2200, Positives_in_top_agg(:,6), 1:2200, Positives_in_top_agg(:,7), 1:2200, Positives_in_top_agg(:,8));