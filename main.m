%%  Neural network estimator
%%  Deadline 15.12.2020 23:59
clear; close all; clc;

%%  EX2 - Updating database
[u, y] = ex2('tpcda21_02_dataset.mat');

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
figure(1)
plotting(y, neuralOutLMB, 0);

%%  EX5 - Extreme Learning Machine
[neuralOutELM, trainAccELM, testAccELM, timeELM] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
figure(2)
plotting(y, neuralOutELM, 1);

%%  EX7 - Incremental analysis
f = waitbar(0,'LMB Analysis');
maxNeurons = 20;
for i = 1:maxNeurons               %   analysis of LMB
    waitbar(i/maxNeurons, f, 'LMB Analysis');
    
    noNeuronHL = i;
    activationFunction = 'poslin';
    weightInit = 'rands';
    [~, trainAccLMB, testAccLMB, timeLMB] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trPolRan(i) = trainAccLMB;
    tePolRan(i) = testAccLMB;
    tiPolRan(i) = timeLMB;
    
    activationFunction = 'logsig';
    weightInit = 'rands';
    [~, trainAccLMB, testAccLMB, timeLMB] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trLogRan(i) = trainAccLMB;
    teLogRan(i) = testAccLMB;
    tiLogRan(i) = timeLMB;
    
    activationFunction = 'poslin';
    weightInit = 'randsmall';
    [~, trainAccLMB, testAccLMB, timeLMB] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trPolRanSm(i) = trainAccLMB;
    tePolRanSm(i) = testAccLMB;
    tiPolRanSm(i) = timeLMB;
    
    activationFunction = 'logsig';
    weightInit = 'randsmall';
    [~, trainAccLMB, testAccLMB, timeLMB] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trLogRanSm(i) = trainAccLMB;
    teLogRanSm(i) = testAccLMB;
    tiLogRanSm(i) = timeLMB;
    
    activationFunction = 'poslin';
    weightInit = 'initzero';
    [~, trainAccLMB, testAccLMB, timeLMB] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trPolZer(i) = trainAccLMB;
    tePolZer(i) = testAccLMB;
    tiPolZer(i) = timeLMB;
    
    activationFunction = 'logsig';
    weightInit = 'initzero';
    [~, trainAccLMB, testAccLMB, timeLMB] = ex4(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trLogZer(i) = trainAccLMB;
    teLogZer(i) = testAccLMB;
    tiLogZer(i) = timeLMB;
end
%   PLOTTING
figure(3)
subplot(1,2,1)
plot(trPolRan,'LineWidth',1.5)
hold on
plot(trPolRanSm,'LineWidth',1.5)
plot(trPolZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("MSE")
title("LMB Error of training - ReLU")
set(gcf,'color','w')

subplot(1,2,2)
plot(trLogRan,'LineWidth',1.5)
hold on
plot(trLogRanSm,'LineWidth',1.5)
plot(trLogZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("MSE")
title("LMB Error of training - Sigmoid")
set(gcf,'color','w')

figure(4)
subplot(1,2,1)
plot(tePolRan,'LineWidth',1.5)
hold on
plot(tePolRanSm,'LineWidth',1.5)
plot(tePolZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("MSE")
title("LMB Error of testing - ReLU")
set(gcf,'color','w')

subplot(1,2,2)
plot(teLogRan,'LineWidth',1.5)
hold on
plot(teLogRanSm,'LineWidth',1.5)
plot(teLogZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("MSE")
title("LMB Error of testing - Sigmoid")
set(gcf,'color','w')

figure(5)
subplot(1,2,1)
plot(tiPolRan,'LineWidth',1.5)
hold on
plot(tiPolRanSm,'LineWidth',1.5)
plot(tiPolZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("time [s]")
title("LMB Computational time - ReLU")
set(gcf,'color','w')

subplot(1,2,2)
plot(tiLogRan,'LineWidth',1.5)
hold on
plot(tiLogRanSm,'LineWidth',1.5)
plot(tiLogZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("time [s]")
title("LMB Computational time - Sigmoid")
set(gcf,'color','w')

figure(10)
plot(trLogRan,'LineWidth',1.5)
hold on
plot(trPolRan,'LineWidth',1.5)

waitbar(0, f, 'ELM Analysis');
for i = 1:maxNeurons               %   analysis of ELM
    waitbar(i/maxNeurons, f, 'ELM Analysis');
    
    noNeuronHL = i;
    activationFunction = 'poslin';
    weightInit = 'rands';
    [~, trainAccEML, testAccEML, timeEML] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trPolRan(i) = trainAccEML;
    tePolRan(i) = testAccEML;
    tiPolRan(i) = timeEML;
    
    activationFunction = 'logsig';
    weightInit = 'rands';
    [~, trainAccEML, testAccEML, timeEML] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trLogRan(i) = trainAccEML;
    teLogRan(i) = testAccEML;
    tiLogRan(i) = timeEML;
    
    activationFunction = 'poslin';
    weightInit = 'randsmall';
    [~, trainAccEML, testAccEML, timeEML] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trPolRanSm(i) = trainAccEML;
    tePolRanSm(i) = testAccEML;
    tiPolRanSm(i) = timeEML;
    
    activationFunction = 'logsig';
    weightInit = 'randsmall';
    [~, trainAccEML, testAccEML, timeEML] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trLogRanSm(i) = trainAccEML;
    teLogRanSm(i) = testAccEML;
    tiLogRanSm(i) = timeEML;
    
    activationFunction = 'poslin';
    weightInit = 'initzero';
    [~, trainAccEML, testAccEML, timeEML] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trPolZer(i) = trainAccEML;
    tePolZer(i) = testAccEML;
    tiPolZer(i) = timeEML;
    
    activationFunction = 'logsig';
    weightInit = 'initzero';
    [~, trainAccEML, testAccEML, timeEML] = ex6(noNeuronHL, u', y', divideRatio, activationFunction, weightInit);
    trLogZer(i) = trainAccEML;
    teLogZer(i) = testAccEML;
    tiLogZer(i) = timeEML;
end

close(f)

%   PLOTTING
figure(6)
subplot(1,2,1)
plot(trPolRan,'LineWidth',1.5)
hold on
plot(trPolRanSm,'LineWidth',1.5)
plot(trPolZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("MSE")
title("ELM Error of training - ReLU")
set(gcf,'color','w')

subplot(1,2,2)
plot(trLogRan,'LineWidth',1.5)
hold on
plot(trLogRanSm,'LineWidth',1.5)
plot(trLogZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("MSE")
title("ELM Error of training - Sigmoid")
set(gcf,'color','w')

figure(7)
subplot(1,2,1)
plot(tePolRan,'LineWidth',1.5)
hold on
plot(tePolRanSm,'LineWidth',1.5)
plot(tePolZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("MSE")
title("ELM Error of testing - ReLU")
set(gcf,'color','w')

subplot(1,2,2)
plot(teLogRan,'LineWidth',1.5)
hold on
plot(teLogRanSm,'LineWidth',1.5)
plot(teLogZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("MSE")
title("ELM Error of testing - Sigmoid")
set(gcf,'color','w')

figure(8)
subplot(1,2,1)
plot(tiPolRan,'LineWidth',1.5)
hold on
plot(tiPolRanSm,'LineWidth',1.5)
plot(tiPolZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("time [s]")
title("ELM Computational time - ReLU")
set(gcf,'color','w')

subplot(1,2,2)
plot(tiLogRan,'LineWidth',1.5)
hold on
plot(tiLogRanSm,'LineWidth',1.5)
plot(tiLogZer,'LineWidth',1.5)
grid on
legend("Rands", "Randsmall", "Init zero")
xlabel("Number of neurons in the hidden layer")
ylabel("time [s]")
title("ELM Computational time - Sigmoid")
set(gcf,'color','w')

figure(10)
plot(trLogRan,'LineWidth',1.5)
plot(trPolRan,'LineWidth',1.5)
grid on
legend("LMB - sigmoid", "LMB - ReLU", "ELM - sigmoid", "ELM - ReLU")
xlabel("Number of neurons in the hidden layer")
ylabel("MSE")
title("Training Error - Sigmoid")
set(gcf,'color','w')

%%  EX8 - Average of the best network
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

figure(9)
plotAverage(y, [nOut1, nOut2, nOut3, nOut4, nOut5, nOut6, nOut7, nOut8, nOut9, nOut10]);



