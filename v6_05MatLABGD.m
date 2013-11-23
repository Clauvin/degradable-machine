%leu dados
dados=csvread('dados.csv');

%separou dados entre positivos e negativos
dadosPos= dados( find(dados(:, 42)==1),  :);
dadosNeg= dados( find(dados(:, 42)==-1),  :);
saida = [dadosPos(:, 42); dadosNeg(:, 42)];
saida(find(saida(:, 1)==-1), 1) = 0;

%separa os dados entre saidas positivas e negativas
dadosPos = dadosPos(:, 1:41);
dadosNeg = dadosNeg(:, 1:41);
dados2 = [dadosPos;dadosNeg];


%sigmoided = zscore(dados2);
%sigmoided = dados2;
[sigmoided]= normalizacao(dados2);
%resultado = princomp(sigmoided);
[COEFF, SCORE, LATENT, TSQUARED] = princomp(sigmoided);

%------------------
%E aqui, Gabriel, voc� vai ter que caminhar comigo:
% pressupondo que o swap causa sim mudan�as,
% mas MUITO pequenas(n�o fiz swaps em massa para testar),
% (mas o SwapMudaSim.m demonstra que sim, s�o diferentes)
% ent�o � poss�vel trabalhar em cima do SCORE
% que s�o nossos valores do problema, s� que nas novas
% coordenadas geradas pelo PCA. Portanto...

% matriz para ajudar a visualizar o quanto cada vari�vel
% ajuda no problema
v1 = cumsum(ones(41, 1));
v2 = cumsum(LATENT./sum(LATENT) * 100);
v3 = LATENT./sum(LATENT) * 100;
visualizacao = [v1, v2, v3]

% isso mostra que podemos pular de
% pulamos de 41 para 18 vari�veis
% (�ndice de 91.11% de import�ncia)

% s� que eu n�o pensei nos outliers.

% vejamos se encontramos algum...
% ok, voc� est� vendo o mesmo gr�fico que eu
% temos MUITOS outliers.
% Ou contamos eles individualmente
% (N�������O)
% Ou analisamos a coluna para remover as linhas com outliers

boxplot(SCORE,'orientation','vertical','labels',visualizacao(:, 1))

% eu vou ignorar por ora os outliers,
% deve ter alguma fun��o no MatLAB pra retir�-los.

%lembrando, a saida foi definida L� em cima.
visualizacaoutil = visualizacao(1:18, :);
entradas = SCORE(:, 1:18);

%hm...

%colocar nome depois
rede = patternnet([25], 'traingd');
rede = train(rede, SCORE', saida');


%[evec, evall] = ldaMatLAB(dadosPos , dadosNeg);
%diag(evall);

%D�vida 1:
% Como ler o histograma de erro?