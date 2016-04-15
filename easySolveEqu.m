function easySolveEqu()
    n = 30;
    initialState = round(rand([1,n]));  %初始化向量
    H = creatLFSR(n);  %LFSR的生成多项式函数 n代表LFSR位数
    Fun = {14,[1 3],[2 14],[1 2 3]}; %构造的函数为f = x14 + x1x3 + x2x14 + x1x2x3
    num = 9999;
    sequence = generateSequence(initialState, H, num);  %生成足够多的序列
    result = caculateFun(sequence, Fun); %根据已经有的序列，计算其结果   
    checkResult = checkAnnihilator(sequence, result, {2}, 0); %零化子为f = x2
    EquCheck = linearEquSolve(result, [2], H, initialState);%暂时不会写怎么解模2意义下线性方程组函数先只做check
    if(checkResult == 0 && EquCheck == 0)
        fprintf('方程组校验成功！\n');
    else
        fprintf('方程组校验失败！\n'); 
    end
end


function H = creatLFSR(n)
    H =[1 round( rand( [1,n - 1]))]; %保证函数为非退化的
end

function matrix = generateSequence(initialState, H, num) %函数主要用于产生足够多的序列
    n = length(initialState);
    Q = zeros([n, n]);
    temp = eye(n - 1);
    Q(2:end, 1:end - 1) = temp;
    Q(:, end) = H';  %设定转移函数Q
    
    matrix = zeros([num, n]);
    matrix(1, :) = initialState;
    for i = 2:num
        matrix(i, :) = mod(matrix(i - 1, :) * Q, 2); %循环计算序列
    end
end