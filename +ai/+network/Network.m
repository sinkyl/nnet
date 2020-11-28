classdef(Abstract) Network < handle
    properties
        totalEpoch (1,1) uint32;
  
        layerCount uint32;
        layers linkedList.LinkedList;
    end
    
    properties (SetAccess = protected)
       digit double; 
    end
    
    methods (Access = protected)
        function setInputValues(self, values)
            % Allow to set the input layer values
            arguments
                self ai.network.Network;
                values double;
            end
            % pointing on the input layer neurons
            self.layer.firstElem.data.setOutputValues(values);
        end
        
        
        function outputList = getOutputValues(self)
            arguments
                self ai.network.Network;
            end
            % pointing to the last layer (output layer)
            ll = self.layers.lastElem.data;
            outputList = linkedList.LinkedList;
            
            ln = ll.neuronList.firstElem;
            while (~isempty(ln))
                v = ln.data.outputValue;
                outputList.add(v);
                ln = ln.next;
            end
        end
        
        function getDigitFromArray(self)
            
        end
    end
end