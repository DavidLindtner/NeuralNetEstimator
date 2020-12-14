function [out, trainPerformance, testPerformance, validPerformance, time] = ex4(noOfNeuronHL, inputs, outputs, divideRatio, activationFunction, weightInit)
%EX4 Backpropagation neural network
%   Detailed explanation goes here
    
%%  Configuration of net
    neuralNet = fitnet(noOfNeuronHL);
    neuralNet = configure(neuralNet,inputs,outputs);
    
   
    neuralNet.layers{1}.transferFcn   = activationFunction;
    neuralNet.layers{2}.transferFcn   = 'purelin';
    
    neuralNet.trainFcn = 'trainlm';       %   Levenberg-Marquardt backpropagation
    neuralNet.performFcn = 'mse';         %   Mean squares of error
    neuralNet.trainParam.showWindow = false;
    

%%  Weight initialization

    neuralNet.initFcn = 'initlay';
    neuralNet.layers{1}.initFcn = 'initwb';
    neuralNet.layers{2}.initFcn = 'initwb';

    neuralNet.inputWeights{1}.initFcn = weightInit;
    neuralNet.layerWeights{2,1}.initFcn = weightInit;
    neuralNet.biases{1}.initFcn = weightInit;
    neuralNet.biases{2}.initFcn = weightInit;
    
%%  Division of data
    %neuralNet.divideFcn = 'divideblock';
    neuralNet.divideFcn = 'dividerand';
    neuralNet.divideParam.trainRatio = divideRatio;
    neuralNet.divideParam.testRatio = (1-divideRatio)/2;
    neuralNet.divideParam.valRatio = (1-divideRatio)/2;

%%  Training
    neuralNet = init(neuralNet);
    
    tic;
    [neuralNet, tr] = train(neuralNet, inputs, outputs);
    time = toc;
 
    %view(neuralNet)

%%  Performance
    trainPerformance = MeanSquareError(neuralNet(inputs(:,tr.trainInd)), outputs(:,tr.trainInd));
    %trainPerformance = MeanSquareError(neuralNet(inputs),outputs);
    %trainPerformance = perform(neuralNet, inputs, outputs);
    testPerformance = MeanSquareError(neuralNet(inputs(:,tr.testInd)), outputs(:,tr.testInd));
    validPerformance = MeanSquareError(neuralNet(inputs(:,tr.valInd)), outputs(:,tr.valInd));

    %trainPerformance = perform(neuralNet, inputs(:,tr.trainInd), outputs(:,tr.trainInd));
    %testPerformance = perform(neuralNet, inputs(:,tr.testInd), outputs(:,tr.testInd));
    %validPerformance = perform(neuralNet, inputs(:,tr.valInd), outputs(:,tr.valInd));
    
    %trainPerformance = tr.perf;
    %testPerformance = tr.tperf;
    %validPerformance = tr.vperf;
    out = neuralNet(inputs)';
end

