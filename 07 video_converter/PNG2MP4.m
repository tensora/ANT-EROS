% ==========================================
% PNG Frames to MP4 (Auto Path Version)
% ==========================================

clc;
clear;

%% ---- DEFINE FOLDER PATHS HERE ----
folder1 = '01 data/Car data/zurich_city_00_b/zurich_city_00_b_events_left/zurich_city_00_b_events_left_E2VID_format_20260215_003556_50ms_events';

folder2 = '01 data/Car data/zurich_city_00_b/zurich_city_00_b_events_left/zurich_city_00_b_events_left_E2VID_format_20260215_003556_50ms';

%intervall in ms
pngIntervall = 50;
fpsFromIntervall = 1000/pngIntervall;

%% ---- CHECK FIRST FOLDER ----
if ~isfolder(folder1)
    error('First folder does not exist.');
end

%% ---- CHECK SECOND FOLDER ----
useMix = isfolder(folder2);

%% ---- GET FOLDER NAME + PARENT PATH ----
[parentPath, folderName, ~] = fileparts(folder1);

%% ---- OUTPUT FILE NAME ----
if useMix
    outputVideoName = [folderName '_video_mix.mp4'];
else
    outputVideoName = [folderName '_video.mp4'];
end

outputVideoPath = fullfile(parentPath, outputVideoName);

%% ---- LOAD PNG FILES ----
files1 = dir(fullfile(folder1, '*.png'));
if isempty(files1)
    error('No PNG files found in first folder.');
end

[~, idx1] = sort({files1.name});
files1 = files1(idx1);

if useMix
    files2 = dir(fullfile(folder2, '*.png'));
    if isempty(files2)
        error('No PNG files found in second folder.');
    end
    
    [~, idx2] = sort({files2.name});
    files2 = files2(idx2);
    
    numFrames = min(length(files1), length(files2));
else
    numFrames = length(files1);
end

%% ---- CREATE VIDEO ----
v = VideoWriter(outputVideoPath, 'MPEG-4');
v.FrameRate = fpsFromIntervall;
v.Quality = 100;
open(v);

for k = 1:numFrames
    
    img1 = imread(fullfile(folder1, files1(k).name));
    
    if useMix
        img2 = imread(fullfile(folder2, files2(k).name));
        
        % Resize if heights differ
        if size(img1,1) ~= size(img2,1)
            img2 = imresize(img2, [size(img1,1) NaN]);
        end
        
        % Ensure RGB
        if size(img1,3) == 1
            img1 = repmat(img1,1,1,3);
        end
        
        if size(img2,3) == 1
            img2 = repmat(img2,1,1,3);
        end
        
        frame = [img1 img2];
    else
        frame = img1;
    end
    
    writeVideo(v, frame);
end

close(v);

fprintf('Video successfully created:\n%s\n', outputVideoPath);
