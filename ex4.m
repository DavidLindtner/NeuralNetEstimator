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
    %neuralNet.trainParam.showWindow = false;
    
%%  Weight initialization
    switch weightInit
        case 'zeros'
            neuralNet =  setwb(neuralNet,zeros(1,neuralNet.numWeightElements)-0.00001);
        case 'ones'
            neuralNet =  setwb(neuralNet,ones(1,neuralNet.numWeightElements));
        case 'rand'
            switch activationFunction
                case 'poslin'
                    neuralNet =  setwb(neuralNet,randn(1,neuralNet.numWeightElements).*sqrt(2/(noOfNeuronHL+1)));
                case 'tansig'
                    neuralNet =  setwb(neuralNet,randn(1,neuralNet.numWeightElements).*sqrt(1/(noOfNeuronHL+1)));
            end
    end

%%  Division of data
    %neuralNet.divideFcn = 'divideblock';
    neuralNet.divideFcn = 'dividerand';
    neuralNet.divideParam.trainRatio = divideRatio;
    neuralNet.divideParam.testRatio = (1-divideRatio)/2;
    %neuralNet.divideParam.valRatio = 1/max(size(inputs));
    neuralNet.divideParam.valRatio = (1-divideRatio)/2;
    %neuralNet.divideParam
%%  Training
    tic;
    [neuralNet, tr] = train(neuralNet, inputs, outputs);
    time = toc;
    %view(neuralNet)

%%  Performance
    trainPerformance = sum((neuralNet(inputs(:,tr.trainInd)) - outputs(:,tr.trainInd)).*(neuralNet(inputs(:,tr.trainInd)) - outputs(:,tr.trainInd)))/max(size(tr.trainInd));
    testPerformance = sum((neuralNet(inputs(:,tr.testInd)) - outputs(:,tr.testInd)).*(neuralNet(inputs(:,tr.testInd)) - outputs(:,tr.testInd)))/max(size(tr.testInd));
    validPerformance = sum((neuralNet(inputs(:,tr.valInd)) - outputs(:,tr.valInd)).*(neuralNet(inputs(:,tr.valInd)) - outputs(:,tr.valInd)))/max(size(tr.valInd));

    %trainPerformance = perform(neuralNet, inputs(:,tr.trainInd), outputs(:,tr.trainInd));
    %testPerformance = perform(neuralNet, inputs(:,tr.testInd), outputs(:,tr.testInd));
    %validPerformance = perform(neuralNet, inputs(:,tr.valInd), outputs(:,tr.valInd));
    
    %trainPerformance = tr.perf;
    %testPerformance = tr.tperf;
    %validPerformance = tr.vperf;
    out = neuralNet(inputs);
end

