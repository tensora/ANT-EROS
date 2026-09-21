%%DSEC Zurich City 00 b left

%Clear data console and variables
clc;
clearvars;

full_data =    '01 data/Car data/zurich_city_00_b-20260222T145404Z-1-001/events_uncompressed.h5';
fileType = '.h5'
info = h5info(full_data,'/events/t');
numEvents = info.Dataspace.Size
t = h5read(full_data, '/events/t');
x = h5read(full_data, '/events/x');  

clipped_data = '01 data/Car data/zurich_city_00_b-20260222T145404Z-1-001/zurich_city_00_b_events_left_E2VID_format_20260215_003556.mat';
fileType_clipped = '.mat'
mfile = matfile(clipped_data);
numEvents_clipped = size(mfile,'dataTemp',1)
data_clipped = mfile.dataTemp(1:end,:);
t_clipped = double(data_clipped(:, 1));
x_clipped = uint16(data_clipped(:, 2));

frameTuningRangeStart = 1;
frameTuningRangeEnd = 200; %1 to 200
frameEvaluationRangeStart = 201;
frameEvaluationRangeEnd = 1200;

fps_stat = 100;
micro = 1/1000000;
usPerFrame = round((1/micro)/fps_stat);
ePerUsList = countEvents(t);
ePerFrameList = chunk(ePerUsList,usPerFrame);

eventTuningRange = sum(ePerFrameList(frameTuningRangeStart:frameTuningRangeEnd))
eventEvaluationRange = sum(ePerFrameList(frameEvaluationRangeStart:frameEvaluationRangeEnd))

%%
% sits chessboard

%Clear data console and variables
clc;
clearvars;

full_data =    '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/chessboard/events_td.h5';
fileType = '.h5'
info = h5info(full_data,'/t');
numEvents = info.Dataspace.Size
t = h5read(full_data, '/t');  
x = h5read(full_data, '/x');  



clipped_data = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/chessboard/chessboard_E2VID_format_20251116_225407.mat';
fileType_clipped = '.mat'
mfile = matfile(clipped_data);
numEvents_clipped = size(mfile,'dataTemp',1)
data_clipped = mfile.dataTemp(1:end,:);
t_clipped = double(data_clipped(:, 1));
x_clipped = uint16(data_clipped(:, 2));

frameTuningRangeStart = 1;
frameTuningRangeEnd = 200; %1 to 200
frameEvaluationRangeStart = 201;
frameEvaluationRangeEnd = 1200;

fps_stat = 100;
micro = 1/1000000;
usPerFrame = round((1/micro)/fps_stat);
ePerUsList = countEvents(t_clipped);
ePerFrameList = chunk(ePerUsList,usPerFrame);

eventTuningRange = sum(ePerFrameList(frameTuningRangeStart:frameTuningRangeEnd))
eventEvaluationRange = sum(ePerFrameList(frameEvaluationRangeStart:frameEvaluationRangeEnd))

%%
% 6dof

%Clear data console and variables
clc;
clearvars;

% full_data =    '01 data/E2VID data/dynamic_6dof/dynamic_6dof.mat';
% fileType = '.h5'
% info = h5info(full_data,'/t');
% numEvents = info.Dataspace.Size
% t = h5read(full_data, '/t');  
% x = h5read(full_data, '/x');  



clipped_data = '01 data/E2VID data/dynamic_6dof/dynamic_6dof.mat';
fileType_clipped = '.mat'
mfile = matfile(clipped_data);
numEvents_clipped = size(mfile,'dataTemp',1)
data_clipped = mfile.dataTemp(1:end,:);
t_clipped = double(data_clipped(:, 1));
x_clipped = uint16(data_clipped(:, 2));

frameTuningRangeStart = 1;
frameTuningRangeEnd = 195; %1 to 200
frameEvaluationRangeStart = 196;
frameEvaluationRangeEnd = 1195;

fps_stat = 20;
micro = 1/1000000;
usPerFrame = round((1/micro)/fps_stat);
ePerUsList = countEvents(t_clipped);
ePerFrameList = chunk(ePerUsList,usPerFrame);

eventTuningRange = sum(ePerFrameList(frameTuningRangeStart:frameTuningRangeEnd))
eventEvaluationRange = sum(ePerFrameList(frameEvaluationRangeStart:frameEvaluationRangeEnd))

%%
% ball sports

%Clear data console and variables
clc;
clearvars;

