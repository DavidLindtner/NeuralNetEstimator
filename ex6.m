function [neuralOut, TrainingAccuracy, TestingAccuracy, Time] = ex6(NumberofHiddenNeurons, inputs, outputs, divideRatio, ActivationFunction, initInputWeightFunction)

[Train, ~, Test] = dividerand([inputs;outputs], divideRatio, 0, 1-divideRatio);

T = Train(end,:);
P = Train(1:end-1,:);
TV.T = Test(end,:);
TV.P = Test(1:end-1,:);

NumberofTrainingData=size(P,2);
NumberofTestingData=size(TV.P,2);
NumberofInputNeurons=size(P,1);

%%%%%%%%%%% Calculate weights & biases
tic;

%%%%%%%%%%% Random generate input weights InputWeight (w_i) and biases BiasofHiddenNeurons (b_i) of hidden neurons
switch initInputWeightFunction
    case {'rands'}
        InputWeight=rands(NumberofHiddenNeurons,NumberofInputNeurons);
        BiasofHiddenNeurons=rands(NumberofHiddenNeurons,1);
    case {'initzero'}
        InputWeight=initzero(NumberofHiddenNeurons,NumberofInputNeurons);
        BiasofHiddenNeurons=initzero(NumberofHiddenNeurons,1);
    case {'randsmall'}
        InputWeight = randsmall(NumberofHiddenNeurons,P);
        BiasofHiddenNeurons=randsmall(NumberofHiddenNeurons,1);
end

tempH=InputWeight*P;
clear P;                                            %   Release input of training data 
ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH=tempH+BiasMatrix;

%%%%%%%%%%% Calculate hidden neuron output matrix H
switch lower(ActivationFunction)
    case {'poslin'}
        H = poslin(tempH);
    case {'tansig'}
        H = tansig(tempH);
    case {'logsig'}
        H = logsig(tempH);
end
clear tempH;

%%%%%%%%%%% Calculate output weights OutputWeight (beta_i)
OutputWeight=pinv(H') * T';                       

TrainingTime=toc;        %   Calculate CPU time (seconds) spent for training ELM

%%%%%%%%%%% Calculate the training accuracy
Y=(H' * OutputWeight)';                             %   Y: the actual output of the training data
TrainingAccuracy=(MeanSquareError(T, Y));               %   Calculate training accuracy (MSE) for regression case

clear H;

%%%%%%%%%%% Calculate the output of testing input
tic;
tempH_test=InputWeight*TV.P;
clear TV.P;             %   Release input of testing data             
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


daco = InputWeight*inputs;
daco = daco + BiasofHiddenNeurons;
switch lower(ActivationFunction)    
    case {'poslin'}
        ideto = poslin(daco);        
    case {'tansig'}
        ideto = tansig(daco);
    case {'logsig'}
        ideto = logsig(daco);
end
neuralOut = (ideto' * OutputWeight)'; 
