function weight = Weight_Vector(w,value,f,Fs,N)
%%%%
% wΪȨ��
% valueΪȨ��ֵ
% f ΪƵ��
% FsΪ������
% NΪ�źų���
% weight���Ȩ��
%%%%
point1 = ceil(f(1)*N/Fs);
point2 = floor(f(2)*N/Fs);
% w(point1:point2,1) = value;
w(2*point1:2*point2,1) = value;
weight = w;

