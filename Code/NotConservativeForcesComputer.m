classdef NotConservativeForcesComputer < handle
    
    properties (Access = public)
        Lift
        Drag
        Thrust
    end
    
    properties (Access = private)
        data
        liftWGust
    end
    
    methods (Access = public)
        
        function obj = NotConservativeForcesComputer(cParams)
            obj.init(cParams);
        end
        
        function a = compute(obj)
            obj.liftWGust = obj.computeLiftWGust;
            obj.Drag = obj.computeDrag;
            obj.Lift = obj.computeLift;
            obj.Thrust = obj.computeThrust;
            a.Drag = obj.Drag;
            a.Lift = obj.Lift;
            a.Thrust = obj.Thrust;
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams.data;
        end
        
        function Thrust = computeThrust(obj)
            cg = obj.data.cg;
            conservativeForces = obj.data.conservativeForces;
            W = obj.data.W;
            H = obj.data.H;
            Drag = obj.Drag;
            Lift = obj.Lift;
            Forces = conservativeForces;
            for x = 9:3:21
                Forces(x,3) = conservativeForces(x,3) + Lift / 5;
            end
            T1 = - Drag*(H - cg(3));
            T2 = Forces(21,3)*(cg(1) - W);
            T31 = (Forces(18,3)+Forces(12,3) + Forces(15,3))*cg(1);
            T32 = - Forces(9,3)*(2*W - cg(1));
            T33 = abs(Forces(6,3) + Forces(3,3))*(2*W - cg(1));
            T3 = T31 + T32 + T33;
            Thrust = (T1 + T2 + T3) / cg(3);
        end
        
        function Drag = computeDrag(obj)
            cg = obj.data.cg;
            conservativeForces = obj.data.conservativeForces;
            W = obj.data.W;
            H = obj.data.H;
            gust = obj.data.gust;
            Forces = conservativeForces;
            for x = 9:3:21
                Forces(x,3) = conservativeForces(x,3) + obj.liftWGust / 5;
            end
            D1 = Forces(21,3)*(cg(1) - W);
            D2 = (Forces(18,3) + Forces(12,3) + Forces(15,3))*cg(1);
            D3 = - Forces(9,3)*(2*W - cg(1));
            D4 = abs(Forces(6,3) + Forces(3,3))*(2*W - cg(1));
            dragWGust = (D1 + D2 + D3 + D4) / H;
            Drag = dragWGust*(1+gust);
        end
        
        function LiftWGust = computeLiftWGust(obj)
            pilotWeight = obj.data.pilotWeight;
            g = obj.data.g;
            mass = obj.data.mass;
            LiftWGust = (mass + pilotWeight)*g;
        end
        
        function Lift = computeLift(obj)
            gust = obj.data.gust;
            Lift = obj.liftWGust*(1 + gust);
        end
        
    end
    
end

