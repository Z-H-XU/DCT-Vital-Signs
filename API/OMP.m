function [x] = OMP(A,b,sparsity)
%Step 1
index = []; k = 1; [Am, An] = size(A); r = b; x=zeros(An,1);
cor = A'*r; 
while k <= sparsity
    %Step 2
    [Rm,ind] = max(abs(cor)); %�õ������ڻ���Ӧԭ�ӵ�λ��ind
    index = [index ind]; %ÿ��ѭ��������ڻ���Ӧԭ��λ�ã����δ洢��index
    %Step 3
    P = A(:,index)*inv(A(:,index)'*A(:,index))*A(:,index)';%P*b ͶӰ���� = A��ԭ�������飩* x����С���˷�����Ȩֵ��
    r = (eye(Am)-P)*b; cor=A'*r;% A' *r��r��ԭ��������ȡ���ֵ��ÿ��ԭ�����ѡ��һ�Σ������ظ�ѡ��
    k=k+1;
end
%Step 5
xind = inv(A(:,index)'*A(:,index))*A(:,index)'*b;% xind = ԭ��Ȩֵ�Ĺ���
x(index) = xind; %��Ȩֵ��x�е�λ�ö�Ӧ����
end