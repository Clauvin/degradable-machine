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
%sigmoided = zscore(dados2);
sigmoided= normalizacao(dados2);

%PCA
%[COEFF, SCORE, LATENT, TSQUARED] = princomp(sigmoided);

%preparosvm = svmtrain(dados2, saida);
preparosvm = svmtrain(dados2, saida, 'kernel_function', 'rbf');
% ESSE ACIMA DEU 98%!!!! 0,9801!!! DEUS ABENÇOE!!!!

resultsvm = svmclassify(preparosvm, dados2);
percacerto = sum(resultsvm == saida)/size(dados, 1)