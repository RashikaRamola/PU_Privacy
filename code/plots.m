

  

%Plot figu4re for best model
for i = 1:4
    
    
    subplot(2,2,i)
    out = output{i};
    n_p = (out.predictors.n_p);
    n_l = (out.predictors.n_l);
    plot((out.predictors.pos_LR)/n_p, ':', 'LineWidth',2)
    hold on
    plot((out.predictors.pos_WLR)/n_p, 'LineWidth',2)
    hold on
    plot((out.CV.NNh1.top_pos)/n_p, ':', 'LineWidth',2)
    hold on
    plot((out.CV.NNh5.top_pos)/n_p, ':', 'LineWidth',2)
    hold on
    plot((out.CV.NNh25.top_pos)/n_p, ':', 'LineWidth',2)
    hold on
    plot((out.predictors.nn_CV.pos_in_top)/n_p, ':', 'LineWidth',2)
    hold on
    plot((out.predictors.knn_CV.pos_in_top)/n_p, 'LineWidth',2)
    hold on
    plot((out.predictors.SVM_l_CV.pos_in_top)/n_p, ':', 'LineWidth',2)
    hold on
    plot((out.predictors.SVM_g_CV.pos_in_top)/n_p, 'LineWidth',2)
    hold on
    plot((out.predictors.pos_RT)/n_p, ':', 'LineWidth',2)
    hold on
    plot((out.CV.ensemble_RT.top_pos)/n_p, ':', 'LineWidth',2)
    hold on
    plot((out.predictors.pos_RF)/n_p, 'LineWidth',2)
    hold on
    plot(ones(n_p,1)*n_p, (1:n_p)/n_p, '--' )
    hold on
    plot(ones(n_p,1)*n_l, (1:n_p)/n_p, '--' )
    legend('LR','WLR', 'NN OOB (h=1)', 'NN OOB (h=5)', 'NN OOB (h=25)', 'NN (h = 1, 5, 25)', 'kNN (k = 1, 5, 25)', 'linear SVM', 'gaussian SVM', 'regression tree', 'ensemble tree', 'RFs')
    hold off
    
    
    
    %     if i > 1
    %         set(gca,'XTick',[ out{i}.n_p out{i}.n_plus],'XTickLabel',{'n_l' 'n_p'})
    %     end
    hold off;
    alpha = output{i}.alpha;
    beta = output{i}.beta;
    plot_name = ['Alpha = ' num2str(alpha) ';   Beta =' num2str(beta)]
    title(plot_name)
    ylabel('% of True Positives in Top n Points')
    xlabel('Top n points')
    
    results(i,1) = output{i}.alpha;
    results(i,2) = output{i}.beta;
    
    results(i,3) = output{i}.CV.LR.auc_mean;
    results(i,4) = output{i}.predictors.auc_LR;
    results(i,5) = output{i}.predictors.auc_LR - output{i}.CV.LR.auc_mean;
    
    results(i,6) = output{i}.CV.WLR.auc_mean;
    results(i,7) = output{i}.predictors.auc_WLR;
    results(i,8) = output{i}.predictors.auc_WLR - output{i}.CV.WLR.auc_mean;
    
    results(i,9) = output{i}.CV.NNh1.auc;
    results(i,10) = output{i}.CV.NNh1.auc_train;
    results(i,11) = output{i}.CV.NNh1.auc - output{i}.CV.NNh1.auc_train;
    
    results(i,12) = output{i}.CV.NNh5.auc;
    results(i,13) =  output{i}.CV.NNh5.auc_train;
    results(i,14) =  output{i}.CV.NNh5.auc - output{i}.CV.NNh5.auc_train;
    
    results(i,15) =  output{i}.CV.NNh25.auc;
    results(i,16) = output{i}.CV.NNh25.auc_train;
    results(i,17) = output{i}.CV.NNh25.auc - output{i}.CV.NNh25.auc_train;
    
    results(i,18) = output{i}.CV.nn_nested_CV.auc_CV;
    results(i,19) = output{i}.predictors.nn_CV.auc;
    results(i,20) = output{i}.predictors.nn_CV.auc - output{i}.CV.nn_nested_CV.auc_CV ;
    
    results(i,21) = output{i}.CV.knn_nested_CV.auc_CV;
    results(i,22) = output{i}.predictors.knn_CV.auc;
    results(i,23) = output{i}.predictors.knn_CV.auc - output{i}.CV.knn_nested_CV.auc_CV;
    
    results(i,24) = output{i}.CV.svm_l_nested_CV.auc_CV;
    results(i,25) = output{i}.predictors.SVM_l_CV.auc_train;
    results(i,26) = output{i}.predictors.SVM_l_CV.auc_train - output{i}.CV.svm_g_nested_CV.auc_CV;
    
    results(i,27) = output{i}.CV.svm_g_nested_CV.auc_CV;
    results(i,28) =  output{i}.predictors.SVM_g_CV.auc_train;
    results(i,29) =  output{i}.predictors.SVM_g_CV.auc_train - output{i}.CV.svm_g_nested_CV.auc_CV;
    
    results(i,30) = output{i}.CV.RT_nested_CV.auc_mean;
    results(i,31) = output{i}.predictors.auc_RT;
    results(i,32) = output{i}.CV.RT_nested_CV.auc_mean - output{i}.predictors.auc_RT;
    
    results(i,33) = output{i}.CV.ensemble_RT.auc_CV;
    results(i,34) = output{i}.CV.ensemble_RT.auc_train;
    results(i,35) = output{i}.CV.ensemble_RT.auc_train - output{i}.CV.ensemble_RT.auc_CV;
    
    results(i,36) = output{i}.CV.RandomForest.auc_mean;
    results(i,37) = output{i}.predictors.auc_RF;
    results(i,38) = output{i}.predictors.auc_RF - output{i}.CV.RandomForest.auc_mean;
    
    
