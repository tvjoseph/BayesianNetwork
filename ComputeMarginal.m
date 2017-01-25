%ComputeMarginal Computes the marginal over a set of given variables
%   M = ComputeMarginal(V, F, E) computes the marginal over variables V
%   in the distribution induced by the set of factors F, given evidence E
%
%   M is a factor containing the marginal over variables V
%   V is a vector containing the variables in the marginal e.g. [1 2 3] for
%     X_1, X_2 and X_3.
%   F is a vector of factors (struct array) containing the factors 
%     defining the distribution
%   E is an N-by-2 matrix, each row being a variable/value pair. 
%     Variables are in the first column and values are in the second column.
%     If there is no evidence, pass in the empty matrix [] for E.


function M = ComputeMarginal(V, F, E)

% Check for empty factor list
if (numel(F) == 0)
      warning('Warning: empty factor list');
      M = struct('var', [], 'card', [], 'val', []);      
      return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE:
% M should be a factor
% Remember to renormalize the entries of M!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% M = struct('var', [], 'card', [], 'val', []); % Returns empty factor. Change this.
% Step 1 : Finding the joint distribution
M = ComputeJointDistribution(F); % Step 1 : Do the joint distribution over all the variables
% Step 2 : Reducing with respect to the evidence

M = ObserveEvidence(M,E); % Provide the factor and the evidence which is E

% Step 3 : Normalising after reduction

norm = sum(M.val); % Finding the normalization constant

M.val = M.val/norm ; % Getting the normalised value for the marginals

% Step 4 : Finding the marginals with respect to V

 mar = setdiff(M.var, V); % Finding the variable over which the marginalization has to be done

M = FactorMarginalization(M, mar); % Finding the marginal distribution


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
