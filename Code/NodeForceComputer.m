classdef NodeForceComputer < handle
    
    properties (Access = public)
        forces
    end
    
    properties (Access = private)
        fData
        data
        gliderForces
        aceleration
    end
    
    methods (Access = public)
        
        function obj = NodeForceComputer(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            [obj.gliderForces, obj.aceleration] = obj.computeForceAndAcceleration();
            obj.fData = obj.computeGlobalForceDistribution();
            obj.forces = obj.computeForceClasification();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function [gliderForces, aceleration] = computeForceAndAcceleration(obj)
            mass = obj.data.mass;
            pilotWeight = obj.data.pilotWeight;
            totalMass = mass + pilotWeight;
            g = obj.data.g;
            D = obj.data.D;
            L = obj.data.L;
            T = obj.data.T;
            W = totalMass*g;
            gliderForces(1) = W;
            gliderForces(2) = D;
            gliderForces(3) = L;
            gliderForces(4) = T;
            aceleration.X = (T - D) / totalMass;
            aceleration.Z = (L - W) / totalMass;
        end
        
        function fData = computeGlobalForceDistribution(obj)
            gliderForces    = obj.gliderForces;
            aceleration     = obj.aceleration;
            pilotWeight     = obj.data.pilotWeight;
            mat             = obj.data.mat;
            tMat            = obj.data.tMat;
            dim             = obj.data.dim;
            tN              = obj.data.tN;
            fData           = obj.data.fData;
            for a = 9:3:21
                fData(a,3) = fData(a,3)+gliderForces(3)/5;
            end
            for a = 7:3:19
                fData(a,3) = fData(a,3)-gliderForces(2)/5;
            end
            fData(1,3) = fData(1,3)-pilotWeight*aceleration.X/2+gliderForces(4)/2;
            fData(4,3) = fData(4,3)-pilotWeight*aceleration.X/2+gliderForces(4)/2;
            fData(3,3) = fData(3,3)-pilotWeight*aceleration.Z/2;
            fData(6,3) = fData(6,3)-pilotWeight*aceleration.Z/2;
            for iElem = 1:dim.nel
                le = obj.computeLength(iElem);
                Ae = mat(tMat(iElem),2);
                De = mat(tMat(iElem),3);
                Fx = De*Ae*le*aceleration.X;
                Fz = De*Ae*le*aceleration.Z;
                for nodes = 1:dim.nnod
                    if tN(iElem,1) == nodes || tN(iElem,2) == nodes
                        fData(nodes*dim.ni-2,3) = fData(nodes*dim.ni-2,3)-Fx/2;
                        fData(nodes*dim.ni,3) = fData(nodes*dim.ni,3)-Fz/2;
                    end
                end
            end
        end
        
        function fExt = computeForceClasification(obj)
            dim = obj.data.dim;
            fData = obj.fData;
            fExt = zeros(dim.ndof,1);
            [rows] = size(fData);
            for e = 1:dim.nnod
                for j = 1:rows
                    if e == fData(j)
                        if 1 == fData(j,2)
                            fExt(dim.ni*e-2, 1) = fData(j,3);
                        elseif 2 == fData(j,2)
                            fExt(dim.ni*e-1, 1) = fData(j,3);
                        elseif 3 == fData(j,2)
                            fExt(dim.ni*e, 1) = fData(j,3);
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
        
    end
end

