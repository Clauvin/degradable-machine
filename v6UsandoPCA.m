%leu dados
dados=csvread('dados.csv');

%separou dados entre positivos e negativos
dadosPos= dados( find(dados(:, 42)==1),  :);
dadosNeg= dados( find(dados(:, 42)==-1),  :);
saida = [dadosPos(:, 42); dadosNeg(:, 42)];
saida(find(saida(:, 1)==-1), 1) = 0;

%separa os dados entre saidas positivas e negativas e ordena eles
dadosPos = dadosPos(:, 1:41);
dadosNeg = dadosNeg(:, 1:41);
dados2 = [dadosPos;dadosNeg];


%normaliza os dados
%sigmoided = zscore(dados2);
[sigmoided]= normalizacao(dados2);

%PCA
[COEFF, SCORE, LATENT, TSQUARED] = princomp(sigmoided);

% matriz para ajudar a visualizar o quanto cada vari�vel
% ajuda no problema
v1 = cumsum(ones(41, 1));
v2 = cumsum(LATENT./sum(LATENT) * 100);
v3 = LATENT./sum(LATENT) * 100;
visualizacao = [v1, v2, v3];

% isso mostrou que podemos pular de
% 41 para 18 vari�veis
% (�ndice de 91.11% de import�ncia)

% IMPORTANTE
% e como retiraremos os outliers?

% boxplot para analise estat�stica
boxplot(SCORE,'orientation','vertical','labels',visualizacao(:, 1))

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


%D�vida 1:
% Como ler o histograma de erro?