function EquCheck = linearEquSolve(result, Fun, H, initialState)
    %暂时不在此处考虑有常数项1的情况
    index = find(result == 1);
    Q = getTransferFun(H, max(index));
    coefficientMat = zeros([length(index), length(H)]);
    for i = 1:length(index)
        coefficientMat(i, :) = getEquCoefficient(Fun, Q{index(i) - 1});
    end
    EquCheck = sum(mod(coefficientMat * initialState',2));%暂时不会写怎么解模2意义下线性方程组函数先只做check
end

function F = getTransferFun(H, k)
    n = length(H);
    Q = zeros([n, n]);
    temp = eye(n - 1);
    Q(2:end, 1:end - 1) = temp;
    Q(:, end) = H';  %设定转移函数Q
    F = cell(1, k);
    F{1} = Q;
    for i = 2:k
        F{i} = mod(F{i - 1} * Q, 2); 
    end
end

function coefficient = getEquCoefficient(Fun, Q)
    coefficient = mod( sum( Q(:, Fun), 2), 2);
end

