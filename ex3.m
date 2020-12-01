function [trainU, trainY, testU, testY] = ex3(data, ratio)
%EX3 Divide dataset
%   Function divides the dataset into training and testing data based on
%   ratio value.

    u = [data.u1 data.u3 data.u4 data.u5 data.u67];
    y = data.y;

    sizeData = max(size(y));
    divisionPoint = round(sizeData * ratio);

    indexes = randperm(sizeData);

    indexesTrain = indexes(1:divisionPoint);
    indexesTest = indexes(divisionPoint:end);

    trainU = u(indexesTrain,:)';
    trainY = y(indexesTrain)';

    testU = u(indexesTest,:)';
    testY = y(indexesTest)';

end

