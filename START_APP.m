%Welcome to Live parameter tuning script

%Clear data console and variables
clc;
clearvars;

%Add dependent folders
scriptFolder = fileparts(mfilename('fullpath'));
addpath(genpath(scriptFolder));

%
%CHOOSE DATASET
disp('Welcome to live parameter tuner! You are our first guest!')
disp('I recommend using atleast version R2025a of Matlab. Older versions may not work.')
fprintf('\n');

% Prompt user to select a dataset
disp('Choose a dataset:');
%disp('1. Chessboard');
%disp('2. Guernica');
%disp('3. Man in Chair (CPU Light)');
%disp('4. Car (CPU Heavy)' )
%disp('5. Car Zurich 00 b' )
%disp('6. Car Zurich 04 c');
disp('1. Ball sport' )
disp('2. Laserfight' )
disp('3. Checkerboard' )
disp('4. Pendulum' )

%disp('9. Car Zurich 04 c E2VID');
%disp('10. Car Zurich 00 b E2VID' )
%disp('11. Paris' )
%disp('12. Graffiti')
n = input('Enter a number (1–4):');
while ~(isnumeric(n) && isscalar(n) && ismember(n, 1:4))
    disp('Error: Input must be an integer between 1 and 4.');
    n = input('Enter a number (1–4): ');
end

isWindows = input('Are you a Windows user?(y/n):','s');
mySystem = 'unknown';
switch isWindows
    case 'y'
        mySystem = 'windows';
    case 'n'
        mySystem = 'linux';
    otherwise
        mySystem = 'unknown';
end

