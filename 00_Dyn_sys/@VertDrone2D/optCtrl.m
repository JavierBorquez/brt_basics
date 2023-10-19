function uOpt = optCtrl(obj, ~, ~, deriv, uMode)
% uOpt = optCtrl(obj, t, y, deriv, uMode)

%% Input processing
if nargin < 5
  uMode = 'max';
end

if ~iscell(deriv)
  deriv = num2cell(deriv);
end

uOpt = cell(obj.nu, 1);

%% Optimal control

if strcmp(uMode, 'max')
  uOpt = (deriv{1}>=0)*(obj.uRange) + (deriv{1}<0)*(-obj.uRange);
elseif strcmp(uMode, 'min')
  error('min not implemeted yet')
else
  error('Unknown uMode!')
end

end