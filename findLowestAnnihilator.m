function [lowestAn, multiPart] = findLowestAnnihilator(Fun)
%     load('Info.mat');  %测试时使用
    [lenGroupe, order] = sort(getLen(Fun));
    diffLen = unique(lenGroupe);
    Fun = Fun(order);
    f = Fun(lenGroupe == lenGroupe(end));
    
    [An_f, An_non_f] = getAnnihilatorSubset(f);
    [AI_f, I] = getLowPower(An_f, An_non_f, lenGroupe,length(lenGroupe) - 1);%论文算法三①部分
    
    for i = length(diffLen) - 1:-1:1
        f = [f Fun(lenGroupe == diffLen(i))];%论文算法三②部分
        [temp_f, temp_non_f] = getAnnihilatorSubset(f);
        [temp_AI_f, I] = getLowPower(temp_f, temp_non_f, diffLen,i - 1);
        if temp_AI_f < AI_f  %判断找寻最低的次数的零化子
            [An_f, An_non_f] = deal(temp_f, temp_non_f);
            AI_f = temp_AI_f;
        else
            break;
        end
    end
    
    multiPart = [];
    for j = i:-1:1
        multiPart = [multiPart Fun(lenGroupe == diffLen(j))];  %计算乘项
    end
    if I == 1   %判断使用哪个
        lowestAn = An_f;
    else
        lowestAn = An_non_f;
    end
end

function F = getLen(Fun)    %主要用于整合生成函数的阶次，以满足论文中F的需求
    for i = 1:length(Fun)
        F(i) = length(Fun{i});
    end
end

function [F, I] = getLowPower(An_f, An_non_f, lenGroup, i) %计算两个里面那个阶数比较低，同时还要返回论文中提到的AI量的计算
    [F, I] = min([checkPower(An_f), checkPower(An_non_f)]);
    if (i > 1)
        F = F + lenGroup(i);
    end 
end

function len = checkPower(An_f) %此函数返回其中的最小阶数
  len = Inf;temp = [];
  if ~isempty(An_f)
     for i = 1:length(An_f)
         if(len > length(An_f{i}))
              len = length(An_f{i});
              temp = An_f{i};
         end
     end
     if strfind(num2str(temp), '0')
         len = len - 1;
     end
  end
end