classdef MatrixAndVectorSplitter < handle
    
    properties (Access = public)
        fExtL
        KLL
        KLR
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        
        function obj = MatrixAndVectorSplitter(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.computeSplitter();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function computeSplitter(obj)
            KG = obj.data.KG;
            forces = obj.data.forces;
            vr = obj.data.vr;
            vl = obj.data.vl;
            fExtL = forces(vl,1);
            KLL = KG(vl,vl);
            KLR = KG(vl,vr);
            obj.fExtL   = fExtL;
            obj.KLL     = KLL;
            obj.KLR     = KLR;
        end
        
    end
end

