function PM = get_PM(Model)

%PU
PM(1) = Model.AUC_tr;
PM(2) = Model.AUC_CV_test_mean;
PM(3) = Model.AUC_tr - Model.AUC_CV_test_mean;


%PN values
PM(4) = Model.AUC_tr_PN;
PM(5) = Model.AUC_CV_test_mean_PN;
PM(6) = Model.AUC_tr_PN - Model.AUC_CV_test_mean_PN;

%    PM(4) = Model.AUC_pr_tr;
%     PM(5) = Model.AUC_CV_pr_tr_mean;
%     PM(6) = Model.AUC_CV_pr_test_mean;

%   PM(7) = Model.AUC_tr - Model.AUC_CV_test_mean; %Overfitting 1
%  PM(8) = Model.AUC_CV_tr_mean - Model.AUC_CV_test_mean; %Overfitting 2

%     PM(9) = Model.AUC_pr_tr;
%     PM(10) = Model.AUC_CV_pr_tr_mean;
end