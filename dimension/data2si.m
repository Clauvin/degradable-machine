function Xout = data2si(Xin,RL)
% DATA2SI transform data to SI units
%  Y = DATA2SI(X,RL) transforms the data in matrix
%  X (rows corresponding to variables) into basic
%  SI units using the factor given in the relevance
%  list RL

% Steffen Brückner, 2002-02-14

% check input arguments
msg = nargchk(2,2,nargin);
if msg
    error(msg);
    return;
end

if length(RL) ~= size(Xin,1)
    error('relevance list and data matrix inconsistent');
end

% transform the data
for ii=1:length(RL)
    Xin(ii,:) = Xin(ii,:) .* RL(ii).Factor;
end

Xout = Xin;