% Switch statement to evaluate the input
filepath = '';
path_reconstruct = '';
path_canny = '';
fps_stat = 0;
retinaRes = [0,0];
fileType = '';
numEvents = 0;
switch n
    % case 1
    %     filepath =         '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/chessboard/chessboard_E2VID_format_20251116_225407.mat';
    %     path_reconstruct = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/chessboard/chessboard_E2VID_format_20251116_225407_10ms';
    %     path_canny =       '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/chessboard/chessboard_E2VID_format_20251116_225407_10ms_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-01-20_16-22-38';
    %     fps_stat = 100;
    %     retinaRes = [360,480];
    %     fileType = '.mat';
    %     mfile = matfile(filepath);
    %     numEvents = size(mfile,'dataTemp',1);
    %     disp('Dataset: SITS Chessboard');
    % case 2
    %     filepath =         '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/guernica/guernica_td_E2VID_format_20251117_090726.mat';
    %     path_reconstruct = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/guernica/guernica_td_E2VID_format_20251117_090726_10ms';
    %     path_canny =       '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/guernica/guernica_td_E2VID_format_20251117_090726_10ms_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-02-13_01-18-34';
    %     fps_stat = 100;
    %     retinaRes = [360,480];
    %     fileType = '.mat';
    %     mfile = matfile(filepath);
    %     numEvents = size(mfile,'dataTemp',1);
    %     disp('Dataset: SITS Guernica 1');
    % case 3
    %     filepath =         '01 data/E2VID data/dynamic_6dof/dynamic_6dof.mat';
    %     path_reconstruct = '01 data/E2VID data/dynamic_6dof_50ms_recon';
    %     path_canny =       '01 data/E2VID data/dynamic_6dof_50ms_recon_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-02-17_15-44-41';
    %     fps_stat = 20;
    %     retinaRes = [180,240];
    %     fileType = '.mat';
    %     mfile = matfile(filepath);
    %     numEvents = size(mfile,'dataTemp',1);
    %     disp('Dataset: E2VID 6dof');
    % case 4
    %     filepath =         '01 data/Car data/thun_01_a_reconstructed-20260220T082729Z-1-001/thun_01_a_events_left/events_uncompressed.h5';
    %     path_reconstruct = '01 data/Car data/thun_01_a_reconstructed-20260220T082729Z-1-001/thun_01_a_reconstructed';
    %     path_canny =       '01 data/Car data/thun_01_a_reconstructed-20260220T082729Z-1-001/thun_01_a_reconstructed_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-02-20_10-32-35';
    %     fps_stat = 20;
    %     retinaRes = [480,640];
    %     fileType = '.h5';
    %     info = h5info(filepath,'/events/t');
    %     numEvents = info.Dataspace.Size;
    %     disp('Dataset: DSEC thun_01_1_left');
    % 
    % case 5
    %     filepath =         '01 data/Car data/zurich_city_00_b-20260222T145404Z-1-001/zurich_city_00_b_events_left_E2VID_format_20260215_003556.mat';
    %     path_reconstruct = '01 data/Car data/zurich_city_00_b-20260222T145404Z-1-001/zurich_city_00_b_reconstructed';
    %     path_canny =       '01 data/Car data/zurich_city_00_b-20260222T145404Z-1-001/zurich_city_00_b_reconstructed_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-03-09_22-09-23';
    %     fps_stat = 20;
    %     retinaRes = [480,640];
    %     fileType = '.mat';
    %     mfile = matfile(filepath);
    %     numEvents = size(mfile,'dataTemp',1);
    %     disp('Dataset: DSEC zuric_city_00_b_left');
    % case 6
    %     filepath =         '01 data/Car data/zurich_city_04_c-20260222T145454Z-1-001/zurich_city_04_c_events_left/events_uncompressed.h5';
    %     path_reconstruct = '01 data/Car data/zurich_city_04_c-20260222T145454Z-1-001/zurich_city_04_c_reconstructed';
    %     path_canny =       '01 data/Car data/zurich_city_04_c-20260222T145454Z-1-001/zurich_city_04_c_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-04-09_23-15-18';
    %     fps_stat = 20;
    %     retinaRes = [480,640];
    %     fileType = '.h5';
    %     info = h5info(filepath,'/events/t');
    %     numEvents = info.Dataspace.Size;
    %     disp('Dataset: DSEC zurich_city_04_c_left');
    case 1
        filepath =         '01 data/Lab data/eDVSLogfile_E2VID_format_20251114_131710.mat';
        path_reconstruct = '01 data/Lab data/eDVSLogfile_E2VID_format_20251114_131710_10ms';
        path_canny =       '01 data/Lab data/eDVSLogfile_E2VID_format_20251114_131710_10ms_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-01-22_16-40-19';
        fps_stat = 100;
        retinaRes = [320,320];
        fileType = '.mat';
        mfile = matfile(filepath);
        numEvents = size(mfile,'dataTemp',1);
        disp('Dataset: NCS Lab Ball Sport');
    case 2
        filepath =         '01 data/Lab data/Laserfight_E2VID_format_20251114_131909.mat';
        path_reconstruct = '01 data/Lab data/Laserfight_E2VID_format_20251114_131909_10ms';
        path_canny =       '01 data/Lab data/Laserfight_E2VID_format_20251114_131909_10ms_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-01-22_16-41-22';
        fps_stat = 100;
        retinaRes = [320,320];
        fileType = '.mat';
        mfile = matfile(filepath);
        numEvents = size(mfile,'dataTemp',1);
        disp('Dataset: NCS Lab Laserfight');
    case 3
        filepath =         '01 data/Lab data/Checkerboard_E2VID_format_20251114_131346.mat';
        path_reconstruct = '01 data/Lab data/Checkerboard_E2VID_format_20251114_131346_10ms';
        path_canny =       '01 data/Lab data/Checkerboard_E2VID_format_20251114_131346_10ms_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-01-22_16-38-27';
        fps_stat = 100;
        retinaRes = [320,320];
        fileType = '.mat';
        mfile = matfile(filepath);
        numEvents = size(mfile,'dataTemp',1);
        disp('Dataset: NCS Lab Checkerboard');
    case 4
        filepath =         '01 data/Lab data/Pendulum_E2VID_format_20251114_132116.mat';
        path_reconstruct = '01 data/Lab data/Pendulum_myE2VID_reconstructed_20251114_132116_10ms';
        path_canny =       '01 data/Lab data/Pendulum_myE2VID_reconstructed_20251114_132116_10ms_canny_sensitivity=6.0_kernel=3_sigma=0.0_2025-12-25_18-33-43';
        fps_stat = 100;
        retinaRes = [320,320];
        fileType = '.mat';
        mfile = matfile(filepath);
        numEvents = size(mfile,'dataTemp',1);
        disp('Dataset: NCS Lab Pendulum');

    % case 9
    %     filepath =         '01 data/Car data/zurich_city_04_c-20260222T145454Z-1-001/zurich_city_04_c_events_left/events_uncompressed.h5';
    %     path_reconstruct = '01 data/Car data/zurich_city_04_c-20260222T145454Z-1-001/zurich_city_04_c_events_left_E2VID_format_20260410_010553_10ms_reconstructed';
    %     path_canny =       '01 data/Car data/zurich_city_04_c-20260222T145454Z-1-001/zurich_city_04_c_events_left_E2VID_format_20260410_010553_10ms_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-04-10_14-25-39';
    %     fps_stat = 100;
    %     retinaRes = [480,640];
    %     fileType = '.h5';
    %     info = h5info(filepath,'/events/t');
    %     numEvents = info.Dataspace.Size;
    %     disp('Dataset: DSEC zurich_city_04_c_left E2VID');
    % case 10
    %     filepath =         '01 data/Car data/zurich_city_00_b-20260222T145404Z-1-001/zurich_city_00_b_events_left_E2VID_format_20260215_003556.mat';
    %     path_reconstruct = '01 data/Car data/zurich_city_00_b-20260222T145404Z-1-001/zurich_city_00_b_events_left_E2VID_format_20260215_003556_10ms_reconstructed';
    %     path_canny =       '01 data/Car data/zurich_city_00_b-20260222T145404Z-1-001/zurich_city_00_b_events_left_E2VID_format_20260215_003556_10ms_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-02-17_15-16-13';
    %     fps_stat = 100;
    %     retinaRes = [480,640];
    %     fileType = '.mat';
    %     mfile = matfile(filepath);
    %     numEvents = size(mfile,'dataTemp',1);
    %     disp('Dataset: DSEC zuric_city_00_b_left E2VID');
    % case 11
    %     filepath =         '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/paris/paris_td_E2VID_format_20251117_024426.mat';
    %     path_reconstruct = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/paris/paris_td_E2VID_format_20251117_024426_10ms_reconstruction';
    %     path_canny =       '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/paris/paris_td_E2VID_format_20251117_024426_10ms_reconstruction_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-04-20_20-11-50';
    %     fps_stat = 100;
    %     retinaRes = [360,480];
    %     fileType = '.mat';
    %     mfile = matfile(filepath);
    %     numEvents = size(mfile,'dataTemp',1);
    %     disp('Dataset: SITS Paris');
    % case 12
    %     filepath =         '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/graffiti/graffiti_td_E2VID_format_20260420_200850.mat';
    %     path_reconstruct = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/graffiti/graffiti_td_E2VID_format_20260420_200850_reconstruction';
    %     path_canny =       '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/graffiti/graffiti_td_E2VID_format_20260420_200850_reconstruction_canny_sensitivity=6.0_kernel=3_sigma=0.0_2026-04-21_02-33-48';
    %     fps_stat = 100;
    %     retinaRes = [360,480];
    %     fileType = '.mat';
    %     mfile = matfile(filepath);
    %     numEvents = size(mfile,'dataTemp',1);
    %     disp('Dataset: SITS Graffiti');
    otherwise
        %disp('Choose a value from the list!');
