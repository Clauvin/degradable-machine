dados=csvread('dados.csv')
%a = [3 4 5;4 1 2;5 3 4];
%b = [-1 -2 -3; -3 -2 -1; -1 -1 -1];

dadosPos= dados( find(dados(:, 42)==1),  :);
dadosNeg= dados( find(dados(:, 42)==-1),  :);
dadosPos = dadosPos(:, 1:41);
dadosNeg = dadosNeg(:, 1:41);
possize = size(dadosPos,1);
negsize = size(dadosNeg,1);

dados2 = [dadosPos;dadosNeg];

[sigmoid]= normalizacao(dados2);

dadosPos = sigmoid(1:possize, :)
dadosNeg = sigmoid(possize+1:negsize, :)

pos = 1;
neg = -1;
[evec, evall] = ldaMatLAB(dadosPos, dadosNeg);
diag(evall);

entrada = sigmoid
saida = dados(:, 42)
net = patternnet()
net.numLayers = 2
train(net, entrada', saida')