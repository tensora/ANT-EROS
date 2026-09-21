function startInfo = initializeTuningStart(figHandle, sliderName, searchLimits)
% INITIALIZETUNINGSTART Prepare starting parameters for tuning a slider
%
% Inputs:
%   figHandle   - handle to GUI figure
%   sliderName  - string, slider handle name ('sldGgauss', 'sldHgauss', etc.)
%   searchLimits - struct from limits_defaults.m
%
% Output:
%   startInfo - struct with fields:
%               .startPoint     - previous slider value
%               .startStepSize  - 10% of slider range
%               .platDirection  - deterministic plateau direction

    % Get slider handle
    hSlider = getappdata(figHandle, sliderName);
    
    % --- Previous slider value as starting point ---
    startPoint = get(hSlider,'Value');
    
    % --- Map sliderName to param field in searchLimits ---
    switch sliderName
        case 'sldGgauss', param = 'GG';
        case 'sldHgauss', param = 'HG';
        case 'sldSetEvent', param = 'SE';
        case 'sldKgauss', param = 'KG';
        case 'sldSgauss', param = 'SG';
        case 'sldR0', param = 'R0';
        otherwise
            error('Unknown slider name: %s', sliderName);
    end

    %Reasonable values are from around 10% to 25%.
    % 25% is shaking up the current state as much as it can.
    % This also decides how long training can take.
    %More than 25% i more than half the distance so we dont really want it.
    startStepSizeFactor = 0.1;
    
    % --- Step size: 10% of range ---
    minVal = searchLimits.(param)(1);
    maxVal = searchLimits.(param)(2);
    startStepSize = startStepSizeFactor * (maxVal - minVal);
    
    % --- Plateau direction from limits_defaults ---
    platDirection = searchLimits.([param '_plateau']);
    
    % --- Output struct ---
    startInfo = struct();
    startInfo.startPoint = startPoint;
    startInfo.startStepSize = startStepSize;
    startInfo.platDirection = platDirection;
end