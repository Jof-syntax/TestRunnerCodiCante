classdef GliderMass < handle
    
    properties (Access = public)
        mass
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        
        function obj = GliderMass(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.mass = obj.computeMass();        
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function mass = computeMass(obj)
            mass = 0;
            dim = obj.data.dim;
            mat = obj.data.mat;
            tMat = obj.data.tMat;
            for iElem = 1:dim.nel
                density = mat(tMat(iElem),3);
                le = obj.computeLength(iElem);
                aE = mat(tMat(iElem),2);
                mass = mass+density*le*aE;
            end
        end
        
        function le = computeLength(obj, iElem)
            [x1, x2, y1, y2, z1, z2] = obj.computeCoordinates(iElem);
            le = sqrt((x2-x1)^2+(y2-y1)^2+(z2-z1)^2);
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
        
    end
end

