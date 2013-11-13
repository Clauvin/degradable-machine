function dv = getdv(RL,bv)
% GETDV get list of dependent variables
%   DV = GETDV(RL,BV) gets the dependent
%   variables DV from a relevance list RL
%   with the base variables BV

% Dimensional Analysis Toolbox for Matlab
% Steffen Brückner, 2002-02-11

dv = {};
for ii=1:length(RL)
    jj = strmatch(RL(ii).Name,bv);
    if isempty(jj)
        dv{end+1} = RL(ii).Name;
    end
end