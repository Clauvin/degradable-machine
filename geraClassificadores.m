function [classificadores, mse] = geraClassificadores(entrada, resposta, quantMLP, quantSVM)
    classificadores = {};
    mse = zeros(quantMLP+ quantSVM,1);
    tamTreino = size(entrada, 1);
    
    for i=1:quantMLP
        
        camada1= randi([10, 40]);

        switch ( randi(2) )
            case 1
                atual = patternnet(camada1, 'traingdx' );
                atual.trainParam.lr = rand()*0.7 + 0.001; % 0.01
                atual.trainParam.lr_inc = rand()*0.15 + 1.001; % 1.05
                atual.trainParam.lr_dec = rand()*0.45 + 0.45; % 0.7
                atual.trainParam.mc = rand()*0.5 + 0.5; % 0.9
            case 2
                atual = patternnet(camada1, 'trainlm' );
                atual.trainParam.mu_dec = rand() * 0.2 + 0.05; % 0.1
                atual.trainParam.mu_inc = rand() * 7 + 7;  % 10
        end
        
        atual.trainParam.max_fail = randi([4, 20]);
        %atual.trainParam.showWindow =0;
        
        treino =  randi( [1 tamTreino], [size(entrada,1) 1] ); %equivalente ao baggin
        atual = train(atual, entrada( treino, :)', resposta( treino, :)' );
        
        mse(i, 1) = sum( ( atual(entrada') - resposta' ) .^2 ) / size(entrada,1);
        
        classificadores{i, 1} = atual;
        
        i
    end
    
    i = quantMLP+1;
    while i <= quantSVM+quantMLP
        
        tipo= randi([1 5]);
        treino =  randi( [1 tamTreino], [size(entrada,1) 1] ); %equivalente ao baggin
        
        conjTreino = entrada(treino, :);
        conjResposta = resposta(treino, :);
        
        try
        switch tipo
            case 1
                atual =  svmtrain(conjTreino, conjResposta, 'kernel_function', 'linear');
                
            case 2
                atual =  svmtrain(conjTreino, conjResposta, 'kernel_function', 'quadratic');
                
            case 3
                ordem = randi([3 5]);
                atual =  svmtrain(conjTreino, conjResposta, 'kernel_function', 'polynomial', 'polyorder', ordem);
                
            case 4
                sigma = rand() + 0.5;
                atual =  svmtrain(conjTreino, conjResposta, 'kernel_function', 'rbf', 'rbf_sigma', sigma);
                
            case 5
                atual =  svmtrain(entrada, resposta, 'kernel_function', 'mlp');
        end
        catch er
            disp('Falha ao treinar SVM');
            i = i+1
            continue %tente outra vez
        end
        mse(i, 1) = sum( abs( svmclassify(atual, entrada) - resposta ) )/size(entrada,1);
        
        classificadores{i, 1} = atual;
        
        i = i + 1
    end
end
