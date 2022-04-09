classdef GliderMaterial < handle
    
    properties (Access = public)
        mat
        tMat
    end
    
    properties (Access = private)
        data
        mat1
        mat2
    end
    
    methods (Access = public)
        
        function obj = GliderMaterial(cParams)
            obj.init(cParams)
            obj.create()
        end
        
        function compute(obj)
            obj.mat = obj.computeMaterial;
            obj.tMat = obj.computeTMat;
        end
        
    end
    
    methods (Access = private)
 
        function create(obj)
            obj.createMat1();
            obj.createMat2();
        end

        function createMat1(obj)
            D1 = obj.data.D1;
            d1 = obj.data.d1;
            mat1.youngModul1 = 55e9;
            mat1.aSection1 = obj.computeASection(D1, d1);
            mat1.density1 = 2350;
            mat1.inertia1 = obj.computeInertia(D1, d1);
            obj.mat1 = mat1;
        end

        function createMat2(obj)
            D2 = obj.data.D2;
            d2 = 0;
            mat2.youngModul2 = 147e9;
            mat2.aSection2 = obj.computeASection(D2, d2);
            mat2.density2 = 950;
            mat2.inertia2 = obj.computeInertia(D2, d2);
            obj.mat2 = mat2;
        end
        
        function init(obj, cParams)
            obj.data = cParams.geometry;
        end
        
        function mat = computeMaterial(obj)
            m1 = obj.mat1;
            m2 = obj.mat2;
            mat = [
                m1.youngModul1, m1.aSection1, m1.density1,   m1.inertia1;
                m2.youngModul2, m2.aSection2, m2.density2,   m2.inertia2;
                ];
        end
        
    end
    
    methods (Access = private, Static)
        
        function tMat = computeTMat()
            tMat = [
                1;
                1;
                1;
                1;
                1;
                1;
                1;
                1;
                1;
                1;
                1;
                2;
                2;
                2;
                2;
                2;
                2;
                ];
        end
        
        function aSection = computeASection(D, d)
            aSection = pi/4*(D^2-d^2);
        end
        
        function inertia = computeInertia(D, d)
            inertia = 0.25*pi*((D/2)^4-(d/2)^4);
        end
        
    end
end

