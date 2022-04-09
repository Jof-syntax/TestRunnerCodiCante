classdef ForcesComputer < handle
    
    properties (Access = public)
        forces
    end
    
    properties (Access = private)
        data
        cg
        conservativeForces
        Lift
        Drag
        Thrust
    end
    
    
    methods (Access = public)
        
        function obj = ForcesComputer(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.computeForces();
            obj.computeNodeForceComputer();
        end
        
    end
    
    methods (Access = private)
        
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function computeForces(obj)
            obj.computeConservativeForces();
            obj.computeCG();
            obj.computeNotConservativeForces();
        end
        
        function computeConservativeForces(obj)
            s = obj.createConservativeForcesComputer();
            a = ConservativeForcesComputer(s);
            a.compute();
            obj.conservativeForces = a.conservativeForces;
        end
        
        function computeCG(obj)
            s = createCGComputer(obj);
            a = CGComputer(s);
            a.compute();
            obj.cg = a.cg;
        end
        
        function computeNotConservativeForces(obj)
            s = createNotConservativeF(obj);
            a = NotConservativeForcesComputer(s);
            a.compute();
            obj.Lift    = a.Lift;
            obj.Drag    = a.Drag;
            obj.Thrust  = a.Thrust;
        end
        
        function computeNodeForceComputer(obj)
            s = obj.createNodeForceComputer();
            a = NodeForceComputer(s);
            a.compute();
            obj.forces = a.forces;
        end
        
        function s = createNotConservativeF(obj)
            s.data                    = obj.data;
            s.data.cg                 = obj.cg;
            s.data.conservativeForces = obj.conservativeForces;
        end
        
        function s = createCGComputer(obj)
            s.conservativeForces = obj.conservativeForces;
            s.pilotWeight        = obj.data.pilotWeight;
            s.dim                = obj.data.dim;
            s.g                  = obj.data.g;
            s.x                  = obj.data.x;
            s.mass               = obj.data.mass;
        end
        
        function s = createConservativeForcesComputer(obj)
            s = obj.data;
        end
        
        function s = createNodeForceComputer(obj)
            s.g             = obj.data.g;
            s.D             = obj.Drag;
            s.L             = obj.Lift;
            s.T             = obj.Thrust;
            s.mass          = obj.data.mass;
            s.pilotWeight   = obj.data.pilotWeight;
            s.mat           = obj.data.mat;
            s.tMat          = obj.data.tMat;
            s.dim           = obj.data.dim;
            s.tN            = obj.data.tN;
            s.fData         = obj.conservativeForces;
            s.x             = obj.data.x;
        end
        
    end
    
end

