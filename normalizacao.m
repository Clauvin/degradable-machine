function [sigmoid]= normalizacao(dados)
	variancia=var(dados);
	media=mean(dados);
	sigmoid = dados;

	%substituir por zscore ou similar
	variancia = repmat(variancia, [1055 1]);
	media = repmat(media, [1055 1]);
	sigmoid = sigmoid - media;
	sigmoid = sigmoid./variancia;
	sigmoid = 1 + exp(-sigmoid);
	sigmoid = 1./sigmoid;
end