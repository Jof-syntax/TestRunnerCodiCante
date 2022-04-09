classdef DynamicSolver < handle

    properties (Access = public)
        displacement
        stress
        criticStress
    end

    properties (Access = private)
        data
    end

    methods (Access = public)

        function obj = DynamicSolver(cParams)
            obj.init(cParams);
        end

        function compute(obj)
            obj.computeForces();
            obj.computeStiffnessMatrix();
            obj.computeDisplacement();
            obj.computeStress();
        end

    end

    methods (Access = private)

        function init(obj, cParams)
            obj.data = cParams;
        end

        function computeStiffnessMatrix(obj)
            s = obj.createStiffnessMatrixComputer();
            a = StiffnessMatrixComputer(s);
            a.compute();
            obj.data.KG = a.KG;
            obj.data.tD = a.tD;
        end

        function computeForces(obj)
            s = obj.createForcesComputer();
            a = ForcesComputer(s);
            a.compute();
            obj.data.forces = a.forces;
        end

        function computeDisplacement(obj)
            s = obj.createDisplacementComputer();
            a = DisplacementComputer(s);
            a.compute();
            obj.displacement = a.displacement;
        end

        function computeStress(obj)
            s = obj.createStressComputer();
            a = StressComputer(s);
            a.compute();
            obj.stress          = a.stress;
            obj.criticStress    = a.criticStress;
        end
        
        function s  = createStiffnessMatrixComputer(obj)
            s.dim   = obj.data.dim;
            s.tN    = obj.data.tN;
            s.x     = obj.data.x;
            s.mat   = obj.data.mat;
            s.tMat  = obj.data.tMat;
        end

        function s = createForcesComputer(obj)
            s.fExterior     = obj.data.fExterior;
            s.mat           = obj.data.mat;
            s.tMat          = obj.data.tMat;
            s.dim           = obj.data.dim;
            s.g             = obj.data.g;
            s.x             = obj.data.x;
            s.tN            = obj.data.tN;
            s.pilotWeight   = obj.data.pilotWeight;
            s.g             = obj.data.g;
            s.mass          = obj.data.mass;
            s.W             = obj.data.geometry.W;
            s.H             = obj.data.geometry.H;
            s.gust          = obj.data.gust;
        end

        function s = createDisplacementComputer(obj)
            s.type          = obj.data.type;
            s.dim           = obj.data.dim;
            s.fixNode       = obj.data.fixNode;
            s.KG            = obj.data.KG;
            s.forces        = obj.data.forces;
        end
        
        function s = createStressComputer(obj)
            s.tD            = obj.data.tD;
            s.displacement  = obj.displacement;
            s.mat           = obj.data.mat;
            s.tMat          = obj.data.tMat;
            s.dim           = obj.data.dim;
            s.tN            = obj.data.tN;
            s.x             = obj.data.x;
        end

    end
end

