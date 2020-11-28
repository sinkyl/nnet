classdef FinalNeuron < ai.neuron.Neuron
    % Represent the neuron after training neuron is done
    properties (Access = ?ai.layer.Layer)
       leftWeights linkedList.LinkedList; 
    end
    methods
        function neuron = FinalNeuron(trainedNeuron)
            arguments
                trainedNeuron ai.neuron.TrainNeuron;
            end
            neuron.bias = trainedNeuron.bias;
            neuron.leftWeights = trainedNeuron.leftWeights;
            neuron.actFnc = trainedNeuron.actFnc;
        end
    end
end

