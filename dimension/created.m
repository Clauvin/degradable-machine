function D = created(RL,dv,Din,DNames)
% CREATED create D matrix for a given relevance list
%  D = CREATED(RL,DV,Din,DVars) where RL is a valid
%  relevance list, DV a cell array of strings with
%  the names of the dependent variables, Din is the
%  planned D-Matrix for the variables DNames. The
%  contents of DNames and dv must be equal but can
%  be in different ordering.

% Dimensional Analysis Toolbox for Matlab
% Steffen Brueckner, 2002-02-11

% -----------------------------------------
% VERSION HISTORY
% -----------------------------------------
% V 1.01 2002-02-14 strmatch changed to 'exact'
% -----------------------------------------


% check input arguments
msg = nargchk(4,4,nargin);
if msg
    error(msg);
end
if length(dv) ~= length(DNames)
    error('DV and DNAMES must be of equal length');
end

% reorder DNames for the order of dv
for ii=1:length(dv)
    %jj = strmatch(dv{ii},DNames);  % pre 1.01
    jj = strmatch(dv{ii},DNames,'exact');
    if isequal(jj,[])
        error([' variables ' dv{ii} ' not found in DNAMES']);
        return;
    end
    D(:,ii) = Din(:,jj);
end