end

disp("System: "+mySystem);
disp("Data FPS: "+fps_stat);

%Choose frame interval
fprintf('\n');
disp("Max event count: "+numEvents);
partialEventLoading = input('Choose event count:');
%partialEventLoading = 10^6*4;

%Load timer
fprintf('Please wait...');
tic

%Load data into t,x,y,p
if strcmp(fileType, '.h5')
    t = h5read(filepath, '/events/t',1,partialEventLoading);  
    x = h5read(filepath, '/events/x',1,partialEventLoading);  
    y = h5read(filepath, '/events/y',1,partialEventLoading);  
    p = h5read(filepath, '/events/p',1,partialEventLoading);
else
    %structfile = load(filepath);
    data = mfile.dataTemp(1:partialEventLoading,:);
    t = double(data(:, 1));
    x = uint16(data(:, 2));     
    y = uint16(data(:, 3));     
    p = uint8(data(:, 4));
end
t = t(:);
x = x(:);
y = y(:);
p = p(:);


%end loader timer
fprintf('done (%.2f s)\n', toc);
fprintf('\n');

%count how many frames can be constructed:
micro = 1/1000000;
usPerFrame = round((1/micro)/fps_stat);
ePerUsList = countEvents(t);
ePerFrameList = chunk(ePerUsList,usPerFrame);
max_allowed_frames = numel(ePerFrameList);
%count frames based on png files, not so good
% num_files = sum(~[dir(path_reconstruct).isdir]);
% max_allowed_frames = num_files-1;

