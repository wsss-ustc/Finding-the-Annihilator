function findAnnihilator(n)
printFlag = 1;  %是否输出提示
%%   
% while(1)  %书写while 主要是为了随机生成函数找低阶零化子  请与30行一起取消注释启用 若要随机生成较低阶零化子请看第24行
    try

%随机生成LFSR函数以及序列
    n = 30;
    initialState = round(rand([1,n]));  %初始化向量
    H = creatLFSR(n);  %LFSR的生成多项式函数 n代表LFSR位数
    Fun = creatRandomFun(n); %生成随机的函数f暂时设置为最多的part个数为n  
    save('Info.mat', 'initialState', 'H', 'Fun');
    
%%    
%     load('Info.mat');  %若使用读取已有mat文件，请注释之前生成部分代码

    num = 9999; %产生的随机比特序列{z}数量
    
    sequence = generateSequence(initialState, H, num);  %生成足够多的序列
    result = caculateFun(sequence, Fun); %根据已经有的序列，计算其结果   
    [lowestAn, multiPart] = findLowestAnnihilator(Fun);  %寻找低阶零化子
    checkResult = checkAnnihilator(sequence, result, lowestAn, multiPart);  %对当前生成的序列代入数值对零化子进行验证
    flag = verifyFun(Fun, lowestAn, multiPart);   %对当前生成的零化子代入方程展开进行验证   %注意multiPart有1常数项
%      if(checkResult == 0 && checkPower(multiPart) < 4 )
%             a = 4;break;
%      end  %这部分主要是在强制多次自动生成函数寻找低阶零化子
    catch
        fprintf('抱歉，无法找到当前函数零化子！请重新生成函数。\n');
    end
% end
    if(printFlag)
        if(checkResult == 0 && flag == 1)
            fprintf('已成功找到当前函数的零化子，相关信息已存入Info.mat中！\n');
        else
            fprintf('未能成功找到当前函数零化子，请再次运行函数\n');
        end
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

function len = checkPower(An_f) %查找内部的最高阶数
  len = -Inf;temp = [];
  if ~iscell(An_f)
      An_f = {An_f};
  end
  if ~isempty(An_f)
     for i = 1:length(An_f)
         if(len < length(An_f{i}))
              len = length(An_f{i});
              temp = An_f{i};
         end
     end
     if strfind(num2str(temp), '0')
         len = len - 1;
     end
  end
end