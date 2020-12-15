function [] = ex8(u,y)
%EX8 Summary of this function goes here
%   Detailed explanation goes here

divideRatio = 0.7;

noNeuronHL = 20;
activationFunction = 'poslin';
weightInit = 'rands';
[nOut1, ~, ~, ~] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
[nOut2, ~, ~, ~] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
activationFunction = 'logsig';
weightInit = 'rands';
[nOut3, ~, ~, ~] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
[nOut4, ~, ~, ~] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
activationFunction = 'poslin';
weightInit = 'randsmall';
[nOut5, ~, ~, ~] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
[nOut6, ~, ~, ~] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
activationFunction = 'logsig';
weightInit = 'randsmall';
[nOut7, ~, ~, ~] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
[nOut8, ~, ~, ~] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
noNeuronHL = 17;
activationFunction = 'logsig';
weightInit = 'rands';
[nOut9, ~, ~, ~] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
[nOut10, ~, ~, ~] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);

plotAverage(y, [nOut1, nOut2, nOut3, nOut4, nOut5, nOut6, nOut7, nOut8, nOut9, nOut10]);
end

