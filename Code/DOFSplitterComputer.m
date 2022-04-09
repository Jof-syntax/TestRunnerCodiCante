classdef DOFSplitterComputer < handle
    
    properties (Access = public)
        vr
        ur
        vl
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        
        function obj = DOFSplitterComputer(cParams)
            obj.init(cParams);
        end
        
        function  compute(obj)
            obj.computeDofSplitterComputer();
        end
        
    end
    
    methods (Access = private)
        
        function init(obj, cParams)
            obj.data = cParams;
        end
        
        function computeDofSplitterComputer(obj)
            dim = obj.data.dim;
            fixNode = obj.data.fixNode;
            [rows] = size(fixNode);
            cont_vr = 1;
            cont_vl = 1;
            check = 0;
            for e = 1:dim.nnod
                for j = 1:dim.ni
                    for x = 1:rows
                        if e == fixNode(x) && j == fixNode(x,2)
                            vr(cont_vr,1) = dim.ni*(e-1)+j;
                            ur(cont_vr,1) = fixNode(x,3);
                            cont_vr = cont_vr+1;
                            check = check+1;
                        end
                    end
                    if check == 0
                        vl(cont_vl,1) = dim.ni*(e-1)+j;
                        cont_vl = cont_vl+1;
                    end
                    check = 0;
                end
            end
            obj.vr = vr;
            obj.vl = vl;
            obj.ur = ur;
        end
        
    end
end

