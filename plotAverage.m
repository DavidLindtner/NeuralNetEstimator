function [] = plotAverage(realOut,neuralOuts)
%PLOTAVERAGE Summary of this function goes here
%   Detailed explanation goes here

    s = size(neuralOuts);
    average = neuralOuts(:,1);
    for i = 2:s(2)
       average = average + neuralOuts(:,i);
    end
    average = average/s(2);
    
    p1 = plot(neuralOuts,'color',[0.8 0.8 0.8]);
    hold on
    p3 = plot(average,'LineWidth',1.5,'color',[0, 0.4470, 0.7410]);
    p2 = plot(realOut,'LineWidth',1.5,'color',[0.8500, 0.3250, 0.0980]);
    legend([p1(1), p2, p3], "Estimations of 10 best networks", "Real output", "Average of estimations")
    xlabel("sample")
    ylabel("oxidation number")
    title("Oxidation number in an oil rafinery")
    set(gcf,'color','w')
    grid on
end

