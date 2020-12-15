%%  Neural network estimator
%%  Deadline 15.12.2020 23:59
clear; close all; clc;

%%  EX2 - Updating database
[u, y] = ex2('tpcda21_02_dataset.mat');

%%  EX3 - Part of the learning algorithms (EX4 and EX6)

%%  Parameters of the training
noNeuronHL = 20;
divideRatio = 0.7;
%activationFunction = 'poslin';      %   ReLU
activationFunction = 'logsig';      %   Log-sigmoid transfer function

%weightInit = 'initzero';
%weightInit = 'randsmall';
weightInit = 'rands';

%%  EX4 - Levenberg-Marquardt Backpropagation
[neuralOutLMB, trainAccLMB, testAccLMB, timeLMB] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);

%%  EX5 - Extreme Learning Machine (theoretical part)

%%  EX6 - Extreme Learning Machine
[neuralOutELM, trainAccELM, testAccELM, timeELM] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);

%%   Plot EX4 and EX5
figure(1)
subplot(1,2,1)
plotting(y, neuralOutLMB, 0);
subplot(1,2,2)
plotting(y, neuralOutELM, 1);

%%  EX7 - Incremental analysis
ex7(u, y);

%%  EX8 - Average of the best network
figure(9)
ex8(u, y);



