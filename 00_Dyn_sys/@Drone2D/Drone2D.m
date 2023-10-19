classdef Drone2D < DynSys
  properties
    % Angle bounds
    angleRange
    
    speed % Constant speed
    
    % Disturbance
    dRange
    
    % Dimensions that are active
    dims
  end
  
  methods
    function obj = Drone2D(x, angleRange, speed, dRange, dims)
      % obj = Drone2D(x, wMax, speed, dMax, dims)
      %
      % Dynamics:
      %    \dot{x}_1 = v * cos(u) + d1
      %    \dot{x}_2 = v * sin(u) + d2
      %    
      %         u \in [-angleMax, angleMax]
      %         d \in [-dMax, dMax]
      %
      % Inputs:
      %   x      - state: [xpos; ypos]
      %   
      %   v - speed
      %   dMax   - disturbance bounds
      
      if numel(x) ~= obj.nx
        error('Initial state does not have right dimension!');
      end
      
      if ~iscolumn(x)
        x = x';
      end
      
      if nargin < 2
        angleRange = [-pi()/2; pi()/2];
      end
      
      if nargin < 3
        speed = 1;
      end
      
      if nargin < 4
        dRange = [-0.5;0.5];
      end
      
      if nargin < 5
        dims = 1:2;
      end
      
      if numel(angleRange) <2
          angleRange = [-angleRange; angleRange];
      end
      
      if numel(dRange) <2
          dRange = [-dRange,dRange];
      end
      
      % Basic vehicle properties
      obj.pdim = [find(dims == 1) find(dims == 2)]; % Position dimensions
      
      obj.nx = length(dims);
      obj.nu = 1;
      obj.nd = 2;
      
      obj.x = x;
      obj.xhist = obj.x;
      
      obj.angleRange = angleRange;
      obj.speed = speed;
      obj.dRange = dRange;
      obj.dims = dims;
    end
    
  end % end methods
end % end classdef
