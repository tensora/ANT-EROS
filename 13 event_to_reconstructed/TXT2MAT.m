%E2VID format to matlab object conversion

%filepath
filepath = fullfile('01 data','SITS Corner data','Prophesees HVGA ATIS Corner dataset','chessboard','chessboard_E2VID_format_20251116_225407.txt');
%filepath = '01 data/SITS Corner data/Prophesees HVGA ATIS Corner dataset/chessboard/chessboard_E2VID_format_20251116_225407.txt';

% Read the data from the text file
data = readmatrix(filepath); % or use dlmread('yourfile.txt') if older MATLAB
% Extract columns
t = double(data(:, 1));     % 0 to inf
x = uint16(data(:, 2));     % First column height y 320p
y = uint16(data(:, 3));     % Second column width x 320px
p =  uint8(data(:, 4));      % Third column 0 or 1
% Ensure they are column vectors (this is usually already the case)
x = x(:);
y = y(:);
p = p(:);
t = t(:);
%Just shift range from 0 to 1 of pixels. Example 0px to 127px to 1px to 128px
x = x+1;
y = y+1;
%convert seconds to microseconds
% Convert timestamps to microseconds
t = uint64(t * 1e6);
%print max min values.
maxx = max(x);
minx = min(x);
maxy = max(y);
miny = min(y);
maxp = max(p);
minp = min(p);
maxt = max(t);
mint = min(t);
fprintf('X_min:%.2f X_max:%.2f\n', minx, maxx);
fprintf('Y_min:%.2f Y_max:%.2f\n', miny, maxy);
fprintf('P_min:%.2f P_max:%.2f\n', minp, maxp);
fprintf('T_min:%.2f T_max:%.2f\n', mint, maxt);
%max frame size
retinaRes = [360,480]

dataTemp = zeros(size(data));

dataTemp(:,1) = t;
dataTemp(:,2) = x;
dataTemp(:,3) = y;
dataTemp(:,4) = p;

[inputFolder, name, ~] = fileparts(filepath);

save(fullfile(inputFolder, [name '.mat']), 'dataTemp','-v7.3');

%%

%filepath
filepath = fullfile('01 data','SITS Corner data','Prophesees HVGA ATIS Corner dataset','guernica','events_td_E2VID_format_20251117_090726.txt');

% Read the data from the text file
data = readmatrix(filepath); % or use dlmread('yourfile.txt') if older MATLAB
% Extract columns
t = double(data(:, 1));     % 0 to inf
x = uint16(data(:, 2));     % First column height y 320p
y = uint16(data(:, 3));     % Second column width x 320px
p =  uint8(data(:, 4));      % Third column 0 or 1
% Ensure they are column vectors (this is usually already the case)
x = x(:);
y = y(:);
p = p(:);
t = t(:);
%Just shift range from 0 to 1 of pixels. Example 0px to 127px to 1px to 128px
x = x+1;
y = y+1;
%convert seconds to microseconds
% Convert timestamps to microseconds
t = uint64(t * 1e6);
%print max min values.
maxx = max(x);
minx = min(x);
maxy = max(y);
miny = min(y);
maxp = max(p);
minp = min(p);
maxt = max(t);
mint = min(t);
fprintf('X_min:%.2f X_max:%.2f\n', minx, maxx);
fprintf('Y_min:%.2f Y_max:%.2f\n', miny, maxy);
fprintf('P_min:%.2f P_max:%.2f\n', minp, maxp);
fprintf('T_min:%.2f T_max:%.2f\n', mint, maxt);
%max frame size
retinaRes = [360,480]

dataTemp = zeros(size(data));

dataTemp(:,1) = t;
dataTemp(:,2) = x;
dataTemp(:,3) = y;
dataTemp(:,4) = p;

[inputFolder, name, ~] = fileparts(filepath);

save(fullfile(inputFolder, [name '.mat']), 'dataTemp','-v7.3');

%%

%filepath
filepath = fullfile('01 data','Car data','zurich_city_00_b','zurich_city_00_b_events_left','zurich_city_00_b_events_left_E2VID_format_20260215_003556.txt');

