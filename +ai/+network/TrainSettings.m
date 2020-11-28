classdef (ConstructOnLoad) TrainSettings < handle
    properties
        trainDataFile string;
        vcDataFile string;
        testDataFile string;
        evalDataFile string;
        hiddenLayersSize (1,1) uint32;
        hiddenLayerCount (1,1) uint32;
        inputSize (1,1) uint32;
        outputSize (1,1) uint32;
        bias (1,1) double;
        learningFactor (1,1) double
        activationFunction function_handle;
        epoch (1,1) uint32;
        epochState (1,1) uint32;
        efficiency (1,1) double;
        timeSeconds (1,1) uint32;
        tramCount (1,1) uint32;
    end
end

