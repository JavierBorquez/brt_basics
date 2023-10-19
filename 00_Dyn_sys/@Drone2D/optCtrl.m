function uOpt = optCtrl(obj, ~, ~, deriv, uMode)
% uOpt = optCtrl(obj, t, y, deriv, uMode)

%% Input processing
if nargin < 5
  uMode = 'max';
end

if ~iscell(deriv)
  deriv = num2cell(deriv);
end

%% Optimal control
ang=atan2(deriv{obj.dims==2},deriv{obj.dims==1});

if strcmp(uMode, 'max')
  if ((ang< obj.angleRange(2))& (ang> obj.angleRange(1)))
    uOpt = ang;
  else
    uOpt = (obj.angleRange(2))*sign(ang);  
  end
elseif strcmp(uMode, 'min')
  if (abs(ang)> pi()- obj.angleRange(2))  
    uOpt = ang-pi();
  else
    uOpt = -(obj.angleRange(2))*sign(ang);  
  end
else
  error('Unknown uMode!')
end

end