function [data] = ex2()
%ex2 Reads the database 'tpcda21_02_dataset.mat' and remove not important data from it
%   Function removes 'u2' and calculate 'u67' (u67 = 0.4878 * u6 + 0.5261 * u7;)

    data = load('tpcda21_02_dataset.mat');
    Rm = corrcoef(data.u6, data.u7);

    data.u67 = 0.4878 * data.u6 + 0.5261 * data.u7;  
    data = rmfield(data,'u2');
    data = rmfield(data,'u6');
    data = rmfield(data,'u7');
    y = data.y;
    data = rmfield(data,'y');
    data.y = y;

end