% full_data =    '01 data/E2VID data/dynamic_6dof/dynamic_6dof.mat';
% fileType = '.h5'
% info = h5info(full_data,'/t');
% numEvents = info.Dataspace.Size
% t = h5read(full_data, '/t');  
% x = h5read(full_data, '/x');  



clipped_data = '01 data/Lab data/eDVSLogfile_E2VID_format_20251114_131710.mat';;
fileType_clipped = '.mat'
mfile = matfile(clipped_data);
numEvents_clipped = size(mfile,'dataTemp',1)
data_clipped = mfile.dataTemp(1:end,:);
t_clipped = double(data_clipped(:, 1));
x_clipped = uint16(data_clipped(:, 2));

frameTuningRangeStart = 1;
frameTuningRangeEnd = 200; %1 to 200
frameEvaluationRangeStart = 201;
frameEvaluationRangeEnd = 1200;

fps_stat = 100;
micro = 1/1000000;
usPerFrame = round((1/micro)/fps_stat);
ePerUsList = countEvents(t_clipped);
ePerFrameList = chunk(ePerUsList,usPerFrame);

eventTuningRange = sum(ePerFrameList(frameTuningRangeStart:frameTuningRangeEnd))
eventEvaluationRange = sum(ePerFrameList(frameEvaluationRangeStart:frameEvaluationRangeEnd))

%%
% laser sword

%Clear data console and variables
clc;
clearvars;

% full_data =    '01 data/E2VID data/dynamic_6dof/dynamic_6dof.mat';
% fileType = '.h5'
% info = h5info(full_data,'/t');
% numEvents = info.Dataspace.Size
% t = h5read(full_data, '/t');  
% x = h5read(full_data, '/x');  



clipped_data = '01 data/Lab data/Laserfight_E2VID_format_20251114_131909.mat';
fileType_clipped = '.mat'
mfile = matfile(clipped_data);
numEvents_clipped = size(mfile,'dataTemp',1)
data_clipped = mfile.dataTemp(1:end,:);
t_clipped = double(data_clipped(:, 1));
x_clipped = uint16(data_clipped(:, 2));

frameTuningRangeStart = 1101;
frameTuningRangeEnd = 1300; %1 to 200
frameEvaluationRangeStart = 101;
frameEvaluationRangeEnd = 1100;

%extra
frameTuningRangeStart = 1;
frameTuningRangeEnd = 100; %1 to 200
frameEvaluationRangeStart = 1;
frameEvaluationRangeEnd = 1300;

fps_stat = 100;
micro = 1/1000000;
usPerFrame = round((1/micro)/fps_stat);
ePerUsList = countEvents(t_clipped);
ePerFrameList = chunk(ePerUsList,usPerFrame);

eventTuningRange = sum(ePerFrameList(frameTuningRangeStart:frameTuningRangeEnd))
eventEvaluationRange = sum(ePerFrameList(frameEvaluationRangeStart:frameEvaluationRangeEnd))


%%
% GUERNICA

%Clear data console and variables
clc;
clearvars;

% full_data =    '01 data/E2VID data/dynamic_6dof/dynamic_6dof.mat';
% fileType = '.h5'
% info = h5info(full_data,'/t');
% numEvents = info.Dataspace.Size
% t = h5read(full_data, '/t');  
% x = h5read(full_data, '/x');  



clipped_data = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/guernica/guernica_td_E2VID_format_20251117_090726.mat';
fileType_clipped = '.mat'
mfile = matfile(clipped_data);
numEvents_clipped = size(mfile,'dataTemp',1)
data_clipped = mfile.dataTemp(1:end,:);
t_clipped = double(data_clipped(:, 1));
x_clipped = uint16(data_clipped(:, 2));

frameTuningRangeStart = 1101;
frameTuningRangeEnd = 1300; %1 to 200
frameEvaluationRangeStart = 101;
frameEvaluationRangeEnd = 1100;

%extra
frameTuningRangeStart = 1;
frameTuningRangeEnd = 1; %1 to 200
frameEvaluationRangeStart = 1;
frameEvaluationRangeEnd = 1000;

fps_stat = 100;
micro = 1/1000000;
usPerFrame = round((1/micro)/fps_stat);
ePerUsList = countEvents(t_clipped);
ePerFrameList = chunk(ePerUsList,usPerFrame);

eventTuningRange = sum(ePerFrameList(frameTuningRangeStart:frameTuningRangeEnd))
eventEvaluationRange = sum(ePerFrameList(frameEvaluationRangeStart:frameEvaluationRangeEnd))






