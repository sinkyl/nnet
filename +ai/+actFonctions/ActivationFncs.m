classdef (Abstract) ActivationFncs < handle
    methods
        % ACTIVATION FUNCTIONS
        function r = Sigmoid(neuron, t)
            arguments
                neuron ai.neuron.Neuron;
                t (1,1) string;
            end
            switch t
                case 'e'
                    r = 1/(1+exp(-(neuron.inputValue)));
                case 't'
                    r = neuron.outputValue * (1 - neuron.outputValue);
            end
        end
        
        function r = Tangente(neuron, t)
            arguments
                neuron ai.neuron.Neuron;
                t (1,1) string;
            end
            switch t
                case 'e'
                    r = tan(neuron.inputValue);
                case 't'
                    r = 1/(cos(neuron.inputValue)^2);
            end
        end
    end
end

