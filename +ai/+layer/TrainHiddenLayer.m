classdef TrainHiddenLayer < ai.layer.Layer
    properties
        rightLayer;
    end
    methods
        function self = TrainHiddenLayer(neuronCount, leftLayer, ...
                bias, learningFactor, actFnc)
            arguments
                neuronCount (1,1) uint32;
                leftLayer (1,1) ai.layer.Layer;
                bias double;
                learningFactor double;
                actFnc function_handle;
            end
            self.neuronCount = neuronCount;
            self.leftLayer = leftLayer;
            self.neuronList = linkedList.LinkedList;
            leftNeuronCount = leftLayer.neuronCount;
            
            for i = 1: self.neuronCount
                self.addNeuron(leftNeuronCount, bias, learningFactor, ...
                    actFnc);
            end
        end
        
        function addNeuron(self, leftNeuronCount, bias, learningFactor, ...
                actFnc)
            arguments
                self ai.layer.TrainHiddenLayer;
                leftNeuronCount (1,1) uint32;
                bias (1,1) double;
                learningFactor (1,1) double;
                actFnc (1,1) function_handle;
            end
            neuron = ai.neuron.TrainNeuron(learningFactor, bias, actFnc);
            neuron.initRandomWeights(leftNeuronCount);
            self.neuronList.add(neuron);
        end
        
        function runLayerForward(self)
            arguments
                self ai.layer.TrainHiddenLayer;
            end
            n = self.neuronList.firstElem;
            while (~isempty(n))
                n.data.updateInputValue(self.leftLayer.neuronList);
                n.data.updateOutputValue;
                n = n.next;
            end
        end
        
        function runLayerBackward(self)
            arguments
                self ai.layer.TrainHiddenLayer;
            end
            n = self.neuronList.firstElem;
            while (~isempty(n))
                % update error signal -- first
                if (~isa(self.rightLayer, 'ai.layer.EdgeLayer'))
                    self.runErrorSignal;
                else
                    self.runErrorSignalLast;
                end
                % update weights -- second
                self.runUpdateWeights;
                
                n = n.next;
            end
            
        end
        
        function runActivations(self)
            arguments
                self ai.layer.TrainHiddenLayer;
            end
            n = self.neuronList.firstElem;
            while(~isempty(n))
                n.data.updateOutputValue;
                n = n.next;
            end
        end
    end
    
    % PRIVATE FUNCTIONS
    methods (Access = private)
        
        function runErrorSignalLast(self)
            arguments
                self ai.layer.TrainHiddenLayer;
            end
            % error variables
            n = self.neuronList.firstElem;
            nr = self.rightLayer.neuronList.firstElem;
            while(~isempty(n))
                d = nr.data.outputValue;
                n.data.updateErrorSigLast(d);
                nr = nr.next;
                n = n.next;
            end
        end
        
        function runErrorSignal(self)
            arguments
                self ai.layer.TrainHiddenLayer;
            end
            errXweight = 0;
            n = self.neuronList.firstElem;
            
            while(~isempty(n))
                % right layer
                nr = self.rightLayer.neuronList.firstElem;
                
                while(~isempty(nr))
                    w = nr.data.oldLeftWeights.getDataByNodeId(n.id);
                    e = nr.data.errorSignal;
                    
                    errXweight = errXweight + (w * e);
                    
                    nr = nr.next;
                end
                % update error signal
                n.data.updateErrorSig(errXweight);
                errXweight = 0;
             
                n = n.next;
            end
        end
        
        function runUpdateWeights(self)
            arguments
                self ai.layer.TrainHiddenLayer;
            end
            n = self.neuronList.firstElem;
            while(~isempty(n))
                n.data.updateWeights(self.leftLayer.neuronList);
                n = n.next;
            end
        end
    end
end

