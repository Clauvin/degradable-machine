function adaptacao=fitness(redes, populacao, entrada, resposta)
    tamPopulacao = size(populacao, 1);
    adaptacao = zeros(tamPopulacao,1);
    for i=1: tamPopulacao
        indicesRedes = find( populacao(i, :) );
        respostaIndividuo = comite( redes(indicesRedes), entrada );
        erro = (respostaIndividuo' - resposta);
        adaptacao(i,1) = sum(erro .^ 2)/ size(entrada,1);
    end
    adaptacao = 1 ./ adaptacao;
end