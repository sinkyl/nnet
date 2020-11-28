classdef EdgeLayer < ai.layer.Layer
    % This class represent the input layer and the output layer.
    methods

        function self = EdgeLayer(neuronCount)
            % Intantiate layer with neurons that have 0 as output value.
            % parameters:
            %   - neuronCount: represent layer size
            self.neuronList = linkedList.LinkedList;
            self.neuronCount = neuronCount;
            
            for i = 1: self.neuronCount
                neuron = ai.neuron.EdgeNeuron;
                neuron.outputValue = 0;
                self.neuronList.add(neuron);
            end
        end
        
        function setLayerOutputValues(self, values)
            arguments
                self ai.layer.Layer;
                values double;
            end
            vs = size(values);
            if (vs(2) == self.neuronCount)
                n = self.neuronList.firstElem;
                i = 1;
                while(~isempty(n))
                    n.data.outputValue = values(i);
                    i = i + 1;
                    n = n.next;
                end
            else
                error("The array of new output values must" + ...
                    "have the same lenght of the layer lenght.");
            end
        end
    end
end

