function [samples, nr_ratings] = ratings(R)

    % Creates a matrix with the ratings and its indices

    [r,c]=find(R);
    nr_ratings = length(c);
    samples = [r,c, zeros(nr_ratings,1)];
    for i = 1 : nr_ratings
        samples(i,3) = R(r(i), c(i));
    end

end