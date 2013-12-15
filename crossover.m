function [filho1, filho2] = crossover(pai1, pai2)
    tam = size(pai1, 2);
    ponto1 = randi([1 tam-1]);
    ponto2 = randi([1 tam-1]);
    
    corte1 = min(ponto1,ponto2);
    corte2 = max(ponto1, ponto2);
    
    filho1 = [pai1(1: corte1), pai2(corte1+1: corte2), pai1(corte2+1 : tam) ];
    filho2 = [pai2(1: corte1), pai1(corte1+1: corte2), pai2(corte2+1 : tam) ];
end