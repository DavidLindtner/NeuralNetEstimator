function [u, y] = ex2(fileName)
%ex2 Reads the database 'tpcda21_02_dataset.mat' and remove not important data from it
%   Function removes 'u2' and calculate 'u67' (u67 = 0.4878 * u6 + 0.5261 * u7;)

    data = load(fileName);
    Rm = corrcoef(data.u6, data.u7);

    u67 = 0.4878 * data.u6 + 0.5261 * data.u7;  
    
    u = [data.u1 data.u3 data.u4 data.u5 u67];
    y = data.y;
end

