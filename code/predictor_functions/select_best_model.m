function ind = select_best_model(aucs)
    ind = 0;
    max_auc = 0;
    for i = 1:size(aucs, 2)
        if aucs(i)>max_auc
            max_auc = aucs(i);
            ind = i;
        end
    end
    
end