classdef IterativeSolver < Solver

    methods (Access = public)
        
        function obj = IterativeSolver(cParams)
            obj.init(cParams);
        end
        
    end
    
    methods (Access = protected)
        
        function obj = compute(obj)
            A = obj.A;
            B = obj.B;
            obj.solution = pcg(A, B);
        end
        
    end

end