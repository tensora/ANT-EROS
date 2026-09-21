%%E2VID data converter - this script can convert data to a format used by
%%E2VID


%Clear data console and variables%
clc;
clearvars;

%%
%Load CAR data%

%filepath = '01 data/Car data/dsec_test_events/interlaken_00_a/events/left/events_uncompressed.h5';
filepath = '01 data/Car data/dsec_test_events/zurich_city_13_a/events/left/events_uncompressed.h5';
%h5disp(filename)

%eventCount = 5000000;
eventCount = 5000000;
startEvent = 1;
% t = h5read(filepath, '/events/t',startEvent,eventCount);  % timestamps (int64)
% x = h5read(filepath, '/events/x',startEvent,eventCount);  % x-coordinates (uint16)
% y = h5read(filepath, '/events/y',startEvent,eventCount);  % y-coordinates (uint16)
% p = h5read(filepath, '/events/p',startEvent,eventCount);  % polarity (int8 or uint8)

%reads all the events from a datafile.
t = h5read(filepath, '/events/t');  % timestamps (int64)
x = h5read(filepath, '/events/x');  % x-coordinates (uint16)
y = h5read(filepath, '/events/y');  % y-coordinates (uint16)
p = h5read(filepath, '/events/p');  % polarity (int8 or uint8)

width = 640;
height = 480;


%%
%Load SITS data%
filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/chessboard/events_td.h5';
% Get the total number of events in the dataset
%filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/paris/events_td.h5';
%filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/graffiti/events_td.h5';
%filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/guernica/events_td.h5';

info = h5info(filepath, '/t'); % Assuming '/t' is the dataset path
%totalEvents = info.Dataspace.Size(1); % Get the size of the dataset
%h5disp(filepath)
startEvent = 1000000;
% Calculate the number of events to read
%eventCount = totalEvents - startEvent + 1 % Correct calculation
%eventCount = 25000000;
%eventCount = totalEvents-1;
% t = h5read(filepath, '/t',startEvent,eventCount);  % timestamps (uint32)
% x = h5read(filepath, '/x',startEvent,eventCount);  % x-coordinates (uint16)
% y = h5read(filepath, '/y',startEvent,eventCount);  % y-coordinates (uint16)
% p = h5read(filepath, '/p',startEvent,eventCount);  % polarity (uint8)

%GET ALL DATA
t = h5read(filepath, '/t');  % timestamps (uint32)
x = h5read(filepath, '/x');  % x-coordinates (uint16)
y = h5read(filepath, '/y');  % y-coordinates (uint16)
p = h5read(filepath, '/p');  % polarity (uint8)

%%

t = t(startEvent:end,:);
x = x(startEvent:end,:);
y = y(startEvent:end,:);
p = p(startEvent:end,:);

width = 480;
height = 360;

%%
event2txt_faster_helper(filepath,t,x,y,p,width,height);

filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/paris/events_td.h5';
info = h5info(filepath, '/t'); % Assuming '/t' is the dataset path
startEvent = 1000000;
%GET ALL DATA
t = h5read(filepath, '/t');  % timestamps (uint32)
x = h5read(filepath, '/x');  % x-coordinates (uint16)
y = h5read(filepath, '/y');  % y-coordinates (uint16)
p = h5read(filepath, '/p');  % polarity (uint8)
t = t(startEvent:end,:);
x = x(startEvent:end,:);
y = y(startEvent:end,:);
p = p(startEvent:end,:);
width = 480;
height = 360;
event2txt_faster_helper(filepath,t,x,y,p,width,height);

filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/guernica/events_td.h5';
info = h5info(filepath, '/t'); % Assuming '/t' is the dataset path
startEvent = 1000000;
%GET ALL DATA
t = h5read(filepath, '/t');  % timestamps (uint32)
x = h5read(filepath, '/x');  % x-coordinates (uint16)
y = h5read(filepath, '/y');  % y-coordinates (uint16)
p = h5read(filepath, '/p');  % polarity (uint8)
t = t(startEvent:end,:);
x = x(startEvent:end,:);
y = y(startEvent:end,:);
p = p(startEvent:end,:);
width = 480;
height = 360;
event2txt_faster_helper(filepath,t,x,y,p,width,height);

filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/graffiti/events_td.h5';
info = h5info(filepath, '/t'); % Assuming '/t' is the dataset path
startEvent = 1000000;
%GET ALL DATA
t = h5read(filepath, '/t');  % timestamps (uint32)
x = h5read(filepath, '/x');  % x-coordinates (uint16)
y = h5read(filepath, '/y');  % y-coordinates (uint16)
p = h5read(filepath, '/p');  % polarity (uint8)
t = t(startEvent:end,:);
x = x(startEvent:end,:);
y = y(startEvent:end,:);
p = p(startEvent:end,:);
width = 480;
height = 360;
event2txt_faster_helper(filepath,t,x,y,p,width,height);


%%
%Load LAB data
%filepath = '01 data/Lab data/Checkerboard.TXT';
%filepath = '01 data/Lab data/eDVSLogfile.TXT';
%filepath = '01 data/Lab data/Laserfight.TXT';
filepath = '01 data/Lab data/Pendulum.TXT';
%filepath = '01 data/Lab data/dynamic_6dof.txt';

% Read the data from the text file
data = readmatrix(filepath); % or use dlmread('yourfile.txt') if older MATLAB


% Extract columns
y_full = uint16(data(:, 1));      % First column height y 320px
x_full = uint16(data(:, 2));      % Second column width x 320px
p_full = uint8(data(:, 3));       % Third column 0 or 1
t_full_quantized = uint64(data(:, 4));  % Fourth column 0 to 4095

