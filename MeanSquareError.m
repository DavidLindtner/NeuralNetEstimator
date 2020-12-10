function [MSerror] = MeanSquareError(neuralOut,realOut)
%LEASTSQUARE Summary of this function goes here
%   Detailed explanation goes here
    if length(neuralOut) ~= length(realOut)
        error("Input vectors do not have a same length");
    end
    MSerror = sum((neuralOut-realOut).^2)/length(neuralOut);
end

