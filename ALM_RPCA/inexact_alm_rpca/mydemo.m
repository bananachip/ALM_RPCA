D = rand(100,100);
[A_hat,E_hat,iter] = inexact_alm_rpca(D);
disp(['A的秩为：',num2str(rank(A_hat)),'/',num2str(size(D,1))]);
disp(['E中零元素个数为',num2str(length(find(E_hat==0))),'/',num2str(size(D,1)*size(D,2))])
