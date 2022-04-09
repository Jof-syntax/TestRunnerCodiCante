classdef DirectSolver < Solver
    
    methods (Access = public)
        
        function obj = DirectSolver(cParams)
            obj.init(cParams);
        end
        
    end
    
    methods (Access = protected)
        
        function obj = compute(obj)
            A = obj.A;
            B = obj.B;
            obj.solution = A\B;
        end
        
    end
    
end

