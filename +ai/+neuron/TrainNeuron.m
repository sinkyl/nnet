classdef TrainNeuron < ai.neuron.Neuron
    properties %(Access = ?ai.layer.Layer)
        errorSignal double;
        learningFactor double;
    end
    
    properties %(SetAccess = private, GetAccess = ?ai.layer.Layer)
        oldLeftWeights linkedList.LinkedList;
        errMultiWeight (1,1) double;
    end
    
    methods
        function neuron = TrainNeuron(learningFactor, bias, actFnc)
            arguments
                learningFactor double;
                bias double;
                actFnc function_handle;
            end
            neuron.learningFactor = learningFactor;
            neuron.bias = bias;
            neuron.actFnc = actFnc;
            neuron.leftWeights = linkedList.LinkedList;
            neuron.oldLeftWeights = linkedList.LinkedList;
            neuron.inputValue = 0;
            neuron.outputValue = 0;
            neuron.errMultiWeight = 0;
        end
        
%         function setLeftWeights(self, newLeftWeights)
%             arguments
%                 self ai.neuron.TrainNeuron;
%                 newLeftWeights linkedList.LinkedList;
%             end
% %             self.setOldLeftWeights = self.leftWeights;
%             self.leftWeights = newLeftWeights;
%         end
        
        function updateErrorSigLast(self, d)
            % This function is used when the last layer is evalueted.
            arguments
                self ai.neuron.TrainNeuron;
                d double;
            end
            self.errorSignal = (d - self.outputValue) * ...
                self.actFnc(self, 't');
        end
        
        function updateErrorSig(self, errXweight)
            % This function is called when le layer is not the last one.
            arguments
                self ai.neuron.TrainNeuron;
                errXweight (1,1) double;
            end
            self.errorSignal = self.actFnc(self, 't') * errXweight;
        end
        
        function updateWeights(self, prevNeuronList)
            % Function that update left neighbor weights.
            arguments
                self ai.neuron.TrainNeuron;
                prevNeuronList linkedList.LinkedList;
            end
            % keep weights in temp variable before updating them
           % self.updateOldWeights;
            % Update weights
            wl = self.leftWeights.firstElem;
            ol = prevNeuronList.firstElem;
            while(~isempty(wl) && ~isempty(ol))
                
%                 % udpate weight
                wl.data = wl.data + (self.learningFactor * ...
                    ol.data.outputValue * self.errorSignal);
   
                wl = wl.next;
                ol = ol.next;
            end
        end
        
        function initRandomWeights(self, leftNeuronCount)
            arguments
                self ai.neuron.TrainNeuron;
                leftNeuronCount (1,1) uint32;
            end
            % Initalize each neighbor weights randomly between -1 and 1
%             r = -1 + 2 * rand(1, leftNeuronCount);
            r = -0.1 + (0.1 + 0.1).*rand(1, leftNeuronCount);
            self.leftWeights.array2LinkedList(r);
            self.oldLeftWeights.array2LinkedList(r);
        end   
    end
    
    methods (Access = private)
        function updateOldWeights(self)
            olw = self.oldLeftWeights.firstElem;
            lw = self.leftWeights.firstElem;
            while(~isempty(lw) && ~isempty(olw))
                d = lw.data;
                olw.data = d;
                
                lw = lw.next;
                olw = olw.next;
            end
        end
    end
end