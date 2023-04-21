function [x] = OMP(A,b,sparsity)
%Step 1
index = []; k = 1; [Am, An] = size(A); r = b; x=zeros(An,1);
cor = A'*r; 
while k <= sparsity
    %Step 2
    [Rm,ind] = max(abs(cor)); %得到最大的内积对应原子的位置ind
    index = [index ind]; %每次循环的最大内积对应原子位置，依次存储在index
    %Step 3
    P = A(:,index)*inv(A(:,index)'*A(:,index))*A(:,index)';%P*b 投影分量 = A（原子向量组）* x（最小二乘法估计权值）
    r = (eye(Am)-P)*b; cor=A'*r;% A' *r，r跟原子正交，取最大值，每个原子最多选择一次，不会重复选择
    k=k+1;
end
%Step 5
xind = inv(A(:,index)'*A(:,index))*A(:,index)'*b;% xind = 原子权值的估计
x(index) = xind; %将权值跟x中的位置对应起来
end