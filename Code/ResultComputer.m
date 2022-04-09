classdef ResultComputer < handle
    
    properties (Access = public)
        safety
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        
        function obj = ResultComputer(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.safety = obj.computeCheckSafety();
        end
        
        function plot(obj)
            obj.computePlot();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function safety = computeCheckSafety(obj)
            s = obj.createCheckSafety();
            saf = CheckSafety(s);
            safety = saf.compute();
        end
        
        function computePlot(obj)
            s = obj.createPlotBarStress();
            p = PlotBarStress(s);
            p.compute();
        end
        
        function s = createCheckSafety(obj)
            s.criticStress  = obj.data.criticStress;
            s.stress        = obj.data.stress;
            s.dim           = obj.data.dim;
        end
        
        function s = createPlotBarStress(obj)
            s.x                 = obj.data.x;
            s.tN                = obj.data.tN;
            s.displacement      = obj.data.displacement;
            s.stress            = obj.data.stress;
        end
        
    end
end

