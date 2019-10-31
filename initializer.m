function [R, U, M, nr_u, nr_m, maxIter, err, myErr] = initializer(R, k, iter)

    R = double(R);
    [nr_u, nr_m] = size(R);
    err = 0.15;
    myErr = 1;
    maxIter = iter;
    
    %Initialize user and movie latent feature matrices
    U = rand(nr_u, k) / k;
    M = rand(nr_m, k) / k;

end
