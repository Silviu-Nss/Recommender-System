clear;
clc;

 result = [7 9 6 6 10 5 4 6 10 6 5 5 1 10 9 5 7 6 7 1]';
 %load ratings.mat;
 R = [0 5 1 4 2 0 0 4 2 3;
 0 2 1 1 5 4 3 0 0 1;
 2 0 1 4 4 0 3 1 4 2;
 4 0 3 4 3 0 4 2 3 2;
 2 4 0 3 2 2 1 1 5 0;
 0 1 1 1 0 5 5 2 4 4;
 2 3 0 0 2 2 0 4 1 1;
 5 0 4 3 3 0 2 1 1 1;
 3 4 0 0 2 4 4 4 2 0;
 4 0 2 4 4 0 2 1 1 0;
 2 0 1 3 0 2 0 1 3 1;
 0 5 2 2 0 5 1 0 5 5;
 0 3 1 4 2 2 0 2 2 2;
 0 5 2 1 4 4 5 4 3 0;
 5 1 1 4 1 1 0 0 0 2;
 4 4 0 3 0 4 0 2 5 4;
 4 1 0 4 2 3 0 4 2 1;
 3 2 3 2 1 0 2 0 0 2;
 2 2 2 5 4 4 0 3 1 0;
 0 0 4 4 2 5 4 5 1 3];
 [m, n] = size(R);
 alpha = 0.1;
 beta = 0.01;
 iterations = 100;
 k = 10;
 count = 100;
 PrM = zeros(m, n);
 iterM = 0;
 
 for i = 1 : count
     [iter, Pr] = nnmfWithBiases(R, k, alpha, beta, iterations);
     iterM = iterM + iter;
     PrM = PrM + Pr;
 end
 
 PrM = PrM / count;
 
 % iterM si er are for verification
 iterM = iterM / count;
 er = norm(PrM .* (R > 0) - R);
 
 % Recommend movies
 Recm = PrM .* (1 - (R > 0));
 
 % Output
 %fid = fopen("task2.out", "w");
 of = zeros(20,1);
 err = ones(100,1);
 for j = 1 : 100
     for i = 1 : m
         [~, loc] = max(Recm(i,:));
         %disp(['User ',num2str(i),' should watch movie number ',num2str(loc)]);
         %messege = strcat('User ',strcat(num2str(i),strcat(' should watch movie number ',num2str(loc))));
         %fprintf(fid, "User number %d should watch movie number %d\n", i, loc);
         of(i) = loc;

     end
     err(j) = norm(result - of);
 end
 
 %fclose(fid);
