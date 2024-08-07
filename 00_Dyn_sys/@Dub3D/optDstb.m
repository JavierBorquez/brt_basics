function dOpt = optDstb(obj, ~, ~, deriv, dMode)
% dOpt = optCtrl(obj, t, y, deriv, dMode)

%% Input processing
if nargin < 5
  dMode = 'max';
end

if ~iscell(deriv)
  deriv = num2cell(deriv);
end

dOpt = cell(obj.nd, 1);

%% Optimal control

ang=atan2(deriv{obj.dims==2},deriv{obj.dims==1});

if strcmp(dMode, 'max')
     dOpt{1} = (obj.d_bar).*cos(ang);
     dOpt{2} = (obj.d_bar).*sin(ang);
   
elseif strcmp(dMode, 'min')    
    dOpt{1} = (obj.d_bar).*cos(ang-pi);
    dOpt{2} = (obj.d_bar).*sin(ang-pi);
   
else
  error('Unknown dMode!')
end


end