function [] = plotting(realOut,neuralOut, networkType)
%PLOTTING Summary of this function goes here
%   Detailed explanation goes here

%%  Plotting
    %figure(1)
    plot(neuralOut,'LineWidth',1.5)
    hold on
    plot(realOut,'LineWidth',1.5)
    if(networkType == 0)
        legend("Estimation LMB", "Real output")
    else
        legend("Estimation ELM", "Real output")
    end
    xlabel("sample")
    ylabel("oxidation number")
    title("Oxidation number in an oil rafinery")
    set(gcf,'color','w')
    grid on

end

