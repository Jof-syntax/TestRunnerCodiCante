classdef DisplacementComputer < handle
    
    properties  (Access = public)
        displacement
    end
    
    properties (Access = private)
        data
        unknownDisp
        dofSplitted
        KSplitted
        FSplitted
    end
    
    methods (Access = public)
        
        function obj = DisplacementComputer(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.computeDofSplitterComputer();
            obj.computeMatrixAndVectorSplitter();
            obj.computeSolver();
            obj.displacement = obj.computeDisplacementAssociation();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function computeDofSplitterComputer(obj)
            s = obj.createDofSplitterComputer();
            a = DOFSplitterComputer(s);
            a.compute();
            obj.dofSplitted = a;
        end
        
        function computeMatrixAndVectorSplitter(obj)
            s = obj.createMatrixAndVectorSplitter();
            a = MatrixAndVectorSplitter(s);
            a.compute();
            obj.KSplitted.KLL   = a.KLL;
            obj.KSplitted.KLR   = a.KLR;
            obj.FSplitted.fExtL = a.fExtL;
        end
        
        function computeSolver(obj)
            s = obj.createSolver();
            a = Solver.create(s);
            obj.unknownDisp = a.solution;
        end
        
        function u = computeDisplacementAssociation(obj)
            ul = obj.unknownDisp;
            vl = obj.dofSplitted.vl;
            vr = obj.dofSplitted.vr;
            ur = obj.dofSplitted.ur;
            u(vl,1) = ul;
            u(vr,1) = ur;
        end
             
        function B = computeB(obj)
            fExtL   = obj.FSplitted.fExtL;
            KLR     = obj.KSplitted.KLR;
            ur      = obj.dofSplitted.ur;
            B       = fExtL-KLR*ur;
        end
        
         function A = computeA(obj)
            A = obj.KSplitted.KLL;
        end
        
        function s = createDofSplitterComputer(obj)
            s.dim     = obj.data.dim;
            s.fixNode = obj.data.fixNode;
        end
        
        function s = createMatrixAndVectorSplitter(obj)
            s.KG        = obj.data.KG;
            s.forces    = obj.data.forces;
            s.vr        = obj.dofSplitted.vr;
            s.vl        = obj.dofSplitted.vl;
        end
        
        function s = createSolver(obj)
            s.A    = obj.computeA;
            s.B    = obj.computeB;
            s.type = obj.data.type;
        end
        
    end

end