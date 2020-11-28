classdef TrainNetwork < ai.network.Network
    properties
        networkConfig ai.network.NetworkConfig;
        
        inputLayer ai.layer.EdgeLayer;
        hiddenLayers linkedList.LinkedList;
        outputLayer ai.layer.EdgeLayer;
        
        trainData double;
        vcData double;
        testData double;
        
        
        tmpTrainData double;
        tmpVcData double;
        tmpTestData double;
        tramDigit double;
    end
    
    properties (Constant)
        TRAM_SIZE = 26;
    end
    methods
        function self = TrainNetwork()
            self.layers = linkedList.LinkedList;
            self.hiddenLayers = linkedList.LinkedList;
        end
        
        function setTrainingConfig(self, networkConfig)
            self.networkConfig = networkConfig;
            % set input layer first
            self.addInputLayer;
            
            % set the hidden layers
            self.addHiddenLayer;
            
            % set output layer
            self.addOutputLayer;
            
            % update hidden layers rightLayer property
            self.updateRightLayerProp;
            
            % make matrix from files
            self.trainData = dataFile.DataFile.data2mat(...
                self.networkConfig.trainDataFile);
            self.vcData = dataFile.DataFile.data2mat(...
                self.networkConfig.vcDataFile);
            self.testData = dataFile.DataFile.data2mat(...
                self.networkConfig.testDataFile);
        end
        
        % -------------------------------------------
        % ---           DATA
        % -------------------------------------------
        
        
        % -------------------------------------------
        % ---      INPUT/OUTPUT LAYER
        % -------------------------------------------
        
        function setOutputValues(self, values)
            % Allow to set the input layer values
            arguments
                self ai.network.Network;
                values double;
            end
            % pointing on the input layer neurons
            ln = self.layer.firstElem.data.neuronList.lastElem;
            i = 1;
            while(~isempty(ln))
                v = values(i);
                ln.data.ouputValue = v;
                i = i + 1;
                ln = ln.next;
            end
        end
        
        
        function phase2(self)
            % start from the output layer (last layer)
            ll = self.layers.lastElem;
            while (ll.id ~= 1)
                
                
                ll = ll.prev;
            end
        end
        
        function emptyLayerList(self)
            self.layers.delete;
            self.hiddenLayers.delete;
            self.inputLayer = ai.layer.EdgeLayer.empty;
            self.outputLayer = ai.layer.EdgeLayer.empty;
            self.layerCount = 0;
        end
        
        % -------------------------------------------
        % ---           DATA
        % -------------------------------------------
        function tram = getTram(self, state)
            % get an array of values
            tram = self.getTramByState(state);
            % the first value represent the digit
            self.tramDigit = tram(1);
            % remove the digit column
            tram(1) = [];
            % build matrix of trams
            tram = reshape(tram, self.TRAM_SIZE, [])';
            % sorting descendant trams based on the 13th value
            tram = sortrows(tram, 13, 'descend');
            % remove trams based on the data set selection
            tram = tram(1:self.networkConfig.dataSet, :);
            % reshape matrix to get an array of values
            tram = reshape(tram', [], 1)';
        end
    end
    
    methods (Access = private)
        % -------------------------------------------
        % ---      LAYERS
        % -------------------------------------------
        % HIDDEN LAYERS
        function addHiddenLayer(self)
            prev = self.inputLayer;
            for i = 1:self.networkConfig.hiddenLayerCount -1
                trainLayer = ai.layer.TrainHiddenLayer(...
                    self.networkConfig.hiddenLayersSize, ...
                    prev, ...
                    self.networkConfig.bias, ...
                    self.networkConfig.learningFactor, ...
                    self.networkConfig.actFnc);
                self.layers.add(trainLayer);
                self.hiddenLayers.add(trainLayer);
                self.layerCount = self.layerCount + 1;
                prev = trainLayer;
            end
            
            % the lastone must have the same size as the output
            trainLayer = ai.layer.TrainHiddenLayer(...
                self.networkConfig.outputSize, ...
                prev, ...
                self.networkConfig.bias, ...
                self.networkConfig.learningFactor, ...
                self.networkConfig.actFnc);
            self.layers.add(trainLayer);
            self.hiddenLayers.add(trainLayer);
            self.layerCount = self.layerCount + 1;
        end
        
        % INPUT LAYER
        function addInputLayer(self)
            il = ai.layer.EdgeLayer(self.networkConfig.inputSize);
            self.inputLayer = il;
            self.layers.add(il);
            self.layerCount = self.layerCount + 1;
        end
        
        % OUTPUT LAYER
        function addOutputLayer(self)
            ol = ai.layer.EdgeLayer(self.networkConfig.outputSize);
            self.outputLayer = ol;
            self.layers.add(ol);
            self.layerCount = self.layerCount + 1;
        end
        
        function updateRightLayerProp(self)
            % update right layer and left layer of the hidden layers
            l = self.layers.firstElem.next; % skip the input layer
            while (l ~= self.layers.lastElem) % ignore the output layer
                rl = l.next.data;
                l.data.rightLayer = rl;
                l = l.next;
            end
        end
        
        function tram = getTramByState(self, state)
            switch state
                case 'train'
                    % extract and return rows (trams) randomly
                    matSize = size(self.tmpTrainData);
                    rowX = randi(matSize(1));
                    tram = self.tmpTrainData(rowX, :);
                    self.tmpTrainData(rowX, :) = [];
                case 'cv'
                    tram = self.tmpVcData(1, :);
                    self.tmpVcData(1, :) = [];
                case 'test'
                    tram = self.tmpTestData(1, :);
                    self.tmpTestData(1, :) = [];
            end
        end
    end
end