function [An_f, An_non_f] = getAnnihilatorSubset(Fun)  %根据论文中算法1实现
%     load('Info.mat'); %测试时使用
    len = length(Fun);
    An_f = An(Fun{1});
    An_non_f = {An_non(Fun{1})};
    for i = 2:len
        temp_f = An(Fun{i});
        temp_non_f = {An_non(Fun{i})};
        An_f = addAndCaculateAn(An_f, An_non_f, temp_f, temp_non_f);
        An_non_f = addAndCaculateAn(An_non_f, An_f, temp_f, temp_non_f);% 循环迭代计算
    end
end

function answer = addAndCaculateAn(fs, fs_non, fi, fi_non)
     temp_1 = plus(fs, fi_non);  %进行加操作
     temp_2 = plus(fs_non, fi);
     answer = intersectPart(temp_1, temp_2);  %取交集操作
end

function F = An(f)  %根据定理2求其零化子集
    F = cell(1, length(f));
    for i = 1:length(f)
        F{i} = [0 f(i)];
    end
end

function F = An_non(f)%根据定理2求其零化子集
    F = f;
end

function F = plus(fs, fi)
    fs_str = getStr(fs);
    fi_str = getStr(fi);
    [~, ia, ib] = union(fs_str, fi_str);
    F = [fs(ia) fi(ib)];
end

function F = intersectPart(t1, t2)
    t1_str = getStr(t1);
    t2_str = getStr(t2);
    [~, ia, ~] = intersect(t1_str, t2_str);
    F = t1(ia);
end

function F = getStr(fs) %转化成字符串以便进行对比操作
    F = cell(1, length(fs));
    for i = 1:length(fs)
        F{i} = num2str(fs{i});
    end
end
