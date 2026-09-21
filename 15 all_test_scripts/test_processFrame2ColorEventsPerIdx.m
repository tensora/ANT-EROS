%Test code for rgb images:


%% Test processFrame2ColorEventsPerIdx independently

clc; clear; close all;

% --- Frame parameters ---
retinaRes = [20, 30];   % small frame for testing
numFrames = 2;

% --- Synthetic event data ---
% Format: x, y, polarity (0=OFF, 1=ON)
% We'll create a simple pattern:
% Frame 1: top-left corner ON, bottom-right OFF
% Frame 2: diagonal ON
x_data = [2, 18, 5, 15];
y_data = [2, 15, 5, 15];
pol_data = [1, 0, 1, 0];   % 1=ON, 0=OFF

% Number of events per frame
ePerFrameList = [2, 2];     
ePerFrameCumsum = cumsum(ePerFrameList);

% --- Run test for each frame ---
for idx = 1:numFrames
    rgbFrame = processFrame2ColorEventsPerIdx(idx, ePerFrameList, ePerFrameCumsum, ...
        x_data, y_data, pol_data, retinaRes);

    % Show the RGB frame
    figure;
    imshow(rgbFrame);
    title(['Frame ' num2str(idx)]);
end

