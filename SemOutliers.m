%leu dados
dados=csvread('dados.csv');

%ajuda sobre isso em data analysis ->
%preprocessing data, na ajuda do MatLAB
%procurando outliers das linhas 1 a 18
%hist(dados(:, 1))
%       Outliers de 0 a 2
%hist(dados(:, 2))
%       Outliers de 7 a 9
%hist(dados(:, 3))
%       Outliers de 10 a 12
%hist(dados(:, 4))
%       Outliers de 2.5 a 3
%hist(dados(:, 5))
%       Outliers de 30 a 35
%hist(dados(:, 6))
%       Outliers de 10 a 14
%hist(dados(:, 7))
%       Outliers de 9 a 18
%hist(dados(:, 8))
%       Outliers de 2 a 6
%hist(dados(:, 9))
%       Outliers de 15 a 25
%hist(dados(:, 10))
%       Outliers de 11 a 12
%hist(dados(:, 11))
%       Outliers de 25 a 45
%hist(dados(:, 12))
%       Sem outliers



%separou dados entre positivos e negativos
dadosPos= dados( find(dados(:, 42)==1),  :);
dadosNeg= dados( find(dados(:, 42)==0),  :);
saida = [dadosPos(:, 42); dadosNeg(:, 42)];

%separa os dados entre saidas positivas e negativas e ordena eles
dadosPos = dadosPos(:, 1:41);
dadosNeg = dadosNeg(:, 1:41);
dados2 = [dadosPos;dadosNeg];


%normaliza os dados
%sigmoided = zscore(dados2);
sigmoided= normalizacao(dados2);

%PCA
[COEFF, SCORE, LATENT, TSQUARED] = princomp(sigmoided);

% matriz para ajudar a visualizar o quanto cada variável
% ajuda no problema
v1 = cumsum(ones(41, 1));
v2 = cumsum(LATENT./sum(LATENT) * 100);
v3 = LATENT./sum(LATENT) * 100;
visualizacao = [v1, v2, v3];

% isso mostrou que podemos pular de
% 41 para 26 variáveis
% (índice de 99.00% de importância)

% boxplot para analise estatística
analiseboxplot = boxplot(SCORE,'orientation','vertical','labels',visualizacao(:, 1),'plotstyle','traditional');
locaiscomoutlier = []
analisedequantidade = []
analisedasalvacao = []

for i = 1:26
    
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    testando = size(find((analisedelinha < 0)));
    testando2 = size(find((analisedelinha > 0)));
    analisedasalvacao = [analisedasalvacao; i, size(analisedelinha, 2), testando(1,2), testando2(1,2)];
    
end

analisedasalvacao

%limpeza personalizada
%i igual a 3 porquê 1 e 2 não tem outliers
for i = 3:5
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    limite = size(listadeoutliers, 1);
    
    for j = 1:limite
        %prealocar?
        posicao = find(SCORE(:, i) == listadeoutliers(j));
        locaiscomoutlier = [locaiscomoutlier; posicao];
    end
end

%na sexta variável, temos apenas um outlier mesmo, maior que zero
for i = 6:6
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    listadeoutliers = max(listadeoutliers);
    posicao = find(SCORE(:, i) == listadeoutliers);
    locaiscomoutlier = [locaiscomoutlier; posicao];
end

%na nona variável, temos dois outliers mesmo
for i = 9:9
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    listadeoutliers1 = max(listadeoutliers);
    listadeoutliers2 = min(listadeoutliers);
    posicao = find(SCORE(:, i) == listadeoutliers1);
    locaiscomoutlier = [locaiscomoutlier; posicao];
    posicao = find(SCORE(:, i) == listadeoutliers2);
    locaiscomoutlier = [locaiscomoutlier; posicao];
end

%13, cortar tudo
for i = [13]
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    limite = size(listadeoutliers, 1);
    
    for j = 1:limite
        %prealocar?
        posicao = find(SCORE(:, i) == listadeoutliers(j));
        locaiscomoutlier = [locaiscomoutlier; posicao];
    end
end

%15, cortar um outlier real
for i = 15:15
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    listadeoutliers = max(listadeoutliers);
    posicao = find(SCORE(:, i) == listadeoutliers);
    locaiscomoutlier = [locaiscomoutlier; posicao];
end

%16 e 17, cortar dois outliers, um em cada
for i = 16:17
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    listadeoutliers1 = min(listadeoutliers);
    posicao = find(SCORE(:, i) == listadeoutliers1);
    locaiscomoutlier = [locaiscomoutlier; posicao];
end

%cortar todos no 19 a 20
for i = 19:20
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    limite = size(listadeoutliers, 1);
    
    for j = 1:limite
        %prealocar?
        posicao = find(SCORE(:, i) == listadeoutliers(j));
        locaiscomoutlier = [locaiscomoutlier; posicao];
    end
end

%no 21, 22 e 23, cortar apenas um e deixar o resto de lado no 24 a 26
for i = 21:21
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    listadeoutliers1 = max(listadeoutliers);
    posicao = find(SCORE(:, i) == listadeoutliers1);
    locaiscomoutlier = [locaiscomoutlier; posicao];
end

for i = 22:22
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    listadeoutliers1 = min(listadeoutliers);
    posicao = find(SCORE(:, i) == listadeoutliers1);
    locaiscomoutlier = [locaiscomoutlier; posicao];
end

for i = 23:23
    analisedelinha = get(analiseboxplot(7, i), 'YData');
    listadeoutliers = analisedelinha';
    listadeoutliers1 = max(listadeoutliers);
    posicao = find(SCORE(:, i) == listadeoutliers1);
    locaiscomoutlier = [locaiscomoutlier; posicao];
end


%para análise estatistica posterior dos outliers
outliersorganizados = sortrows(locaiscomoutlier);


%para cada entrada, uma posição de outlier apenas, sem repetições
outliersfiltrados = outliersorganizados;


continua = 1;
i = 1;
while continua
    tamanho = size(outliersfiltrados, 1);
    if (outliersfiltrados(i,1) == outliersfiltrados(i+1,1))
       if i < tamanho - 1
           outliersfiltrados = [outliersfiltrados(1:i, 1); outliersfiltrados(i+2:tamanho, 1)];
       else
           outliersfiltrados = outliersfiltrados(1:i, 1);
       end
    else
        i = i + 1;
    end
    tamanho = size(outliersfiltrados, 1);
    if i >= tamanho
        continua = 0;
    end

end

fim = size(outliersfiltrados,1)

tamfinal = 1055;
%melhorar aqui
for i = 0:fim-1
    
    antes = outliersfiltrados(fim - i, 1) - 1;
    depois =  outliersfiltrados(fim - i, 1) + 1;
    SCORE = [SCORE(1:antes, :);SCORE(depois:tamfinal, :)];
    saida = [saida(1:antes, :);saida(depois:tamfinal, :)];
    tamfinal = tamfinal - 1;
    
end

%pegando os valores mais significativos.
visualizacaoutil = visualizacao(1:18, :);
entradas = SCORE(:, 1:18);




%inicializando a rede...
rede = patternnet([25]);
%rede = patternnet([25 10], 'trainlm');
%rede = patternnet([25], 'trainrp');
%rede = patternnet([25], 'traingd');
%rede = patternnet([25], 'traingdx');


%rodando o treino da rede
rede = train(rede, SCORE', saida')
%rede = train(rede, SCORE(:, 1:12)', saida')

%Dúvida 1:
% Como ler o histograma de erro?