%Choose frame interval
disp("Choose a frame interval between 1 and "+max_allowed_frames);
startFrame = input('Enter start frame nr:');
endFrame = input('Enter end frame nr:');

%tuning settings should be loaded from scripts or settings files.
%tuningIts = input('Enter amount of tuning iterations:');
tuningIts = NaN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%----Initiate START----%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
intendedFrameCount = endFrame-startFrame+1
micro = 1/1000000;
usPerFrame = round((1/micro)/fps_stat)
ePerUsList = countEvents(t);
ePerFrameList = chunk(ePerUsList,usPerFrame);
ePerFrameListLength = max(size(ePerFrameList));
%Count frames in loaded eventdata:
absoluteLastFrame = ePerFrameListLength
if endFrame>absoluteLastFrame
    error('BadFrameChoice:OutOfRange', ...
      'The last frame:%d cannot be bigger than total frames:%d!', ...
      endFrame, absoluteLastFrame);
end
%Remove event from start and end according to frame range:
excludedEventsCount = excludedEventsFromRange(ePerFrameList,startFrame,endFrame)
%cut some
e_start = excludedEventsCount.Start+1;
e_end = excludedEventsCount.Start+excludedEventsCount.Included;
cut_x = x(e_start:e_end);
cut_y = y(e_start:e_end);
cut_p = p(e_start:e_end);
cut_t = t(e_start:e_end);
%Special data case code:
%Non-currated data may need x,y correction for matlab starting index 1.
if strcmp(fileType, '.h5')
    cut_x = cut_x+1;
    cut_y = cut_y+1;
else
    %do nothing
end
%put extremes in vars.
maxx = max(x);
minx = min(x);
maxy = max(y);
miny = min(y);
maxp = max(p);
minp = min(p);
maxt = max(t);
mint = min(t);
%recalculate ePerFrameListLen
ePerFrameListShort = ePerFrameList(startFrame:endFrame);
ePerFrameListLenShort = max(size(ePerFrameListShort));
frames_black = zeros([ePerFrameListLenShort,retinaRes(1),retinaRes(2)],'double');
%define some vars
files_reconstruct = dir(fullfile(path_reconstruct, '*.png'));
num_reconstruct = numel(files_reconstruct);
files_canny = dir(fullfile(path_canny, '*.png'));
num_canny = numel(files_canny);
EROS_frames_count = size(frames_black,1);
reconstructed_frames_count = num_reconstruct;
canny_frames_count = num_canny;
%Some error handling
if EROS_frames_count == reconstructed_frames_count && reconstructed_frames_count == canny_frames_count
    fprintf('There are %d frames in all paths!\n', EROS_frames_count);
elseif reconstructed_frames_count<EROS_frames_count || canny_frames_count<EROS_frames_count
    error('ImageCount:Mismatch', ...
      'Too few images to be matched with EROS frames. Change fps or amount of frames to synch: reconstruct=%d, canny=%d, EROS=%d\n', ...
      num_reconstruct, num_canny, EROS_frames_count);
else
    fprintf('Be cautious!\nTotal and partial image counts differ: reconstruct in folder=%d, canny in folder=%d, EROS=%d\n', ...
      num_reconstruct, num_canny, EROS_frames_count);
    if EROS_frames_count ~= intendedFrameCount
        error('ImageCount:Error', ...
          'Chunking error!EROS frames created=%d, but you intended %d frames!\n', ...
          EROS_frames_count, intendedFrameCount);
    else
        fprintf('EROS frame count=%d and is the same as intended frame count=%d!\n', EROS_frames_count,intendedFrameCount);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%----Initiate END----%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Start GUI
ePerFrameList_absolute = ePerFrameListShort;
minimal_multi_screen_viewer_5x_EROS_OUT_COLOR_PADDING_DROP_v2_OMNITUNER(frames_black,fps_stat,ePerFrameList_absolute,micro,cut_x,cut_y,cut_p,cut_t,retinaRes,...
    path_reconstruct, path_canny,startFrame,endFrame,mySystem,tuningIts);