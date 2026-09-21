function outDir = recordLeftAll(hFig, blackFrame,settingsString)
% RECORDLEFTALL Record left frames, save them, and process data.
%   outDir = recordLeftAll(hFig, blackFrame)
%   Inputs:
%       hFig       - handle to main GUI figure
%       blackFrame - initial black frame for previous frame
%   Output:
%       outDir     - folder where frames were saved

%THIS IS CURRENTLY UNUSED!!!

    % --- Create output directory automatically ---
    recordingsDir = fullfile(pwd, '10.1 GUI recordings');  % base recordings folder
    if ~exist(recordingsDir, 'dir')
        mkdir(recordingsDir);
    end

    % Folder named with current date and time
    timestamp = char(datetime('now','Format','yyyy-MM-dd_HH-mm-ss')); % convert to char for folder name
    outDir = fullfile(recordingsDir, timestamp);
    mkdir(outDir);

    % --- Save GUI settings string as a text file in recordingsDir ---
    settingsFile = fullfile(recordingsDir, [timestamp, '.txt']);  % text file at recordingsDir level
    fid = fopen(settingsFile, 'w');
    if fid ~= -1
        fprintf(fid, '%s', settingsString);
        fclose(fid);
    else
        warning('Could not write GUI settings to file: %s', settingsFile);
    end

    % Number of frames
    N = getappdata(hFig,'Nframes');

    % --- Initialize previous frame to black ---
    prevFrameL = blackFrame;

    for idx = 1:N
        % Compute current frame based on previous frame
        frameL = computeErosFrameLeft(hFig, idx, prevFrameL);

        % Save frame as PNG (normalize first)
        imwrite(mat2gray(frameL), fullfile(outDir, sprintf('L_%05d.png', idx)));

        % Update prevFrameL for next iteration
        prevFrameL = frameL;

        % --- Progress update ---
        fprintf('\rFrame %d of %d completed', idx, N);
        %drawnow; % Uncomment if you want GUI to refresh during loop. No
        %please.
    end

    fprintf('\n'); % Move to next line after progress updates

    % --- Optional: return processed data ---
end
