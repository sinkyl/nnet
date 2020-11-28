classdef (Abstract) Neuron < ai.neuron.NeuronInterface & ai.actFonctions.ActivationFncs
    properties
        inputValue (1,1) double;
        bias double;
        actFnc function_handle;
        leftWeights linkedList.LinkedList;
    end
    
    methods
        function updateInputValue(self, outputs)
            % Update the input value based on the left layer outputs.
            arguments
                self ai.neuron.Neuron;
                outputs linkedList.LinkedList;
            end
            if (outputs.elemCount == self.leftWeights.elemCount)
                wn = self.leftWeights.firstElem;
                in = outputs.firstElem;
                while(~isempty(wn) && ~isempty(in))
                    wd = wn.data;
                    id = in.data.outputValue;
                    self.inputValue = self.inputValue + (wd * id);
                    wn = wn.next;
                    in = in.next;
                end
                self.inputValue = self.inputValue + self.bias;
            end
        end
        
        function updateOutputValue(self)
            % Update output value with the activation function.
            % This function is called after the update outputs function.
            arguments
                self ai.neuron.Neuron
            end
            self.outputValue = self.actFnc(self, 'e');
        end
    end
end