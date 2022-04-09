classdef Solver < handle
    
    properties (GetAccess = public, SetAccess = protected)
        solution
    end
    
    properties (Access = protected)
        A
        B
    end
    
    methods (Static, Access = public)
        
       function obj = create(cParams)
              obj = SolverFactory.create(cParams);
              obj.compute();
       end
        
    end
    
    methods (Access = protected)
        
        function init(obj,cParams)
            obj.A  = cParams.A;
            obj.B  = cParams.B;
        end
        
    end
    
    methods (Abstract, Access = protected)
        compute(obj);
    end
end

