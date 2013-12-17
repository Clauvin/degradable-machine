function novaGeracao = mating(populacao, adaptacao)
    [tamPopulacao quantRedes]= size(populacao);
    
    novaGeracao = zeros(tamPopulacao, quantRedes);
    
    for i=1 : floor(tamPopulacao/2)
        pai1 = populacao( roleta(adaptacao), :);
        pai2 = populacao( roleta(adaptacao), :);
        [filho1, filho2] = crossover(pai1, pai2);
        novaGeracao( i*2 - 1,  :) = filho1;
        novaGeracao( i*2, :) = filho2;
    end
    
    
end

function amostra= roleta(adaptacao)
    proporcao = cumsum( adaptacao/sum(adaptacao) );
    sorteio = rand();
    resultado = find(sorteio <= proporcao);
    amostra = resultado(1,1);
end