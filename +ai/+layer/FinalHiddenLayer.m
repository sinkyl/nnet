classdef FinalHiddenLayer < ai.layer.Layer
    properties
        biasList linkedList.LinkedList;
        learningFactorList linkedList.LinkedList;
        actFncList linkedList.LinkedList;
    end
    methods
        function self = FinalHiddenLayer(trainHiddenLayer)
            arguments
                trainHiddenLayer ai.layer.TrainHiddenLayer;
            end
            self.leftLayer = trainHiddenLayer.leftLayer;
            self.neuronCount = trainHiddenLayer.neuronCount;
            self.neuronList = linkedList.LinkedList;
            self.biasList = trainHiddenLayer.biasList;
            self.learningFactorList = trainHiddenLayer.learningFactorList;
            self.actFncList = trainHiddenLayer.actFncList;
            
            tn = trainHiddenLayer.neuronList.firstElem;
            while (~isempty(tn))
                n = ai.neuron.FinalNeuron(tn.data);
                self.neuronList.add(n);
                tn = tn.next;
            end
        end
        
        function runLayerForward(self)
            arguments
                self ai.layer.FinalHiddenLayer;
            end
            n = self.neuronList.firstElem;
            while (~isempty(n))
                n.data.updateInputValue(self.leftLayer.neuronList);
                n.data.updateOutputValue;
                n = n.next;
            end
        end
    end
end

