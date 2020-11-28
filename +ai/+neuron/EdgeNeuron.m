classdef EdgeNeuron < ai.neuron.NeuronInterface
    methods %(Access = Layer)
        function setOutputValue(self, outputValue)
            self.outputValue = outputValue;
        end
        
        function o = getOutputValue(self)
            o = self.outputValue;
        end
    end
end

