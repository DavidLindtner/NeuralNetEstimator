%%  Neural network estimator
%%  Deadline 15.12.2020 23:59
%   Xavier initialization

clear; close all; clc;

%%  EX2 - Updating database
data = ex2();

%%  EX3 - Dividing data to training and testing
%ratio = 1;
%[trainU, trainY, testU, testY] = ex3(data, ratio);
u = [data.u1 data.u3 data.u4 data.u5 data.u67];
y = data.y;

%%  EX4 = Levenberg-Marquardt backpropagation
noNeuronHL = 20;
divideRatio = 0.8;
%activationFunction = 'purelin';     %   Linear tf
%activationFunction = 'tansig';      %   Hyperbolic tangent sigmoid transfer function
activationFunction = 'poslin';      %   ReLU

%weightInit = 'zeros';               %   
%weightInit = 'ones';                %   
weightInit = 'rand';                %
%weightInit = 'randsmall';
%weightInit = 'rands';
[neuralOut, train, test, valid, time] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);

plotting(y, neuralOut)
