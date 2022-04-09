classdef ConservativeForcesComputer < handle
    
    properties (Access = public)
        conservativeForces
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        
        function obj = ConservativeForcesComputer(cParams)
            obj.init(cParams);
        end
        
        function a = compute(obj)
            obj.conservativeForces = obj.computeConservativeForces();
            a.conservativeForces = obj.conservativeForces;
        end 
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function conservativeForces = computeConservativeForces(obj)
            fExterior = obj.data.fExterior;
            mat = obj.data.mat;
            tMat = obj.data.tMat;
            dim = obj.data.dim;
            g = obj.data.g;
            tN = obj.data.tN;
            conservativeForces = zeros(dim.nnod*dim.ni, 3);
            for i = 1:dim.nnod
                conservativeForces = obj.computeInitialConservativeForces(conservativeForces, i);
            end
            for iElem = 1:dim.nel
                le = obj.computeLength(iElem);
                Ae = mat(tMat(iElem),2);
                De = mat(tMat(iElem),3);
                beamWeight = De*Ae*le*g;
                for nodes = 1:dim.nnod
                    p = nodes*dim.ni;
                    if tN(iElem,1) == nodes || tN(iElem,2) == nodes
                        conservativeForces(p,3) = conservativeForces(p,3) - beamWeight/2;
                    end
                    for i = 1:size(fExterior,1)
                        if fExterior(i,1) == nodes && fExterior(i,2) == 1
                            conservativeForces(p-2,3) = conservativeForces(p-2,3) + fExterior(i,3);
                            fExterior(i,3) = 0;
                        elseif fExterior(i,1) == nodes && fExterior(i,2) == 2
                            conservativeForces(p-1,3) = conservativeForces(p-1,3) + fExterior(i,3);
                            fExterior(i,3) = 0;
                        elseif fExterior(i,1) == nodes && fExterior(i,2) == 3
                            conservativeForces(p,3) = conservativeForces(p,3) + fExterior(i,3);
                            fExterior(i,3) = 0;
                        end
                    end
                end
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
        
        function conservativeForces = computeInitialConservativeForces(obj, conservativeForces, i)
                dim.ni                           = obj.data.dim.ni;
                conservativeForces(i*dim.ni,1)   = i;
                conservativeForces(i*dim.ni,2)   = 3;
                conservativeForces(i*dim.ni-1,1) = i;
                conservativeForces(i*dim.ni-1,2) = 2;
                conservativeForces(i*dim.ni-2,1) = i;
                conservativeForces(i*dim.ni-2,2) = 1;
        end
        
    end
    
end

