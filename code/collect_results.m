addpath('../PU_datasets/')
addpath('./predictor_functions/')
addpath('./predictor_functions/svm_code/')

%fileList = dir('../results/complete/*.mat');
fileList = dir('../results/simulated/Gaussian3.mat');
for i = 1:size(fileList, 1)
    file_name = fileList(i).name;
    load(['../results/simulated/', file_name]);
    clear PM;
    
    si= 1
    for alpha = alpha_val
        for beta = beta_val
            slope(si,1:10) = 100*(beta*n_l/(beta*n_l + alpha*n_u));
            si = si+1;
        end
    end
    
    
    PM_all = zeros(1,42);
    for i = 1:21
        for j = 1:n_comb
            top = zeros(n_l+n_u, 3);
            for k = 1:runs
                for l = 1:size(output{k,j}.predictors.Pred{i}.top_lab,2)
                    PP(l) = l;
                end
                PM_each(k,:) = get_PM(output{k,j}.predictors.Pred{i});
                
                top(:,1) = top(:,1) + (output{k,j}.predictors.Pred{i}.top_lab./PP)';
                top(:,2) = top(:,2) + (output{k,j}.predictors.Pred{i}.pos_PU./PP)';
                top(:,3) = top(:,3) + (output{k,j}.predictors.Pred{i}.pos_PN./PP)';
            end
            top = 100*top/(runs);
            %PM{i}.val(j,:) = [mean(PM_each), std(PM_each)];
            PM{i}.val(j,:) = [(PM_each), (PM_each)];
            PM{i}.top(j, :) = [top(n_l/10, 1), top(2*n_l/10, 1),top(3*n_l/10, 1),top(4*n_l/10, 1),top(5*n_l/10, 1),top(6*n_l/10, 1),top(7*n_l/10, 1),top(8*n_l/10, 1),top(9*n_l/10, 1),top(10*n_l/10, 1), top(n_l/10, 2), top(2*n_l/10, 2),top(3*n_l/10, 2),top(4*n_l/10, 2),top(5*n_l/10, 2),top(6*n_l/10, 2),top(7*n_l/10, 2),top(8*n_l/10, 2),top(9*n_l/10, 2),top(10*n_l/10, 2),top(n_l/10, 3), top(2*n_l/10, 3),top(3*n_l/10, 3),top(4*n_l/10, 3),top(5*n_l/10, 3),top(6*n_l/10, 3),top(7*n_l/10, 3),top(8*n_l/10, 3),top(9*n_l/10, 3),top(10*n_l/10, 3)];
        end
        PM_all = vertcat(PM_all, [PM{i}.val PM{i}.top]);
        subplot(1,3,1);
        daspect = ([1 1 1]);
        
        Lab_IntVl = (1:10)*(n_l/10);
        %slope = 100*(sum(data.PU.L.Y)/(sum(data.PU.L.Y) + sum(data.PU.U.Y)));
       % figure
        plot(Lab_IntVl, PM{i}.top(:,1:10));
        hold on
        plot(Lab_IntVl, slope(1,:), 'Color',[0 0.4470 0.7410], 'LineStyle','--');
        hold on
        plot(Lab_IntVl, slope(2,:), 'Color',[0.8500 0.3250 0.0980], 'LineStyle','--');
        hold on
        plot(Lab_IntVl, slope(3,:), 'Color',[0.9290 0.6940 0.1250], 'LineStyle','--');
        hold on
        plot(Lab_IntVl, slope(4,:), 'Color',[0.4940 0.1840 0.5560], 'LineStyle','--');
        %legend("5% 100%", "5% 75%", "25% 100%", "25% 75%");
        title("% of Labelled Points in top N_l");
        hold off
        
        
        subplot(1,3,2);
        plot(Lab_IntVl, PM{i}.top(:,11:20));
        hold on
        plot(Lab_IntVl, slope(1,:), 'Color',[0 0.4470 0.7410], 'LineStyle','--');
        hold on
        plot(Lab_IntVl, slope(2,:), 'Color',[0.8500 0.3250 0.0980], 'LineStyle','--');
        hold on
        plot(Lab_IntVl, slope(3,:), 'Color',[0.9290 0.6940 0.1250], 'LineStyle','--');
        hold on
        plot(Lab_IntVl, slope(4,:), 'Color',[0.4940 0.1840 0.5560], 'LineStyle','--');
        %legend("5% 100%", "5% 75%", "25% 100%", "25% 75%");
        title("% of Labelled Positives in top N_l");
        hold off
        
        subplot(1,3,3);
        plot(Lab_IntVl, PM{i}.top(:,21:30));
        hold on
        plot(Lab_IntVl, slope(1,:), 'Color',[0 0.4470 0.7410], 'LineStyle','--');
        hold on
        plot(Lab_IntVl, slope(2,:), 'Color',[0.8500 0.3250 0.0980], 'LineStyle','--');
        hold on
        plot(Lab_IntVl, slope(3,:), 'Color',[0.9290 0.6940 0.1250], 'LineStyle','--');
        hold on
        plot(Lab_IntVl, slope(4,:), 'Color',[0.4940 0.1840 0.5560], 'LineStyle','--');
        %legend("5% 100%", "5% 75%", "25% 100%", "25% 75%");
        title("% of Positives in top N_l");
        hold off;
        saveas(gcf,['../results/complete_processed/figures/', num2str(i), file_name, '.png']);
    
    end
    
    %NOTE: Later Set n_l and n_p for each datset and save with data; ignore for
    %now
    save([ '../results/simulated/', file_name]);
    %save([ '../results/complete_processed/', file_name]);
    clearvars -except fileList i;
    
    
end
