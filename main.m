%%  Neural network estimator
%%  Deadline 15.12.2020 23:59
clear; close all; clc;

%%  Work
data = load('tpcda21_02_dataset.mat');

figure(1)
plot(data.u1)
hold on
plot(data.u2)
plot(data.u3)
plot(data.u4)
plot(data.u5)
plot(data.u6)
plot(data.u7)

figure(2)
plot(data.y)



