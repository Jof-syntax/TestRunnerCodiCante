classdef GliderGeometry < handle
    
    properties (Access = public)
        geometry
        x
        tN
        fixNode
    end
    
    methods (Access = public)
        
        function obj = GliderGeometry()
            obj.create();
        end
        
    end
    
    methods (Access = private)
        
        function create(obj)
            obj.geometry = obj.computeGeometry;
            obj.x = obj.computeX;
            obj.fixNode = obj.computeFixNode;
            obj.tN = obj.computeTN;
        end
        
        
        function x = computeX(obj)
            W = obj.geometry.W;
            H = obj.geometry.H;
            B = obj.geometry.B;
            x = [
                2*W,  -W/2,     0;
                2*W,   W/2,     0;
                2*W,     0,     H;
                0,     0,     H;
                0,    -B,     H;
                0,     B,     H;
                W,     0,     H;
                ];
        end
        
    end
    
    
    methods (Access = private, Static)
        
        function fixNode = computeFixNode()
            fixNode = [
                1,3,0;
                2,3,0;
                3,2,0;
                4,1,0;
                4,2,0;
                4,3,0;
                ];
        end
        
        function tN = computeTN()
            tN = [
                1,     2;
                3,     7;
                7,     4;
                3,     5;
                4,     5;
                3,     6;
                4,     6;
                5,     7;
                6,     7;
                1,     3;
                2,     3;
                1,     4;
                2,     4;
                1,     5;
                2,     6;
                7,     1;
                7,     2;
                ];
        end
        
        function geometry = computeGeometry()
            geometry.H = 0.8;
            geometry.W = 0.75;
            geometry.B = 2.8;
            geometry.D1 = 18e-3;
            geometry.d1 = 7.5e-3;
            geometry.D2 = 3e-3;
        end
        
    end
end

