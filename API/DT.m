function c = DT(y, M, N)
    c = dct([y.'; zeros(N-M, 1)]);
end