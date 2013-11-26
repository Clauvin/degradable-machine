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

%PCA
%[COEFF, SCORE, LATENT, TSQUARED] = princomp(sigmoided);

%divide aleatoriamente o conjunto de dados nos 3 casos proporcional aos
%parametros
[treino, validacao, teste]=dividerand(size(dados, 1), 0.7, 0, 0.3);

svm = svmtrain(dados2(treino, :), saida(treino, :), 'kernel_function', 'polynomial');


resultTreino = svmclassify(svm, dados2(treino,:));
resultTeste = svmclassify(svm, dados2(teste,:));
resultGeral = svmclassify(svm, dados2);


plotconfusion(resultTreino', saida(treino, :)', 'Treino', resultTeste', saida(teste,:)', 'Teste', resultGeral', saida','Geral' );

%Sem Normalizar
%polinomial: 4- 93% 3- 95% 1- 86%
%rbf- 94%

%Normalizado
%rbf- 93
%3 - 93.9 4- 93% 1- 84% 2- 94%
