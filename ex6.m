function [neuralOut, TrainingAccuracy, TestingAccuracy, Time] = ex6(NumberofHiddenNeurons, inputs, outputs, divideRatio, ActivationFunction, initInputWeightFunction)

% Usage: elm(TrainingData_File, TestingData_File, Elm_Type, NumberofHiddenNeurons, ActivationFunction)
% OR:    [TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(TrainingData_File, TestingData_File, Elm_Type, NumberofHiddenNeurons, ActivationFunction)
%
% Input:
% TrainingData_File     - Filename of training data set
% TestingData_File      - Filename of testing data set
% Elm_Type              - 0 for regression; 1 for (both binary and multi-classes) classification
% NumberofHiddenNeurons - Number of hidden neurons assigned to the ELM
% ActivationFunction    - Type of activation function:
%                           'sig' for Sigmoidal function
%                           'sin' for Sine function
%                           'hardlim' for Hardlim function
%                           'tribas' for Triangular basis function
%                           'radbas' for Radial basis function (for additive type of SLFNs instead of RBF type of SLFNs)
%
% Output: 
% TrainingTime          - Time (seconds) spent on training ELM
% TestingTime           - Time (seconds) spent on predicting ALL testing data
% TrainingAccuracy      - Training accuracy: 
%                           RMSE for regression or correct classification rate for classification
% TestingAccuracy       - Testing accuracy: 
%                           RMSE for regression or correct classification rate for classification
%
% MULTI-CLASSE CLASSIFICATION: NUMBER OF OUTPUT NEURONS WILL BE AUTOMATICALLY SET EQUAL TO NUMBER OF CLASSES
% FOR EXAMPLE, if there are 7 classes in all, there will have 7 output
% neurons; neuron 5 has the highest output means input belongs to 5-th class
%
% Sample1 regression: [TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm('sinc_train', 'sinc_test', 0, 20, 'sig')
% Sample2 classification: elm('diabetes_train', 'diabetes_test', 1, 20, 'sig')
%
    %%%%    Authors:    MR QIN-YU ZHU AND DR GUANG-BIN HUANG
    %%%%    NANYANG TECHNOLOGICAL UNIVERSITY, SINGAPORE
    %%%%    EMAIL:      EGBHUANG@NTU.EDU.SG; GBHUANG@IEEE.ORG
    %%%%    WEBSITE:    http://www.ntu.edu.sg/eee/icis/cv/egbhuang.htm
    %%%%    DATE:       APRIL 2004

[Train, ~, Test] = dividerand([inputs;outputs], divideRatio, 0, 1-divideRatio);

T = Train(end,:);
P = Train(1:end-1,:);
TV.T = Test(end,:);
TV.P = Test(1:end-1,:);

NumberofTrainingData=size(P,2);
NumberofTestingData=size(TV.P,2);
NumberofInputNeurons=size(P,1);

tic;

%%   Random generate input weights InputWeight (w_i) and biases BiasofHiddenNeurons (b_i) of hidden neurons
switch initInputWeightFunction
    case {'rands'}
        InputWeight=rands(NumberofHiddenNeurons,NumberofInputNeurons);
        BiasofHiddenNeurons=rands(NumberofHiddenNeurons,1);
    case {'initzero'}
        InputWeight=initzero(NumberofHiddenNeurons,NumberofInputNeurons);
        BiasofHiddenNeurons=initzero(NumberofHiddenNeurons,1);
    case {'randsmall'}
        InputWeight = randsmall(NumberofHiddenNeurons,NumberofInputNeurons);
        BiasofHiddenNeurons=randsmall(NumberofHiddenNeurons,1);
end

tempH=InputWeight*P;
ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);
tempH=tempH+BiasMatrix;

%%	Calculate hidden neuron output matrix H
switch lower(ActivationFunction)
    case {'poslin'}
        H = poslin(tempH);
    case {'tansig'}
        H = tansig(tempH);
    case {'logsig'}
        H = logsig(tempH);
end

%%	Calculate output weights OutputWeight (beta_i)
OutputWeight=pinv(H') * T';                       
TrainingTime=toc;

%%	Calculate the training accuracy
Y=(H' * OutputWeight)';                             %   Y: the actual output of the training data
TrainingAccuracy=(MeanSquareError(T, Y));               %   Calculate training accuracy (MSE) for regression case

%%  Calculate the output of testing input
tic;
tempH_test=InputWeight*TV.P;
ind=ones(1,NumberofTestingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH_test=tempH_test + BiasMatrix;

switch lower(ActivationFunction)    
    case {'poslin'}
        H_test = poslin(tempH_test);        
    case {'tansig'}
        H_test = tansig(tempH_test);
    case {'logsig'}
        H_test = logsig(tempH_test);
end
TY=(H_test' * OutputWeight)';
TestingTime=toc;

TestingAccuracy=(MeanSquareError(TV.T, TY));
Time = TrainingTime + TestingTime;

%%  Calculate the output for all input data
daco = InputWeight*inputs + BiasofHiddenNeurons;
switch lower(ActivationFunction)    
    case {'poslin'}
        ideto = poslin(daco);        
    case {'tansig'}
        ideto = tansig(daco);
    case {'logsig'}
        ideto = logsig(daco);
end
neuralOut = (ideto' * OutputWeight); 
