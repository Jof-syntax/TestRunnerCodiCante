classdef CheckSafety < handle
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        
        function obj = CheckSafety(cParams)
            obj.init(cParams);
        end

        function Safety = compute(obj)
            Safety = obj.computeSafety();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function safety = computeSafety(obj)
            criticStress    = obj.data.criticStress;
            stress          = obj.data.stress;
            dim             = obj.data.dim;
            safety = zeros(dim.nel, 2);
            for e = 1:dim.nel
                safety(e,1) = e;
                if stress(e)<0
                    if criticStress(e) > abs(stress(e))
                        safety(e,2) = 0;
                    else
                        safety(e,2) = 1;
                    end
                end
            end
        end
        
    end
    
end

