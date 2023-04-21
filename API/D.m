function y = D(c, M, N)
    v = N * idct(c);
    y = v(1:M);
end