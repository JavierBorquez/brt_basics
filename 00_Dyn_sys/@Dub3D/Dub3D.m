classdef Dub3D < DynSys
  properties
    % Angle bounds
    wRange
    
    speed % Constant speed
    
    % Disturbance
    d_bar
    
    % Dimensions that are active
    dims
  end
  
  methods
      function obj = Dub3D(x, speed, wRange, d_bar, dims)
% obj = Drone3D(x, speed, wRange, d_bar, dims)
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
      %         
      % Inputs:
      %   x      - state: [xpos; ypos]
      %   v - speed
      %   wRange - angular speed range
      %   d_bar - disturbance magnitude

      
      if numel(x) ~= obj.nx
        error('Initial state does not have right dimension!');
      end
      
      if ~iscolumn(x)
        x = x';
      end
      
      if nargin < 2
        speed = 1;
      end
      
       if nargin < 3
        wRange=1;
      end
      
      if nargin < 4
        d_bar=0;
      end
      
      if nargin < 5
        dims = 1:3;
      end
      
      if numel(wRange) <2
          wRange = [-wRange; wRange];
      end
                 
      % Basic vehicle properties
      obj.pdim = [find(dims == 1) find(dims == 2)]; % Position dimensions
      %obj.hdim = find(dims == 3);   % Heading dimensions
      obj.nx = length(dims);
      obj.nu = 1;
      obj.nd = 2;
      
      obj.x = x;
      obj.xhist = obj.x;
      
      obj.speed = speed;
      obj.wRange = wRange;
      obj.d_bar = d_bar;
      obj.dims = dims;
    end
    
  end % end methods
end % end classdef
