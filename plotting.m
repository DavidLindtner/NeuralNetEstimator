function [] = plotting(realOut,neuralOut)
%PLOTTING Summary of this function goes here
%   Detailed explanation goes here

%%  Plotting
    figure(1)
    plot(realOut,'LineWidth',1.5)
    hold on
    plot(neuralOut,'LineWidth',1.5)
    legend("Real output", "Estimation")
    xlabel("sample")
    ylabel("oxidation number")
    title("Oxidation number in an oil rafinery")
    set(gcf,'color','w')
    grid on

end

