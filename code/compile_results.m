j=1;
for j = 1:runs
    for alpha = [0 0.05 0.25]
        for beta = [1 0.95 0.75]
            
            alpha = output{j,i}.alpha ;
            beta = output{j, i}.beta ;
            result(j,i).knn_nested_CV_auc = out{j,i}.knn_nested_CV.auc_CV; 
            result(j,i).knn_CV = out{j,i}.knn_CV.auc;
            result(j,i).nn_nested_CV_auc = out{j,i}.nn_nested_CV.auc_CV; 
            result(j,i).nn_CV = out{j,i}.nn_CV.auc;
            result(j,i).knn_top_n = out{j,i}.knn_CV.pos_in_top;
            result(j,i).nn_top_n = out{j,i}.nn_CV.pos_in_top;
            i=i+1;
        end      
    end
    j=j+1
    i=1;
end