% Read the data from the text file
data = readmatrix(filepath); % or use dlmread('yourfile.txt') if older MATLAB
% Extract columns
t = double(data(:, 1));     % 0 to inf
x = uint16(data(:, 2));     % First column height y 320p
y = uint16(data(:, 3));     % Second column width x 320px
p =  uint8(data(:, 4));      % Third column 0 or 1
% Ensure they are column vectors (this is usually already the case)
x = x(:);
y = y(:);
p = p(:);
t = t(:);
%Just shift range from 0 to 1 of pixels. Example 0px to 127px to 1px to 128px
x = x+1;
y = y+1;
%convert seconds to microseconds
% Convert timestamps to microseconds
t = uint64(t * 1e6);
%print max min values.
maxx = max(x);
minx = min(x);
maxy = max(y);
miny = min(y);
maxp = max(p);
minp = min(p);
maxt = max(t);
mint = min(t);
fprintf('X_min:%.2f X_max:%.2f\n', minx, maxx);
fprintf('Y_min:%.2f Y_max:%.2f\n', miny, maxy);
fprintf('P_min:%.2f P_max:%.2f\n', minp, maxp);
fprintf('T_min:%.2f T_max:%.2f\n', mint, maxt);
%max frame size
retinaRes = [480,640]

dataTemp = zeros(size(data));

dataTemp(:,1) = t;
dataTemp(:,2) = x;
dataTemp(:,3) = y;
dataTemp(:,4) = p;

[inputFolder, name, ~] = fileparts(filepath);

save(fullfile(inputFolder, [name '.mat']), 'dataTemp','-v7.3');

%%

%filepath
filepath = fullfile('01 data','My data','kth','kth_film_E2VID_format_20260215_1222','kth_film_E2VID_format_20260215_1222.txt');

% Read the data from the text file
data = readmatrix(filepath); % or use dlmread('yourfile.txt') if older MATLAB
% Extract columns
t = double(data(:, 1));     % 0 to inf
x = uint16(data(:, 2));     % First column height y 320p
y = uint16(data(:, 3));     % Second column width x 320px
p =  uint8(data(:, 4));      % Third column 0 or 1
% Ensure they are column vectors (this is usually already the case)
x = x(:);
y = y(:);
p = p(:);
t = t(:);
%Just shift range from 0 to 1 of pixels. Example 0px to 127px to 1px to 128px
x = x+1;
y = y+1;
%convert seconds to microseconds
% Convert timestamps to microseconds
t = uint64(t * 1e6);
%print max min values.
maxx = max(x);
minx = min(x);
maxy = max(y);
miny = min(y);
maxp = max(p);
minp = min(p);
maxt = max(t);
mint = min(t);
fprintf('X_min:%.2f X_max:%.2f\n', minx, maxx);
fprintf('Y_min:%.2f Y_max:%.2f\n', miny, maxy);
fprintf('P_min:%.2f P_max:%.2f\n', minp, maxp);
fprintf('T_min:%.2f T_max:%.2f\n', mint, maxt);
%max frame size
retinaRes = [260,346]

dataTemp = zeros(size(data));

dataTemp(:,1) = t;
dataTemp(:,2) = x;
dataTemp(:,3) = y;
dataTemp(:,4) = p;

[inputFolder, name, ~] = fileparts(filepath);

save(fullfile(inputFolder, [name '.mat']), 'dataTemp','-v7.3');

%%

%filepath
filepath = fullfile('01 data','E2VID data','dynamic_6dof','dynamic_6dof.txt');

% Read the data from the text file
data = readmatrix(filepath); % or use dlmread('yourfile.txt') if older MATLAB
% Extract columns
t = double(data(:, 1));     % 0 to inf
x = uint16(data(:, 2));     % First column height y 320p
y = uint16(data(:, 3));     % Second column width x 320px
p =  uint8(data(:, 4));      % Third column 0 or 1
% Ensure they are column vectors (this is usually already the case)
x = x(:);
y = y(:);
p = p(:);
t = t(:);
%Just shift range from 0 to 1 of pixels. Example 0px to 127px to 1px to 128px
x = x+1;
y = y+1;
%convert seconds to microseconds
% Convert timestamps to microseconds
t = uint64(t * 1e6);
%print max min values.
maxx = max(x);
minx = min(x);
maxy = max(y);
miny = min(y);
maxp = max(p);
minp = min(p);
maxt = max(t);
mint = min(t);
fprintf('X_min:%.2f X_max:%.2f\n', minx, maxx);
fprintf('Y_min:%.2f Y_max:%.2f\n', miny, maxy);
fprintf('P_min:%.2f P_max:%.2f\n', minp, maxp);
fprintf('T_min:%.2f T_max:%.2f\n', mint, maxt);
%max frame size
retinaRes = [180,240]

dataTemp = zeros(size(data));

dataTemp(:,1) = t;
dataTemp(:,2) = x;
dataTemp(:,3) = y;
dataTemp(:,4) = p;

[inputFolder, name, ~] = fileparts(filepath);

save(fullfile(inputFolder, [name '.mat']), 'dataTemp','-v7.3');