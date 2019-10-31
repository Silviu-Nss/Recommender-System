function [iter, Pr] = nnmfWithBiases(R, k, alpha, beta, iter)

    [R, U, M, nr_u, nr_m, maxIter, err, myErr] = initializer(R, k, iter);
    [b_u, b_m, b] = biases(nr_u, nr_m, R);
    [samples, nr_ratings] = ratings(R);
    
    while(myErr > err && iter > 0)
        % shuffle ratings
        %samples = samples(randperm(nr_ratings),:);
        for l = 1 : nr_ratings
            i = samples(l,1);
            j = samples(l,2);
            r = samples(l,3);
            
            % Compute prediction and error
            pred = b + b_u(i) + b_m(j) + U(i, :) * M(j, :)';
            e = r - pred;
            
            % Update biases
            b_u(i) = b_u(i) + alpha * (e - beta * b_u(i));
            b_m(j) = b_m(j) + alpha * (e - beta * b_m(j));
            
            % Update user and movie latent feature matrices
            U(i, :) = U(i, :) + alpha * (e * M(j, :) - beta * U(i,:));
            M(j, :) = M(j, :) + alpha * (e * U(i, :) - beta * M(j,:));
        end
        Pr = b + b_u + b_m' + U * M';
        Pr = Pr .* (R > 0);
        myErr = norm(Pr - R);
        iter = iter - 1;
    end
    
    iter = maxIter - iter;
    Pr = b + b_u + b_m' + U * M';
end