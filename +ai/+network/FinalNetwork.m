classdef FinalNetwork < ai.network.Network
    properties
        trainNetwork ai.network.TrainNetwork;
    end
    
    methods
        function self = FinalNetwork(trainNetwork)
            arguments
                trainNetwork ai.network.TrainNetwork;
            end
            self.trainNetwork = trainNetwork;
            if (self.trainNetwork.layerCount > 2)
                self.layerCount = trainNetwork.layerCount - 1;
                % final layers are the same except the last one that
                % need to be removed
                self.layers = self.trainNetwork.layers;
                self.layers.rmvlastElem;
            end
            
            
            
            
            
            
            
            
            %             % the input layer is the same
            %             fl = self.trainNetwork.layers.firstElem;
            %             self.layers.add(fl.data);
            %             % walk the hidden layers
            %             hl = fl.next;
            %             while (~isempty(hl))
            %                 l =  ai.layer.HiddenLayer(hl);
            %                 self.layers.add(l);
            %             end
        end
        
        function run(self)
            arguments
                self ai.network.FinalNetwork;
            end
            self.phase1;
        end
    end
end

