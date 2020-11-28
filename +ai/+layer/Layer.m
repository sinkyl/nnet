classdef (Abstract) Layer < handle
    properties
        neuronList (1,1) linkedList.LinkedList;
        neuronCount (1,1) uint32;
        leftLayer;
    end
    
    methods
        function digit = getOutputDigit(self)
            outputList = self.extractLayerOutputs;
            values = outputList.listToArray;
            [val, idx] = max(values(:));
            digit = idx-1;
        end
        
        function list = extractLeftLayerOutputs(self)
            arguments
                self ai.layer.TrainHiddenLayer;
            end
            list = linkedList.LinkedList;
            
            n = self.leftLayer.neuronList.firstElem;
            while(~isempty(n))
                op = n.data.outputValue;
                list.add(op);
                n = n.next;
            end
        end
        
        function list = extractLayerOutputs(self)
            arguments
                self ai.layer.TrainHiddenLayer;
            end
            list = linkedList.LinkedList;
            
            n = self.neuronList.firstElem;
            while(~isempty(n))
                op = n.data.outputValue;
                list.add(op);
                n = n.next;
            end
        end
    end
end