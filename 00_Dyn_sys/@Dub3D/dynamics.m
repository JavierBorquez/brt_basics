function dx = dynamics(obj, ~, x, u, d)
% obj = Drone3D(x, speed, wRange, dims)
      %     Similar to DubinsCar with d_bar=mag(d1,d2) on xy and no
      %     dist on w
      %     
      % Dynamics:
      %    \dot{x}_1 = v * cos(x_3) + d1
      %    \dot{x}_2 = v * sin(x_3) + d2
      %    \dot{x}_3 = u
      % 
      %         u \in [-wMax, wMax]
      %         d \in d_bar=mag(d1,d2)       

if nargin < 5
  d = [0; 0];
end

if iscell(x)
  dx = cell(length(obj.dims), 1);
  
  for i = 1:length(obj.dims)
    dx{i} = dynamics_cell_helper(obj, x, u, d, obj.dims, obj.dims(i));
  end
else
  dx = zeros(obj.nx, 1);
  
  dx(1) = obj.speed * cos(x(3)) + d(1);
  dx(2) = obj.speed * sin(x(3)) + d(2);
  dx(3) = u;
 end
end

function dx = dynamics_cell_helper(obj, x, u, d, dims, dim)

switch dim
  case 1
    dx = obj.speed * cos(x{dims==3}) + d{1};
  case 2
    dx = obj.speed * sin(x{dims==3}) + d{2};
  case 3
    dx = u;
  otherwise
    error('Only dimension 1-3 are defined for dynamics of Drone3D!')
end
end