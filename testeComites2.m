%leu dados
dados=csvread('dados.csv');

%separou dados entre positivos e negativos
dadosPos= dados( find(dados(:, 42)==1),  :);
dadosNeg= dados( find(dados(:, 42)==0),  :);
saida = [dadosPos(:, 42); dadosNeg(:, 42)];

%separa os dados entre saidas positivas e negativas e ordena eles
dadosPos = dadosPos(:, 1:41);
dadosNeg = dadosNeg(:, 1:41);
dados2 = [dadosPos;dadosNeg];


%normaliza os dados

dados2 = normalizacao(dados2);

[COEFF, SCORE, LATENT, TSQUARED] = princomp(dados2);

% matriz para ajudar a visualizar o quanto cada vari�vel
% ajuda no problema
v1 = cumsum(ones(41, 1));
v2 = cumsum(LATENT./sum(LATENT) * 100);
v3 = LATENT./sum(LATENT) * 100;
visualizacao = [v1, v2, v3];

% isso mostrou que podemos pular de
% 41 para 26 vari�veis
% (�ndice de 99.00% de import�ncia)

entradas = SCORE(:, 1:26);

%divide aleatoriamente o conjunto de dados nos 3 casos proporcional aos
%parametros
[treino, validacao, teste]= dividerand(size(dados, 1), 0.7, 0, 0.3);

[ redes, mse ] = geraClassificadores(entradas(treino, :), saida(treino, :), 50, 200);

selecao = selecaoComite( redes, entradas(treino, :), saida(treino, :), mse, 1);

resultTreino = round( comite( selecao, entradas(treino, :) ) );
resultTeste  = round( comite( selecao, entradas(teste, :) ) );
resultGeral  = round( comite( selecao, entradas ) );

plotconfusion(resultTreino, saida(treino, :)', 'Treino', resultTeste, saida(teste,:)', 'Teste', resultGeral, saida','Geral' );
