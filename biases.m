function [b_u, b_m, b] = biases(nr_u, nr_m, R)
    
    % Initialize the biases
    
    % For users
    b_u = zeros(nr_u, 1);
    
    % For movies
    b_m = zeros(nr_m, 1);
    
    % Compute the mean of ratings
    b = sum(sum(R)) / sum(sum(R > 0));
    
end