function [radar_I,radar_Q] = fit_ellipse(x,y)
n = length(x);
M = ones(n,1);
b = -1* x.^2;
m1 = y.^2;
m2 = x.* y;
M = [m1 m2 x y M];
coef = (M'*M)^(-1) *M'* b;
Ae = sqrt(1/coef(1));
Phie = asin(coef(2)/ (2*sqrt(coef(1))));
radar_I = x;
radar_Q = -x*(tan(Phie)) + y/ (Ae* cos(Phie));







% D1 = [x .^ 2, x .* y, y .^2];
% D2 = [x, y ,ones(size(x))];
% s1 = D1' * D1;
% s2 = D1' * D2;
% s3 = D2' * D2;
% T = - inv(s3) * s2';
% M = s1 + s2 * T;
% M = [M(3,:) ./ 2; -M(2,:); M(1,:) ./2];
% [evec, eval] = eig(M);
% cond = 4 * evec(1,:) .* evec(3,:) -evec(2,:) .^2;
% a1 = evec(:, find(cond >0));
% coef = [a1;T * a1];