function [adaptacao, mapa] = fitness(redes, populacao, entrada, resposta, mapa)
    tamPopulacao = size(populacao, 1);
    adaptacao = zeros(tamPopulacao,1);
    for i=1: tamPopulacao
        indicesRedes = populacao(i, :);
        
        chave = int2str(bi2de(indicesRedes));
        try
            adaptacao(i, 1) = mapa(chave);
        catch er
            respostaIndividuo = comite( redes(indicesRedes), entrada );
            erro = (respostaIndividuo' - resposta);
            adaptacao(i,1) = 1 ./ ( sum(erro .^ 2)/ size(entrada,1) );
            mapa(chave) = adaptacao(i, 1);
        end
        
    end
end