%%  Neural network estimator
%%  Deadline 15.12.2020 23:59
clear; close all; clc;

%%  EX2 - Updating database
[u, y] = ex2('tpcda21_02_dataset.mat');

%%  EX4 = Levenberg-Marquardt backpropagation
noNeuronHL = 20;
divideRatio = 0.8;
%activationFunction = 'tansig';      %   Hyperbolic tangent sigmoid transfer function
%activationFunction = 'poslin';      %   ReLU
activationFunction = 'logsig';      %   Log-sigmoid transfer function

%weightInit = 'randsmall';
weightInit = 'rands';
%weightInit = 'initzero';

[neuralOut1, trainAccLMB, testAccLMB, validAccLMB, timeLMB] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
trainAccLMB
testAccLMB
timeLMB

[neuralOut2, trainAccELM, testAccELM, timeELM] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
trainAccELM
testAccELM
timeELM

figure(1)
plotting(y, neuralOut1, 0);

figure(2)
plotting(y, neuralOut2, 1);

%plotAverage(y, [neuralOut1, neuralOut2, neuralOut3, neuralOut4, neuralOut5]);



