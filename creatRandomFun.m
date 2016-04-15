function Fun = creatRandomFun(n)
    numOfPart = 0;
    while numOfPart == 0
        numOfPart = round(n * rand); %设定需要多少个部比如 x1*x2+x1 算两个part
    end
    
    Fun = cell(1, numOfPart);
    Fun_str = cell(1, numOfPart);
    for i = 1:numOfPart
        [Fun{i}, Fun_str{i}] = generatePart(n);
    end
    [~, index] = unique(Fun_str);  %去重
    Fun = Fun(index);
end
function [F, F_str] = generatePart(n)    %对于每个子部分生成函数
    power = 0;
    while power == 0
        power = round(n * rand); %设定总共的阶次
    end 
    randVar = randperm(n);  %随机生成一个序列
    F = sort(randVar(1:power));   %取前部分项作为乘数
    F_str = num2str(F); %保存其字符串用于后期去重
end