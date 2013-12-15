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

%{
%limpando os outliers desses pontos mais significativos
agrupamentos = hist(dados2(:, 1), 11); % Histogram bin counts
N = max(agrupamentos); % Maximum bin count
mu3 = mean(agrupamentos); % Data mean
sigma3 = std(agrupamentos); % Data standard deviation

hist(agrupamentos) % Plot histogram
hold on
plot([mu3 mu3],[0 N],'r','LineWidth',2) % Mean
X = repmat(mu3+(1:2)*sigma3,2,1);
Y = repmat([0;N],1,2);
plot(X,Y,'g','LineWidth',2) % Standard deviations
legend('Data','Mean','Stds')
hold off
%}

% boxplot para analise estatística
olha = boxplot(SCORE,'orientation','vertical','labels',visualizacao(:, 1),'plotstyle','traditional')
findobj(gcf,'tag','Outliers');
lista = cumsum([ones(1,1055)])
% gname(lista')

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