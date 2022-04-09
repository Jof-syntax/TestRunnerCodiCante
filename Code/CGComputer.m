classdef CGComputer < handle
    
    properties (Access = public)
        cg
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        function obj = CGComputer(cParams)
            obj.init(cParams);
            
        end
        
        function a = compute(obj)
            obj.cg = obj.computeCG();
            a = obj.cg;
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function cg = computeCG(obj)
            conservativeForces = obj.data.conservativeForces;
            pilotWeight = obj.data.pilotWeight;
            dim = obj.data.dim;
            g = obj.data.g;
            x = obj.data.x;
            mass = obj.data.mass;
            cg = zeros(3,1);
            cx = 0;
            cy = 0;
            cz = 0;
            for i = 1:dim.nnod
                cx = cx+x(i,1)*abs(conservativeForces(i*dim.ni,3));
                cy = cy+x(i,2)*abs(conservativeForces(i*dim.ni,3));
                cz = cz+x(i,3)*abs(conservativeForces(i*dim.ni,3));
            end
            gW = (mass+pilotWeight)*g;
            cg(1) = cx/gW;
            cg(2) = cy/gW;
            cg(3) = cz/gW;
        end
        
    end
    
end