function allData = csvCorners2Mat(filespath)

% Get list of all CSV files in the folder
files = dir(fullfile(filespath, '*.csv'));

% Extract numeric part of filenames (assumes format like 000001.csv)
fileNums = arrayfun(@(f) str2double(erase(f.name, '.csv')), files);

% Sort files by number
[~, sortIdx] = sort(fileNums);
files = files(sortIdx);

% Read the first file to get size
firstFile = fullfile(filespath, files(1).name);
firstData = readmatrix(firstFile, 'NumHeaderLines', 1);

% Preallocate 3D matrix (rows × cols × number of files)
[nRows, nCols] = size(firstData);
allData = zeros(nRows, nCols, numel(files));

% Store first file
allData(:, :, 1) = firstData;

% Loop through remaining files
for k = 2:numel(files)
    filename = fullfile(filespath, files(k).name);
    allData(:, :, k) = readmatrix(filename, 'NumHeaderLines', 1);
end