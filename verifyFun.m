function flag = verifyFun(Fun, lowestAn, multiPart) %注意multiPart有1常数项

    ans = specMul(Fun, [specMul(multiPart, lowestAn), lowestAn]);
    flag = checkFun(ans);
    if(flag)
        fprintf('零化子通过验证。\n');
    end
end
function flag = checkFun(Fun)  %对于项数为偶数的进行去除处理
    Fun_str = getStr(Fun);
    flag = 0;
    [unique_str, ~] = unique(Fun_str);
    for i = 1:length(unique_str)
       count = length( find (strcmp (Fun_str, unique_str(i))));
       if mod(count,2) == 0
%         Fun_str = setdiff(Fun_str, unique_str(i));
          Fun_str(find (strcmp (Fun_str, unique_str(i)))) = [];
       end
    end
    if isempty(Fun_str)
        flag = 1;
    end
end
function ans = specMul(Fun, Fun1) %进行乘积操作
    ans = {};
    for i = 1:length(Fun)
        for j = 1:length(Fun1)
            ans = [ans, mul(Fun{i}, Fun1{j})];
        end
    end
end

function F = mul(Fun, Fun1) %进行整合
    F = {};
    if(~isempty(find(Fun1 == 0,1)))
        Fun1(Fun1 == 0) = [];
        F = [F, Fun];
    end
        F = [F, sort(union(Fun, Fun1))];   
end

function F = getStr(fs) %转化成字符串以便进行对比操作
    F = cell(1, length(fs));
    for i = 1:length(fs)
        F{i} = num2str(fs{i});
    end
end