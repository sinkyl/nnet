classdef NetworkConfig < handle
    properties
        trainNetwork ai.network.TrainNetwork;
        finalNetwork ai.network.FinalNetwork;
        
        trainData double;
        vcData double;
        testData double;
        trainDataFile string;
        vcDataFile string;
        testDataFile string;
        hiddenLayerCount (1,1) uint32;
        hiddenLayersSize (1,1) uint32;
        outputSize (1,1) uint32;
        inputSize (1,1) uint32;
        bias (1,1) double;
        learningFactor (1,1) double;
        actFnc function_handle;
        dataSet (1,1) uint32;
        efficiency (1,1) double;
        epoch (1,1) uint32;
    end
end

