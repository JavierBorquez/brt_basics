function dOpt = optDstb(obj, ~, ~, deriv, dMode)
% dOpt = optDstb(obj, t, y, deriv, dMode)

%% Input processing
if nargin < 5
  dMode = 'max';
end

if ~iscell(deriv)
  deriv = num2cell(deriv);
end

dOpt = cell(obj.nd, 1);

%% Optimal control

if strcmp(dMode, 'max')
   dOpt=0;   
elseif strcmp(dMode, 'min')    
   dOpt=0;   
else
  error('Unknown dMode!')
end

end