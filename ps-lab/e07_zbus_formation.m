% Experiment 7
% Z Bus
% Abhishek Choudhary
% 1MS18EE003
clc; clear; close all;

% Tabular data (Question 1)
% Start, end, impedance, modification type
data = [[1, 2, 0.1, 1],
        [2, 3, 0.5, 1],
        [3, 1, 0.2, 2]];

% Properties of Zbus
elements = length(data(:, 1));
Zbus = zeros(1, 1);
stepCount = 0;
        
% Zbus building algorithm
for i = 1:elements
    if (data(i, 4) == 1)
        sb = data(i, 1);
        eb = data(i, 2);
        if (sb > eb)
            temp = sb;
            sb = eb;
            eb = temp;
        end
        zncol = Zbus(:, sb);
        znrow = Zbus(sb, :);
        zn_dia = Zbus(sb, sb) + data(i, 3);
        Zbus = [Zbus zncol; znrow zn_dia];
    end
    if (data(i, 4) == 2)
        sb = data(i, 1);
        eb = data(i, 2);
        if (sb > eb)
            temp = sb;
            sb = eb;
            eb = temp;
        end
        zncol = Zbus(:, sb) - Zbus(:, eb);
        znrow = Zbus(sb, :) - Zbus(eb, :);
        zn_dia = Zbus(sb, sb) + Zbus(eb, eb) - 2 * Zbus(sb, eb) + data(i, 3);
        Zbus = [Zbus] - [(zncol * znrow) / zn_dia];
    end

    stepCount = stepCount + 1;
    
    % Output
    fprintf('Step %d | Type %d modification\n', stepCount, data(i, 4));
    if i ~= elements
        fprintf('Zbus(new) =\n');
    else
        fprintf('Zbus(final) =\n');
    end
    disp(Zbus(2:end, 2:end));
end