function [labelled, unlabelled] = make_PU(data, n_l, n_u, beta, alpha)
        positives = data.X(data.Y==1,:);
        negatives = data.X(data.Y==0,:);
       
        %Labelled Dataset: 1000 points, Unlabelled Dataset:10000
        %Making the Labelled Data
        %Get Labelled Examples
        [lab_positives id_p] = datasample(positives, round(beta*n_l),'replace', false);
        [lab_negatives id_n] = datasample(negatives,round(n_l-beta*n_l), 'replace', false);
        
        
        %Get positives which were not sampled earlier for labelled data
        missingPosIndex = setdiff(1:size(positives, 1), id_p);
        remainingPositives = positives(missingPosIndex,:);
        
         %Get negatives which were not sampled earlier for labelled data
        missingNegIndex = setdiff(1:size(negatives, 1), id_n);
        remainingNegatives = negatives(missingNegIndex,:);
        
        %Calculate alpha
        %alpha = size(remainingPositives,1)/(size(remainingNegatives,1)+size(remainingPositives,1));
        
        %Making Unlabelled Data
        unlab_positives = datasample(remainingPositives, round(alpha*n_u), 'replace', false);
        unlab_negatives = datasample(remainingNegatives,n_u - round(alpha*n_u), 'replace', false); 
        
%         if beta == 1
%             
%             unlab_positives = datasample(remainingPositives, round(0*n_u));
%             unlab_negatives = datasample(remainingNegatives,n_u - round(0*n_u));
%         end
        
        unlabelled.X = vertcat(unlab_positives, unlab_negatives);
        unlabelled.Y = vertcat(ones(size(unlab_positives,1),1), zeros(size(unlab_negatives,1),1));
        labelled.X = vertcat(lab_positives, lab_negatives);
        labelled.Y = vertcat(ones(size(lab_positives,1),1),zeros(size(lab_negatives,1),1));
        
end