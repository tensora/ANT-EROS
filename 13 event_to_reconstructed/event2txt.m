%%
%Load CAR data%

%filepath = '01 data/Car data/dsec_test_events/interlaken_00_a/events/left/events_uncompressed.h5';
filepath = '01 data/Car data/dsec_test_events/zurich_city_13_a/events/left/events_uncompressed.h5';
%h5disp(filename)

%eventCount = 5000000;
eventCount = 5000000;
startEvent = 1;
t = h5read(filepath, '/events/t',startEvent,eventCount);  % timestamps (int64)
x = h5read(filepath, '/events/x',startEvent,eventCount);  % x-coordinates (uint16)
y = h5read(filepath, '/events/y',startEvent,eventCount);  % y-coordinates (uint16)
p = h5read(filepath, '/events/p',startEvent,eventCount);  % polarity (int8 or uint8)

%reads all the events from a datafile.
% t = h5read(filepath, '/events/t');  % timestamps (int64)
% x = h5read(filepath, '/events/x');  % x-coordinates (uint16)
% y = h5read(filepath, '/events/y');  % y-coordinates (uint16)
% p = h5read(filepath, '/events/p');  % polarity (int8 or uint8)

%%
%%
%Load SITS data%
filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/chessboard/events_td.h5';
% Get the total number of events in the dataset
%filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/paris/events_td.h5';
%filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/graffiti/events_td.h5';
%filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/guernica/events_td.h5';

info = h5info(filepath, '/t'); % Assuming '/t' is the dataset path
totalEvents = info.Dataspace.Size(1); % Get the size of the dataset
%h5disp(filepath)
startEvent = 100000000;
% Calculate the number of events to read
eventCount = totalEvents - startEvent + 1 % Correct calculation
eventCount = 2500000
%eventCount = totalEvents-1;
t = h5read(filepath, '/t',startEvent,eventCount);  % timestamps (uint32)
x = h5read(filepath, '/x',startEvent,eventCount);  % x-coordinates (uint16)
y = h5read(filepath, '/y',startEvent,eventCount);  % y-coordinates (uint16)
p = h5read(filepath, '/p',startEvent,eventCount);  % polarity (uint8)

%GET ALL DATA
% t = h5read(filepath, '/t');  % timestamps (uint32)
% x = h5read(filepath, '/x');  % x-coordinates (uint16)
% y = h5read(filepath, '/y');  % y-coordinates (uint16)
% p = h5read(filepath, '/p');  % polarity (uint8)

%%
%clear console.
%clc;

% Compute dynamic header
% we need to add +1 for the size even though data is -1 in the python E2VID
width  = max(x)+1;
height = max(y)+1;

%maybe better to set because we get strange sizes if data is missing in a
%corner.
width = 480;
height = 360;

% Base timestamp in seconds
base_time = 0;

% Open file
%fid = fopen('event_data.txt','w');
% Get input folder path and create output file in the same folder
[inputFolder, ~, ~] = fileparts(filepath);
outputPath = fullfile(inputFolder, 'event_data.txt');

%sace to matlab working folder
%fid = fopen('event_data.txt','w');
%save to folder of input data.
fid = fopen(outputPath, 'w');

% Write header
fprintf(fid, '%d %d\n', width, height);

%MOST often eventdata is saved with microsecond precision 10^-6.
timePeriod = 10^-6;
% Sets vpa digit precision. 10 leading+12 decimals will have to suffice.
digits(22);
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
    % Microseconds padded to 6 digits
    %microsec_str = sprintf('%06d', t(i));
    % Combine with 6 trailing zeros to get 12 decimal digits
    %timestamp_str = sprintf('%d.%s000000', base_time, microsec_str);
    
    tNow = vpa(t(i));
    periodNow = vpa(timePeriod);
    precisionDecimal = tNow*periodNow;
    integerPart = floor(precisionDecimal);
    fracPart = precisionDecimal - integerPart;
    fracPartInteger = round(fracPart/timePeriod);

    %Format integerPart and fracPart to char arrays
    integerChar = char(integerPart);
    fracChar = char(fracPartInteger);

    %Add leading and trailing zeroes (only works on microseconds right now!)
    integerCharPad = pad(integerChar, 10, 'left', '0');

    fracCharPad = pad(fracChar, 6, 'left', '0');
    fracCharTrailed = [fracCharPad, repmat('0', 1, 6)]; 

    totalTimestamp = [ integerCharPad '.' fracCharTrailed];

    % Write line
    fprintf(fid, '%s %d %d %d\n', totalTimestamp, x(i), y(i), p(i));
end

fclose(fid);