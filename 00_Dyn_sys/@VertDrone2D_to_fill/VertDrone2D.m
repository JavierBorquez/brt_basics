classdef VertDrone2D < DynSys
  properties    
     

    
  end
  
  methods
    function obj = VertDrone2D(x, grav, k, uRange)

      if numel(x) ~= obj.nx
        error('Initial state does not have right dimension!');
      end
      
      if ~iscolumn(x)
        x = x';
      end
         
      % Basic vehicle properties
           
      obj.nx = 2;   %num states
      obj.nu = 1;   %num of control inputs
      obj.nd = 0;   %num of disturbance inputs
      
      obj.x = x;          %set initial state
      obj.xhist = obj.x;  %start history at initial state
      
      %assign values to obj properties
      
    end
    
  end % end methods
end % end classdef
