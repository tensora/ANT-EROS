function searchLimits = limits_3var_cliptest()
%OBS! set function-name to file name! It must also be unique!

%LIMITS_DEFAULTS Returns search limits and plateau directions for auto-tuning
%
%   The returned struct contains the min/max ranges for each parameter and
%   the initial plateau direction.

    searchLimits = struct();

    % --- Parameter search limits ---
    % Range [0 0] means the variable is fixed
    searchLimits.GG = [-10, 10]; %-10 to 10
    searchLimits.HG = [-2, 0]; % -2 to 2
    searchLimits.SE = [0, 5]; % 0 to 5
    searchLimits.KG = [0, 0]; % -20 to 20
    searchLimits.SG = [0, 0]; % 0 to 5
    searchLimits.R0 = [0, 0]; % 0 to 20

    % --- Plateau directions ---
    %-1 or 1
    searchLimits.GG_plateau = -1;
    searchLimits.HG_plateau = -1;
    searchLimits.SE_plateau = -1;
    searchLimits.KG_plateau = -1;
    searchLimits.SG_plateau = -1;
    searchLimits.R0_plateau = -1;

    %example: max_its_set = 4 on 2 vars will run 8 tunings: 4 per variable etc...
    searchLimits.its = 20;
    searchLimits.max_its_set = 2;


end