% Ensure they are column vectors (this is usually already the case)
x_full = x_full(:);
y_full = y_full(:);
p_full = p_full(:);
t_full_quantized = t_full_quantized(:);

%Just shift range from 0 to 1 of pixels. Example 0px to 127px to 1px to 128px
%E2VID does not want its data shifted!!! it starts from 0 to 127 ...!
%x_full = x_full+1;
%y_full = y_full+1;

%put t in linear time
t_full = uint64(circular_to_linear(t_full_quantized,0,4095));

%These are the top values for the title
width = 320;
height = 320;

%These are the real max values for x and y in E2VID:
x_width = 319;
y_height = 319;

%You have to make sure that there are no x and y values bigger than the
%width and height specified!!! Either limit or remove these outliers from
%all of the four vectors!!!

%This removes bigger rows what the width and height:
mask = x_full <= x_width & y_full <= y_height;

x = x_full(mask);
y = y_full(mask);
p = p_full(mask);
t = t_full(mask);

maxx = max(x)
minx = min(x)
maxy = max(y)
miny = min(y)
maxp = max(p)
minp = min(p)
maxt = max(t)
mint = min(t)

%%
%clear console.
%clc;


% Base timestamp in seconds
base_time = 0;

% Open file
%fid = fopen('event_data.txt','w');
% Get input folder path and create output file in the same folder
[inputFolder, basename, ~] = fileparts(filepath);

timestamp_now = datestr(now, 'yyyymmdd_HHMMSS');
outputFileName = [basename '_E2VID_format_' timestamp_now '.txt'];
outputPath = fullfile(inputFolder, outputFileName);

%save to matlab working folder
%fid = fopen('event_data.txt','w');
%save to folder of input data.
fid = fopen(outputPath, 'w');

% Write header
fprintf(fid, '%d %d\n', width, height);

%MOST often eventdata is saved with microsecond precision 10^-6.
timePeriod = 10^-6;

%In-format of the timestamps. 6 for milliseconds etc.
decimalPlaces = 6;
%For 22 digits precision:
decimalEnd = decimalPlaces+10;

% Sets vpa digit precision. 10 leading+12 decimals will have to suffice.
%digits(22); We cannot use vpa, it is usper slow!!!

%For estimated time calculation.
newPercent = 0;
prevPercent = 0;

tic;
for i = 1:length(t)

    if mod(i,1000) == 0
        
        %delta-t
        toc;

        %delta-percent
        newPercent = (i/length(t))*100;
        deltaPercent = newPercent-prevPercent;

        %Calculate remaing percent
        remPercent = 100-newPercent;

        remTime = (toc*remPercent)/deltaPercent;
        remTimeMin = remTime/60;

        display(['Percent finished:' num2str(newPercent) '%' ' Remaining minutes:' num2str(remTimeMin)])

        tic;
        prevPercent = newPercent;
    end
    
    %We are in this case working only with row vectors! Watch out for size
    %calc!
    timeStampVector = num2str(t(i))-'0';
    decimalStart = decimalEnd - size(timeStampVector,2) + 1;
    digits22 = zeros(1,22);
    digits22(decimalStart:decimalEnd) = timeStampVector;
    digits22Filled = digits22;
    %This slicing is static since we have a very static format of 22 digits
    secondsChar = char(digits22Filled(1:10) + '0');
    decimalsChar = char(digits22Filled(11:22) + '0');
    

    totalTimestamp = [ secondsChar '.' decimalsChar];

    % Write line to file
    fprintf(fid, '%s %d %d %d\n', totalTimestamp, x(i), y(i), p(i));
end

fclose(fid);

%%
%CAR new selected datasets

filepath = '01 data/Car data/zurich_city_00_b/zurich_city_00_b_events_left/events_uncompressed.h5';

startEvent = 1;
eventCount = 558906801;

t = h5read(filepath, '/events/t',startEvent,eventCount);  % timestamps (int64)
x = h5read(filepath, '/events/x',startEvent,eventCount);  % x-coordinates (uint16)
y = h5read(filepath, '/events/y',startEvent,eventCount);  % y-coordinates (uint16)
p = h5read(filepath, '/events/p',startEvent,eventCount);  % polarity (int8 or uint8)

% t = h5read(filepath, '/events/t');  % timestamps (int64)
% x = h5read(filepath, '/events/x');  % x-coordinates (uint16)
% y = h5read(filepath, '/events/y');  % y-coordinates (uint16)
% p = h5read(filepath, '/events/p');  % polarity (int8 or uint8)

width = 640;
height = 480;
event2txt_faster_helper(filepath,t,x,y,p,width,height);

%%
%CAR new selected datasets

filepath = '01 data/Car data/zurich_city_04_c-20260222T145454Z-1-001/zurich_city_04_c_events_left/events_uncompressed.h5';

% startEvent = 1;
% eventCount = 558906801;
% 
% t = h5read(filepath, '/events/t',startEvent,eventCount);  % timestamps (int64)
% x = h5read(filepath, '/events/x',startEvent,eventCount);  % x-coordinates (uint16)
% y = h5read(filepath, '/events/y',startEvent,eventCount);  % y-coordinates (uint16)
% p = h5read(filepath, '/events/p',startEvent,eventCount);  % polarity (int8 or uint8)

t = h5read(filepath, '/events/t');  % timestamps (int64)
x = h5read(filepath, '/events/x');  % x-coordinates (uint16)
y = h5read(filepath, '/events/y');  % y-coordinates (uint16)
p = h5read(filepath, '/events/p');  % polarity (int8 or uint8)

width = 640;
height = 480;
event2txt_faster_helper(filepath,t,x,y,p,width,height);
