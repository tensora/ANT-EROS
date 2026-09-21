%% Settings
folder_in  = "G:\KTH\KTH exjobb 2025 - Local\EROS GUI new 20260415\08 output\merge 5 absolute";
folder_out = "G:\KTH\KTH exjobb 2025 - Local\EROS GUI new 20260415\08 output";

% Create timestamped output filename
timestamp = datestr(datetime('now'), 'yyyy-mm-dd_HH-MM-SS');
output_file = fullfile(folder_out, "merged_" + timestamp + ".mp4");

% Get video files (change extension if needed)
video_files = dir(fullfile(folder_in, "*.mp4"));

% Sort files by name
[~, idx] = sort({video_files.name});
video_files = video_files(idx);

if isempty(video_files)
    error('No video files found in the input folder.');
end

% Initialize first video to get properties
firstVideo = VideoReader(fullfile(folder_in, video_files(1).name));

FPS = firstVideo.FrameRate;
frameHeight = firstVideo.Height;
frameWidth  = firstVideo.Width;

% Create video writer (high quality)
v = VideoWriter(output_file, 'MPEG-4');
v.FrameRate = FPS;
v.Quality = 100;
open(v);

% Loop through all videos
for i = 1:length(video_files)
    filePath = fullfile(folder_in, video_files(i).name);
    vr = VideoReader(filePath);
    
    fprintf('Processing video %d / %d: %s\n', i, length(video_files), video_files(i).name);
    
    while hasFrame(vr)
        frame = readFrame(vr);
        
        % Resize if resolution differs
        if size(frame,1) ~= frameHeight || size(frame,2) ~= frameWidth
            frame = imresize(frame, [frameHeight frameWidth]);
        end
        
        % Write frame
        writeVideo(v, frame);
    end
end

% Finalize
close(v);

fprintf('Merged video created:\n%s\n', output_file);