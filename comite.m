function retorno = comite(redes, entrada)
    quantRedes = size( redes,1 );
    respostas = zeros( quantRedes, size( entrada, 1 ) );
    
    for i=1:quantRedes
        if ( isstruct(redes{i}) )
            %svm
            respostas(i, :) = svmclassify(redes{i}, entrada)';
        else
            %mlp
            respostas(i, :) = redes{i}(entrada'); %resposta vem por linhas
        end
    end
    retorno = mean(respostas, 1); % media
end