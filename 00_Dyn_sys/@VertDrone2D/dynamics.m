function dx = dynamics(obj, ~, x, u, d)

  %% For reachable set computations
  if iscell(x)
    dx = cell(2,1);  
    dx{1} = obj.k * u - obj.grav;
    dx{2} = x{1};
  end

  %% For simulations
  if isnumeric(x)
    dx = zeros(2,1);  
    dx(1) = obj.k * u - obj.grav;
    dx(2) = x(1);
  end

end