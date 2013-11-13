function [M,ind] = rmlindep(M,dim)
% RMLINDEP remove linear dependent rows or columns
%  [M,n] = RMLINDEP(M,DIM) removes linear dependent rows
%  (DIM = 1) or columns (DIM = 2) from the matrix M
%  The output argument ind is a logical index vector
%  for the conserved rows/columns

% Dimensional Analysis Toolbox for Matlab
% Steffen Brückner, 2002-02-09

% ===========================
% VERSION HISTORY
% ===========================
%  1.00  2002-02-09
% initial version
% ---------------------------
%  1.01  2002-02-18
% algorithm changed to use rank of the matrix
% to determine linear dependent rows
% ---------------------------

% check number of input arguments
msg = nargchk(1,2,nargin);
if msg
    error(msg);
    return;
end
if nargin < 2
    dim = 1;
end

if dim == 2
    M = M';
end

ind1 = 1:size(M,1);
while size(M,1) ~= rank(M)
    r = rank(M);
    for ii=size(M,1):-1:1
        M1 = M([1:ii-1 ii+1:size(M,1)],:);
        if rank(M1) == r    % rank has not changed -> linear dependent
            M = M1;
            ind1 = ind1([1:ii-1 ii+1:length(ind1)]);
            break;
        end
    end
end

ind = ones(size(M,1),1);
ind(ind1) = 0;
if dim == 2
    ind = ind';
end
