function searchLimits = limits_1000sample_5var_krad2()
%OBS! set function-name to file name! It must also be unique!

    searchLimits = struct();

    % --- Parameter search limits ---
    % Range [0 0] means the variable is fixed
    % searchLimits.GG = [-10, 10]; %-10 to 10
    % searchLimits.HG = [0, 0]; % -2 to 2
    % searchLimits.SE = [0, 0]; % 0 to 5
    % searchLimits.KG = [0, 0]; % -20 to 20
    % searchLimits.SG = [0, 0]; % 0 to 5
    % searchLimits.R0 = [0, 0]; % 0 to 20

    %Define variables to use. Must be same name as slidername!!!
    searchLimits.sliderNames = ["sldGgauss","sldHgauss","sldKgauss","sldSgauss","sldR0"];

    %Ranges
    searchLimits.ranges = [
       -10 10;
       -2  0;
        10 20;
        0  1;
        0  2;
    ];

    %Define variables to use. Must be same name as slidername!!!
    % searchLimits.sliderNames = ["sldGgauss"];
    % % 
    % % %Ranges
    % searchLimits.ranges = [
    %    -10 10
    % ];

    %bayes samples count
    %Need around 200 to find goo value for 1var GGauss.
    searchLimits.sampleCount = 1000;

    %deterministic flagging
    %Induces noise if false.
    %noise give better exploration, no-noise gives more finetuning.
    %Noise can help to find sharp peaks!
    searchLimits.IsObjectiveDeterministic = false; 

end