end
hold off;
%Plot figure when model is trained directly on training data; no CV; (except NN, they are same in both cases)

for i = 1:9
    
    
    subplot(3,3,i)
    out = output{i};
    n_p = out.predictors.n_p;
    n_l = (out.predictors.n_l);
    plot((out.predictors.pos_LR)/n_p, ':', 'LineWidth',2)
    hold on
    plot((out.predictors.pos_WLR)/n_p, 'LineWidth',2)
    hold on
%     plot((out.predictors.pos_DT)/n_p, ':', 'LineWidth',2)
%     hold on
    plot((out.predictors.pos_RF)/n_p, 'LineWidth',2)
    hold on
%     plot((out.predictors.pos_NN1)/n_p, ':', 'LineWidth',2)
%     hold on
%     plot((out.predictors.pos_NN100)/n_p, 'LineWidth',2)
%     hold on
%     plot((out.predictors.pos_SVM_linear)/n_p, ':', 'LineWidth',2)
%     hold on
%     plot((out.predictors.pos_SVM_rbf)/n_p, 'LineWidth',2)
%     hold on
%     plot((out.predictors.pos_knn1)/n_p, ':', 'LineWidth',2)
%     hold on
%     plot((out.predictors.pos_knn5)/n_p, 'LineWidth',2)
%     hold on
%     plot((out.predictors.pos_knn25)/n_p, ':', 'LineWidth',2)
%     hold on
    plot(ones(n_p,1)*n_p, (1:n_p)/n_p, '--' )
    hold on
    plot(ones(n_p,1)*n_l, (1:n_p)/n_p, '--' )
    legend('LR','WLR', 'DT', 'RF', 'NN1', 'NN100', 'linear SVM', 'gaussian SVM', 'knn 1', 'knn 5', 'knn 25')
    
    %     if i > 1
    %         set(gca,'XTick',[ out{i}.n_p out{i}.n_plus],'XTickLabel',{'n_l' 'n_p'})
    %     end
    hold off;
    alpha = output{i}.alpha;
    beta = output{i}.beta;
    plot_name = ['Alpha = ' num2str(alpha) ';   Beta =' num2str(beta)]
    title(plot_name)
    ylabel('% of True Positives in Top n Points')
    xlabel('Top n points')
    
    
    
    
end


hold off;



