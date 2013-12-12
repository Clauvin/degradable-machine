function classificadores = geraClassificadores(entrada, resposta, tamTreino, quantMLP, quantSVM)
    classificadores = cell(quantMLP + quantSVM,1);
    mse = zeros(quantMLP+ quantSVM,1);
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
        %atual.trainParam.showWindow = 0;
        
        treino =  randi( size(entrada,1), [1 tamTreino] ); %equivalente ao baggin
        atual = train(atual, entrada( treino, :)', resposta( treino, :)' );
        

        mse(i, 1) = sum( ( atual(entrada') - resposta' ) .^2 ) / size(entrada,1);
        
        classificadores{i} = atual;
    end
    
    for i=quantMLP: quantSVM+quantMLP
        
    end
    mse
end
