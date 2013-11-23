dados=csvread('dados.csv');
dadosPos= dados( find(dados(:, 42)==1),  :);
dadosNeg= dados( find(dados(:, 42)==-1),  :);
dadosPos = dadosPos(:, 1:41);
dadosNeg = dadosNeg(:, 1:41);
dados2 = [dadosPos;dadosNeg];
%o fruto de pouco sono .-.
swap = dados2(:, 2);
swap2 = dados2(:, 1);
dados2(:, 1) = swap;
dados2(:, 2) = swap2;

%[sigmoided]= normalizacao(dados2);
sigmoided2 = zscore(dados2);
%resultado = princomp(sigmoided);
[COEFF, SCORE, LATENT, TSQUARED] = princomp(sigmoided2);

pos = 1;
neg = -1;

%[evec, evall] = ldaMatLAB(dadosPos , dadosNeg);
%diag(evall);