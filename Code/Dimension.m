classdef Dimension < handle
    
    properties (Access = public)
        dim
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        
        function obj = Dimension(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.dim = obj.computeDim;
        end 
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function dim = computeDim(obj)
            x = obj.data.x;
            tN = obj.data.tN;
            dim.nd = size(x,2);
            dim.nel = size(tN,1);
            dim.nnod = size(x,1);
            dim.nne = size(tN,2);
            dim.ni = 3;
            dim.ndof = dim.nnod*dim.ni;
        end
        
    end
end

