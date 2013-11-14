% Eval virou evall porquê não queremos problemas com o usuário do QtOctave.

function [evec1, evall1]=ldaMatLAB(dadosPos, dadosNeg)

tamPos=size(dadosPos, 1);
tamNeg=size(dadosNeg, 1);

%Por livre e espontânea chateação, não teremos 1 = P e 2 = N
% TODO

%Mean of each class
mu1=mean(dadosPos);
mu2=mean(dadosNeg);


% Average of the mean of all classes
mu=(mu1+mu2)/2;

% Center the data (data-mean)
d1= dadosPos - repmat(mu1, tamPos, 1);
d2= dadosNeg - repmat(mu2, tamNeg, 1);


% Calculate the within class variance (SW)
s1=(d1')*d1;
s2=(d2')*d2;
sw=s1+s2;
invsw=inv(sw);

% in case of two classes only use v
% v N�O � QUADRADO
% v=invsw*(mu1-mu2)';

% if more than 2 classes calculate between class variance (SB)

sb1=tamPos*(mu1-mu)'*(mu1-mu);
sb2=tamNeg*(mu2-mu)'*(mu2-mu);
SB=sb1+sb2;
v1=invsw*SB;

% find eigne values and eigen vectors of the (v)

%[evec,evall]=eig(v);
[evec1,evall1]=eig(v1);