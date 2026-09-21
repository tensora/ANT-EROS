function rgbFrame = processFrame2ColorEventsPerIdx(idx, ePerFrameList, ePerFrameCumsum, ...
    x_data, y_data, pol_data, retinaRes)
%PROCESSFRAME2COLOREVENTSPERIDX Get RGB summed event frame for a specific frame index
%
% Inputs:
%   idx               : frame number
%   ePerFrameList     : number of events per frame, length Nframes
%   ePerFrameCumsum   : cumulative sum of events per frame
%   x_data, y_data    : full event coordinates
%   pol_data          : +1/-1 polarity
%   retinaRes         : [height, width] of frame
%
% Output:
%   rgbFrame          : RGB image (red=ON, blue=OFF)
% E2VID uses blue = on and red = off so beware of flipped output!!!


    % --- Compute start and end indices for this frame ---
    if idx == 1
        startIdx = 1;
    else
        startIdx = ePerFrameCumsum(idx-1) + 1;
    end
    endIdx = ePerFrameCumsum(idx);

    % --- Slice the event vectors for this frame ---
    xFrame = x_data(startIdx:endIdx);
    yFrame = y_data(startIdx:endIdx);
    polFrame = pol_data(startIdx:endIdx);

    %convert to double from uint8 and 16:
    % Convert to double for processing
    xFrame = double(xFrame);
    yFrame = double(yFrame);
    polFrame = double(polFrame);


    %convert 0 to -1:
    polFrame(polFrame == 0) = -1;

    % --- Call core function to create RGB frame ---
    rgbFrame = processFrame2ColorEvents(xFrame, yFrame, polFrame, retinaRes);

end

function rgbFrame = processFrame2ColorEvents(x_data, y_data, pol_data, retinaRes)

    % --- Ensure 1-based indexing ---
    x_data = double(x_data);
    y_data = double(y_data);
    x_data(x_data < 1) = 1;
    y_data(y_data < 1) = 1;
    
    % --- Separate layers ---
    posLayer = zeros(retinaRes); % ON events
    negLayer = zeros(retinaRes); % OFF events
    
    for i = 1:length(x_data)
        if pol_data(i) > 0
            posLayer(y_data(i), x_data(i)) = posLayer(y_data(i), x_data(i)) + 1;
        else
            negLayer(y_data(i), x_data(i)) = negLayer(y_data(i), x_data(i)) + 1;
        end
    end
    
    % --- Normalize separately ---
    if max(posLayer(:)) > 0
        posLayer = posLayer / max(posLayer(:));
    end
    if max(negLayer(:)) > 0
        negLayer = negLayer / max(negLayer(:));
    end

    % --- Gamma boost to brighten faint pixels ---
    gamma = 0.2;   % try 0.3–0.6 (lower = brighter)
    posLayer = posLayer .^ gamma;
    negLayer = negLayer .^ gamma;
    
    % --- Compose RGB ---
    R = posLayer;         % red = ON
    G = zeros(retinaRes); % green = 0
    B = negLayer;         % blue = OFF
    
    rgbFrame = cat(3, R, G, B);
end