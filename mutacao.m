function novaPopulacao=mutacao(populacao, taxa)
   tentativa = rand( size(populacao) );
   pontosMutacao = tentativa < taxa;
   novaPopulacao = xor(pontosMutacao, populacao);
end