function result = caculateFun(seq, Fun)  %针对给定的函数以及序列进行计算
    [m, ~] = size(seq);
    if(isempty(Fun))
        result = ones([1, m]); return;
    end
    if(~iscell(Fun))
       Fun = {Fun};   %判断传入参数进行类型转换
    end 
    result = zeros([1, m]); 
    for i = 1:m
        temp = 0;
        for j = 1:length(Fun)
            tempFun = Fun{j};
            if(~isempty(find(tempFun == 0,1)))  %0代表+1操作，此种情况单独列出计算
                tempFun(tempFun == 0) = [];
                temp = temp + prod(seq(i, tempFun)) + 1;
            else
                temp = temp + prod(seq(i, tempFun));
            end            
        end
        result(i) =  mod(temp, 2); %结果进行mod2操作
    end
end