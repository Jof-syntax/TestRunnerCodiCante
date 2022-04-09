classdef StressComputer < handle
    
    properties (Access = public)
        stress
        criticStress
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        
        function obj = StressComputer(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.stress = obj.computeStress();
            obj.criticStress = obj.computeCriticStress();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function sig = computeStress(obj)
            mat     = obj.data.mat;
            tMat    = obj.data.tMat;
            dim     = obj.data.dim;
            tD      = obj.data.tD;
            u       = obj.data.displacement;
            sig     = zeros(dim.nel,1);
            for iElem = 1:dim.nel
                le = obj.computeLength(iElem);
                Re = obj.computeRe(le, iElem);
                ue = zeros(dim.nne*dim.ni, 1);
                for i = 1:dim.nne*dim.ni
                    I = tD(iElem,i);
                    ue(i,1) = u(I);
                end
                ue = Re*ue;
                ep = 1/le*[-1, 1]*ue;
                Ee = mat(tMat(iElem),1);
                sig(iElem,1) = Ee*ep;
            end
        end
        
        function sigCri = computeCriticStress(obj)
            mat     = obj.data.mat;
            tMat    = obj.data.tMat;
            dim     = obj.data.dim;
            sigCri  = zeros(dim.nel,1);
            for iElem = 1:dim.nel
                Ee = mat(tMat(iElem),1);
                Ae = mat(tMat(iElem),2);
                Ie = mat(tMat(iElem),4);
                le = obj.computeLength(iElem);
                sigCri(iElem,1) = (pi^2*Ee*Ie) / (Ae*le^2);
            end
        end
        
        function le = computeLength(obj, iElem)
            [x1, x2, y1, y2, z1, z2] = obj.computeCoordinates(iElem);
            le = sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2);
        end
        
        function  [x1, x2, y1, y2, z1, z2] = computeCoordinates(obj, iElem)
            tN = obj.data.tN;
            x = obj.data.x;
            x1 = x(tN(iElem,1),1);
            x2 = x(tN(iElem,2),1);
            y1 = x(tN(iElem,1),2);
            y2 = x(tN(iElem,2),2);
            z1 = x(tN(iElem,1),3);
            z2 = x(tN(iElem,2),3);
        end
        
        function  Re = computeRe(obj, le, iElem)
            [x1, x2, y1, y2, z1, z2] = obj.computeCoordinates(iElem);
            Re = 1/le*[x2-x1, y2-y1, z2-z1, 0, 0, 0;
                0, 0, 0, x2-x1, y2-y1, z2-z1];
        end
        
    end
    
end

