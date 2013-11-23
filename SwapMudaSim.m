%leu dados
dados=csvread('dados.csv');

%separou dados entre positivos e negativos
dadosPos= dados( find(dados(:, 42)==1),  :);
dadosNeg= dados( find(dados(:, 42)==-1),  :);

%separa os dados entre saidas positivas e negativas
dadosPos = dadosPos(:, 1:41);
dadosNeg = dadosNeg(:, 1:41);
dados2 = [dadosPos;dadosNeg];
dados3 = dados2;

swap = dados3(:, 10);
dados3(:, 10) = dados3(:, 1);
dados3(:, 1) = swap;

sigmoided = zscore(dados2)
%[sigmoided]= normalizacao(dados2);
sigmoided2 = zscore(dados3);
%resultado = princomp(sigmoided);
[COEFF, SCORE, LATENT, TSQUARED] = princomp(sigmoided);
[COEFF2, SCORE2, LATENT2, TSQUARED2] = princomp(sigmoided2);

SCORE(1,1) == SCORE2(1,1)

%[evec, evall] = ldaMatLAB(dadosPos , dadosNeg);
%diag(evall);