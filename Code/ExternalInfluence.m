classdef ExternalInfluence < handle
    
    properties (Access = public)
        gust
        g
        fExterior
        pilotWeight
    end
    
    properties  (Access = private)
        data
    end
    
    methods  (Access = public)
        
        function obj = ExternalInfluence(cParams)
            obj.init(cParams);
            obj.compute();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function compute(obj)
            obj.pilotWeight= obj.computePilotWeight;
            obj.gust = obj.computeGust;
            obj.g = obj.computeG;
            obj.fExterior = obj.computeExteriorF();
        end
        
        
        function fExterior = computeExteriorF(obj)
            g = obj.g;
            pilotWeight = obj.pilotWeight;
            fExterior = [
                1, 3, -pilotWeight*g/2;
                2, 3, -pilotWeight*g/2;
                ];
        end
        
        function pilotWeight = computePilotWeight(obj)
            pilotWeight = obj.data.pilotWeight;
        end
        
        function gust = computeGust(obj)
            gust = obj.data.gust;
        end
        
    end
    
    methods    (Access = private, Static)
        
        function g = computeG()
            g = 9.81;
        end
        
    end
end


