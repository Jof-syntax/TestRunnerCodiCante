classdef SolverFactory < handle
    
    methods (Access = public, Static)
        
        function computeSolver = create(cParams) % la funcio es diu create
            switch cParams.type
                case 'direct'
                    computeSolver = DirectSolver(cParams);
                case 'iterative'
                    computeSolver = IterativeSolver(cParams);
                otherwise
                    error('Invalid solver type.');
            end
        end
        
    end
end

