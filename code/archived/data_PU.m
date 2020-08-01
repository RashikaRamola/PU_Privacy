function [data] = data_PU(n_u, n_l, alpha, beta, sw)
    switch sw
        case 1      %Gaussian
            l_pos =  normrnd(1,1,round(beta*n_l),1);
            l_neg = normrnd(-1,1,n_l - round(beta*n_l),1);
            u_pos = normrnd(1,1,round(alpha*n_u),1);
            u_neg = normrnd(-1,1,n_u - round(alpha*n_u),1);
            data.L = vertcat(l_pos, l_neg);
            data.U = vertcat( u_pos, u_neg);
        
    end
end