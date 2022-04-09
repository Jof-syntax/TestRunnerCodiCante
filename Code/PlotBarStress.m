classdef PlotBarStress < handle
    
    properties (Access = private)
        data
        scale
        mapping
    end
    
    methods (Access = public)
        
        function obj = PlotBarStress(cParams)
            obj.init(cParams);
        end
        
        function compute(obj)
            obj.starterPlot;
            obj.configratePlotLimits;
            obj.computePlotBarStress3D;
            obj.computePlotPatch;
            obj.computePlotText;
            obj.computeCBar;
        end
        
    end
    
    methods  (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
            obj.scale = obj.computeScale;
        end
        
        function computePlotPatch(obj)
            Xmapping = obj.mapping.Xmapping;
            Ymapping = obj.mapping.Ymapping;
            Zmapping = obj.mapping.Zmapping;
            sig = obj.data.stress;
            patch(Xmapping, Ymapping, Zmapping,[sig';sig'],'edgecolor','flat','linewidth', 2);
        end
        
        function computePlotBarStress3D(obj)
            tN = obj.data.tN;
            [X, Y, Z] = obj.computeCoordinates;
            plot3(X(tN)',Y(tN)',Z(tN)','-k','linewidth',0.5);
        end
        
        function configratePlotLimits(obj)
            scale = obj.scale;
            x = obj.data.x;
            tN = obj.data.tN;
            u = obj.data.displacement;
            nd = size(x,2);
            ux = u(1:nd:end);
            uy = u(2:nd:end);
            uz = u(3:nd:end);
            [X, Y, Z] = obj.computeCoordinates;
            obj.mapping.Xmapping = X(tN)'+scale*ux(tN)';
            obj.mapping.Ymapping = Y(tN)'+scale*uy(tN)';
            obj.mapping.Zmapping = Z(tN)'+scale*uz(tN)';
        end
        
        function [X, Y, Z] = computeCoordinates(obj)
            x = obj.data.x;
            X = x(:,1);
            Y = x(:,2);
            Z = x(:,3);
        end
        
        function computeCBar(obj)
            sig = obj.data.stress;
            cbar = colorbar('Ticks',linspace(min(sig), max(sig), 5));
            title(cbar,{'Stress';'(Pa)'});
        end
        
        function computePlotText(obj)
            scale = obj.scale;
            xlabel('x (m)')
            ylabel('y (m)')
            zlabel('z (m)')
            title(sprintf('Deformed structure (scale = %g)', scale));
        end
        
    end
    
    methods (Access = private, Static)
        
        function starterPlot()
            figure
            hold on
            axis equal;
            colormap jet;
            view(45,20);
        end
        
        function scale = computeScale()
            scale = 10;
        end
        
    end
end

