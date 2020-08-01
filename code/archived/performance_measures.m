function [f_measure_max, bacc_max, true_positive_rate] = performance_measures(y_est, y)
%y_est = y_est';
%y = y';
[sorted, indices] = sort(y_est);
y = y(indices);
     for i = 1:size(y_est,1)
        predicted_class = 1:size(y_est,1);
        predicted_class(1:i) = 0;
        predicted_class(i:1:size(y_est,1)) = 1;
        predicted_class = predicted_class';
        TP = sum((predicted_class==1 & y==1));
        FP = sum((predicted_class==1 & y==0));
        FN = sum((predicted_class==0 & y==1));
        TN = sum((predicted_class==0 & y==0));
        f_measure(i) = 2*TP/(2*TP + FP+ FN);
        bacc(i) = 0.5*(TP/sum(y==1) + TN/sum(y==0));
        true_positive_rate(i) = TP/(TP+FN);
     end
    f_measure_max = max(f_measure);
    bacc_max = max(bacc);

end