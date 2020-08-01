function [PM_corr_alpha, PM_corr_beta]= get_PM_corr(alpha, beta, PM)
    
PM_corr_alpha = [corr(alpha, PM(:,1)), corr(alpha, PM(:,2)), corr(alpha, PM(:,3))]%, corr(alpha, PM(:,7)),corr(alpha, PM(:,8))];
    PM_corr_beta = [corr(beta, PM(:,1)), corr(beta, PM(:,2)), corr(beta, PM(:,3))]%, corr(beta, PM(:,7)),corr(beta, PM(:,8))];
end