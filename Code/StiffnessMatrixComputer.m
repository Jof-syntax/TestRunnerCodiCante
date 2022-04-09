classdef StiffnessMatrixComputer < handle
    
    properties (Access = public)
        tD
        KG
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        
        function obj = StiffnessMatrixComputer(cParams)
            obj.init(cParams);
        end
        
        function a = compute(obj)
            Kel = obj.computeStiffnessBars();
            obj.tD = obj.computeConectDOF();
            obj.KG = obj.assemblyMatKG(Kel);
            a.tD = obj.tD;
            a.KG = obj.KG;
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function KG = assemblyMatKG(obj, Kel)
            dim = obj.data.dim;
            connec = obj.tD;
            KG = zeros(dim.ndof,dim.ndof);
            for iElem = 1:dim.nel
                for i = 1:dim.nne*dim.ni
                    I = connec(iElem,i);
                    for j = 1:dim.ni*dim.nne
                        J = connec(iElem,j);
                        KG(I,J) = KG(I,J)+Kel(i,j,iElem);
                    end
                end
            end
        end
        
        function tD = computeConectDOF(obj)
            dim = obj.data.dim;
            tN = obj.data.tN;
            tD = zeros(dim.nel,dim.nne*dim.ni);
            for iElem = 1:dim.nel
                for iNode = 1:dim.nne
                    for iDOF = 1:dim.ni
                        I = obj.nod2dof(iNode,iDOF,dim.ni);
                        node = tN(iElem,iNode);
                        dof = obj.nod2dof(node, iDOF, dim.ni);
                        tD(iElem,I)= dof;
                    end
                end
            end
        end
        
        function Kel = computeStiffnessBars(obj)
            dim = obj.data.dim;
            Kel = zeros(dim.nne*dim.ni,dim.nne*dim.ni,dim.nel);
            for iElem = 1:dim.nel
                Ke = obj.computeKe(iElem);
                for r = 1:dim.nne*dim.ni
                    for s = 1:dim.nne*dim.ni
                        Kel(r,s,iElem) = Ke(r,s);
                    end
                end
            end
        end
        
        function Ke = computeKe(obj, iElem)
            mat = obj.data.mat;
            tMat = obj.data.tMat;
            Ee = mat(tMat(iElem),1);
            Ae = mat(tMat(iElem),2);
            le = obj.computeLength(iElem);
            Ke = Ee*Ae/le*[1,-1; -1, 1];
            Re = obj.computeRe(le, iElem);
            Ke = Re'*Ke*Re;
        end
        
        function le = computeLength(obj, iElem)
            [x1, x2, y1, y2, z1, z2] = obj.computeCoordinates(iElem);
            le = sqrt((x2-x1)^2+(y2-y1)^2+(z2-z1)^2);
        end
        
        function  Re = computeRe(obj, le, iElem)
            [x1, x2, y1, y2, z1, z2] = obj.computeCoordinates(iElem);
            Re = 1/le*[x2-x1, y2-y1, z2-z1, 0, 0, 0;
                0, 0, 0, x2-x1, y2-y1, z2-z1];
        end
        
        function  [x1, x2, y1, y2, z1, z2] = computeCoordinates(obj, iElem)
            tN = obj.data.tN;
            x  = obj.data.x;
            x1 = x(tN(iElem,1),1);
            x2 = x(tN(iElem,2),1);
            y1 = x(tN(iElem,1),2);
            y2 = x(tN(iElem,2),2);
            z1 = x(tN(iElem,1),3);
            z2 = x(tN(iElem,2),3);
        end
        
    end
    
    methods (Access = private, Static)
        
        function I = nod2dof(i,j,ni)
            I = ni*(i-1)+j;
        end
        
    end
    
end