% for i = 1:9
%     subplot(3,3,i)
%     out = output{i}.predictors;
%
%     plot((out.pos_LR)/out.n_plus, 'LineWidth',1.5)
%     hold on
%     plot(out.pos_knn1/out.n_plus, 'LineWidth',1.5)
%     hold on
%     plot(out.pos_knn5/out.n_plus, 'LineWidth',1.5)
%     hold on
%     plot(out.pos_knn25/out.n_plus, 'LineWidth',1.5)
%     hold on
%     plot(out.pos_SVM_linear/out.n_plus, 'LineWidth',1.5)
%     hold on
%     plot(out.pos_SVM_rbf/out.n_plus, 'LineWidth',1.5)
%     hold on
%     plot(out.pos_NN1/out.n_plus, 'LineWidth',1.5)
%     hold on
%     plot(out.pos_NN100/out.n_plus, 'LineWidth',1.5)
%     hold on
%     plot(ones(out.n_plus,1)*out.n_plus, (1:out.n_plus)/out.n_plus, '--' )
%     hold on
%     plot(ones(out.n_plus,1)*out.n_p, (1:out.n_plus)/out.n_plus, '--' )
%     legend('LR','knn1', 'knn5', 'knn25', 'SVM linear', 'SVM rbf', 'NN 1', 'NN 100')
%
% %     if i > 1
% %         set(gca,'XTick',[ out{i}.n_p out{i}.n_plus],'XTickLabel',{'n_l' 'n_p'})
% %     end
%     hold off;
%     alpha = output{i}.alpha;
%     beta = output{i}.beta;
%     plot_name = ['Alpha = ' num2str(alpha) ';   Beta =' num2str(beta)]
%     title(plot_name)
%     ylabel('% of True Positives in Top n Points')
%     xlabel('Top n points')
%
%     results(i,1) = alpha;
%     results(i,2) = beta;
%     results(i,3) = output{i}.predictors.auc_knn1;
%     results(i,4) = output{i}.CV.knn1.auc_mean;
%     results(i,5) = results(i,3) - results(i,4);
%     results(i,6) = output{i}.predictors.auc_knn5;
%     results(i,7) = output{i}.CV.knn5.auc_mean;
%     results(i,8) = results(i,6) - results(i,7);
%     results(i,9) = output{i}.predictors.auc_knn25;
%     results(i,10) = output{i}.CV.knn25.auc_mean;
%     results(i,11) = results(i,9) - results(i,10);
%     results(i,12) = output{i}.predictors.auc_LR;
%     results(i,13) = output{i}.CV.LR.auc_mean;
%     results(i,14) = results(i,12) - results(i,13);
%     results(i,15) = output{i}.predictors.auc_SVM_l;
%     results(i,16) = output{i}.CV.lSVM.auc_mean;
%     results(i,17) = results(i,15) - results(i,16);
%     results(i,18) = output{i}.predictors.auc_SVM_rbf;
%     results(i,19) = output{i}.CV.rbfSVM.auc_mean;
%     results(i,20) = results(i,18) - results(i,19);
%     results(i,21) = output{i}.predictors.auc_NN1;
%     results(i,22) = output{i}.CV.NN1.auc;
%     results(i,23) = results(i,21) - results(i,22);
%     results(i,24) = output{i}.predictors.auc_NN100;
%     results(i,25) = output{i}.CV.NN100.auc;
%     results(i,26) = results(i,24) - results(i,25);
%
% end
%



% plot(out.pos_LR)
% hold on
% plot(pos_knn1)
% hold on
% plot(pos_knn5)
% hold on
% plot(pos_knn25)
% hold on
% plot(pos_SVM_linear)
% hold on
% plot(pos_SVM_rbf)
% hold on
% plot(pos_NN1)
% hold on
% plot(pos_NN100)
% legend('LR','knn1', 'knn5', 'knn25', 'SVM linear', 'SVM rbf', 'NN 1', 'NN 100')

% plot(pos_in_top_n_LR)
% hold on
% plot(pos_in_top_n_WLR)
% hold on
% plot(pos_in_top_n_DT)
% hold on
% plot(pos_in_top_n_RF)
% hold on
% plot(pos_in_top_n_NN1)
% hold on
% plot(pos_in_top_n_NN100)
% hold on
% plot(pos_in_top_n_lSVM)
% hold on
% plot(pos_in_top_n_lSVM_with_SVs)
% hold on
% plot(pos_in_top_n_kSVM)
% hold on
% plot(pos_in_top_n_kSVM_with_SVs)
% hold on
% plot(pos_in_top_n_knn1)
% hold on
% plot(pos_in_top_n_knn5)
% hold on
% plot(pos_in_top_n_knn25)
%
% legend('LR','WLR', 'DT', 'RF', 'One NN', '100NNs', 'linear SVM', 'linear SVM with SVs' , 'kernel SVM', 'kernel SVM with SVs', 'knn; k=1','knn; k=5', 'knn; k=25' )