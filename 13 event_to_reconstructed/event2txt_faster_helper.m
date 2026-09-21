function event2txt_faster_helper(filepath,t,x,y,p,width,height)

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

end