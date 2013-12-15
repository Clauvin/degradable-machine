function [selecao, populacao, adaptacao] = algGen(redes, entrada, resposta, tamPopulacao, quantGeracoes)
    quantRedes = size(redes,1);
    
    %cada individuo eh um vetor binario dizendo se aquele classificador
    %pertence ou nao ao comite que ele representa
    populacao = randi([0 1], [tamPopulacao quantRedes]); %um individuo por linha
    
    for i=1: quantGeracoes
        populacao = mating(redes, populacao, entrada, resposta);
        populacao = mutacao(populacao, 0.01);
        i
    end
    adaptacao = fitness(redes, populacao, entrada, resposta);
    [melhorFitness, melhorIndividuo] = max(adaptacao);
    
    %find retorna um vetor com todas as posicoes nao nulas, entao com isso
    %converto o vetor binario na melhor combinacao de redes
    melhorMse = 1/melhorFitness
    selecao = redes(find(melhorIndividuo));
end



