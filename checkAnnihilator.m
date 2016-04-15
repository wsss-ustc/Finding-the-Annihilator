function checkResult = checkAnnihilator(sequence, result, lowestAn, multiPart)
    target = sequence(result == 1, :);
    result1 = caculateFun(target, lowestAn);
    result2 = mod(caculateFun(target, multiPart) + 1, 2);
    checkResult = sum(result1 .* result2);

    
    