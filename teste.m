

dados=csvread("dados.csv")
dadosPos= dados( find( dados(:, 42)==1),  :) )
dadosNeg= dados( find( dados(:, 42)==-1),  :) )





tamPos=size(dadosPos, 1)
tamNeg=size(dadosNeg, 1)

%Mean of each class
mu1=mean(dadosPos)
mu2=mean(dadosNeg)


% Average of the mean of all classes
mu=(mu1+mu2)/3

% Center the data (data-mean)
d1=c1-repmat(mu1,size(c1,1),1)
d2=c2-repmat(mu2,size(c2,1),1)


% Calculate the within class variance (SW)
s1=d1'*d1
s2=d2'*d2
s3=d3'*d3
sw=s1+s2+s3
invsw=inv(sw)

% in case of two classes only use v
% v=invsw*(mu1-mu2)'

% if more than 2 classes calculate between class variance (SB)
sb1=n1*(mu1-mu)'*(mu1-mu)
sb2=n2*(mu2-mu)'*(mu2-mu)
sb3=n3*(mu3-mu)'*(mu3-mu)
SB=sb1+sb2+sb3
v=invsw*SB

% find eigne values and eigen vectors of the (v)
[evec,eval]=eig(v)
