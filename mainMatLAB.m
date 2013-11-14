dados=csvread('dados.csv')
dadosPos= dados( find(dados(:, 42)==1),  :);
dadosNeg= dados( find(dados(:, 42)==-1),  :);
dadosPos = dadosPos(:, 1:41);
dadosNeg = dadosNeg(:, 1:41);
pos = 1;
neg = -1;
[sigmoid]= normalizacao(dados);
[evec, evall] = ldaMatLAB(dadosPos , dadosNeg);
diag(evall);