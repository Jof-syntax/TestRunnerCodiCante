classdef GliderAnalyser < handle
    
    properties (Access = public)
        safety
    end
    
    properties (Access = private)
        cParams
        data
        result
        dynamicSolver
    end
    
    methods (Access = public)
        
        function obj = GliderAnalyser(cParams)
            obj.init(cParams);
            obj.create();
        end
        
        function compute(obj)
            obj.computeDynamicSolver();
            obj.computeResultComputer();
        end
        
        function plot(obj)
            obj.computePlot();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.cParams = cParams;
        end
        
        function create(obj)
            s = obj.createGliderData();
            d = GliderData(s);
            d.compute();
            obj.data = d.data;
        end
        
        function computeDynamicSolver(obj)
            s = obj.createDynamicSolver();
            ds = DynamicSolver(s);
            ds.compute();
            obj.dynamicSolver.stress        = ds.stress;
            obj.dynamicSolver.criticStress  = ds.criticStress;
            obj.dynamicSolver.displacement  = ds.displacement;
        end
        
        function computeResultComputer(obj)
            s = obj.createResultComputer();
            r = ResultComputer(s);
            r.compute();
            obj.result = r;
            obj.safety = r.safety;
        end
        
        function computePlot(obj)
            r = obj.result;
            r.plot();
        end
        
        function s = createGliderData(obj)
            s.gust         = obj.cParams.gust;
            s.pilotWeight  = obj.cParams.pilotWeight;
        end
        
        function s = createDynamicSolver(obj)
            s.dim           = obj.data.dim;
            s.mass          = obj.data.mass;
            s.mat           = obj.data.mat;
            s.tMat          = obj.data.tMat;
            s.tN            = obj.data.tN;
            s.x             = obj.data.x;
            s.geometry      = obj.data.geometry;
            s.fixNode       = obj.data.fixNode;
            s.gust          = obj.data.gust;
            s.g             = obj.data.g;
            s.fExterior     = obj.data.fExterior;
            s.pilotWeight   = obj.data.pilotWeight;
            s.type          = obj.cParams.type;
        end
        
        function s = createResultComputer(obj)
            s.x             = obj.data.x;
            s.tN            = obj.data.tN;
            s.displacement  = obj.dynamicSolver.displacement;
            s.criticStress  = obj.dynamicSolver.criticStress;
            s.stress        = obj.dynamicSolver.stress;
            s.dim           = obj.data.dim;
        end
        
    end
end