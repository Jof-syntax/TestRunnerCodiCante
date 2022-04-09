classdef GliderData < handle
    
    properties (Access = public)
        data
    end
    
    methods (Access = public)
        
        function obj = GliderData(cParams)
            obj.init(cParams);
            obj.create();
        end
        
        function compute(obj)
            obj.computeDimension();
            obj.computeGliderMass();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function create(obj)
            obj.createGeometry();
            obj.createMaterials();
            obj.createExternalInfluence();
        end
        
        function createGeometry(obj)
            g = GliderGeometry();
            obj.data.geometry   = g.geometry;
            obj.data.x          = g.x;
            obj.data.tN         = g.tN;
            obj.data.fixNode    = g.fixNode;
        end
        
        function createMaterials(obj)
            s = createGliderMaterial(obj);
            m = GliderMaterial(s);
            m.compute();
            obj.data.tMat = m.tMat;
            obj.data.mat = m.mat;
        end
        
        function createExternalInfluence(obj)
            s = obj.data;
            i = ExternalInfluence(s);
            obj.data.gust           = i.gust;
            obj.data.g              = i.g;
            obj.data.fExterior      = i.fExterior;
            obj.data.pilotWeight    = i.pilotWeight;
        end
        
        function computeDimension(obj)
            s = obj.createDimension();
            d = Dimension(s);
            d.compute();
            obj.data.dim = d.dim;
        end
        
        function computeGliderMass(obj)
            s = obj.createGliderMass();
            m = GliderMass(s);
            m.compute();
            obj.data.mass = m.mass;
        end
        
        function s  = createDimension(obj)
            s.x     = obj.data.x;
            s.tN    = obj.data.tN;
        end
        
        function s = createGliderMaterial(obj)
            s.geometry  = obj.data.geometry;
        end
        
        function s = createGliderMass(obj)
            s.dim = obj.data.dim;
            s.mat = obj.data.mat;
            s.tMat = obj.data.tMat;
            s.tN = obj.data.tN;
            s.x = obj.data.x;
        end
        
    end
    
end

