function excludedEventsCount = excludedEventsFromRange(ePerFrameList,startFrame,endFrame)
    

    excludedEventsCount = struct();
    ePerFrameListLength = numel(ePerFrameList);

    if startFrame == 1
        excludedEventsCount.Start = 0;
    else
        excludedEventsCount.Start = sum(ePerFrameList(1:startFrame-1));
    end

    if endFrame==ePerFrameListLength
        excludedEventsCount.End = 0;
    else
        excludedEventsCount.End = sum(ePerFrameList(endFrame+1:end));
    end

    excludedEventsCount.Included = sum(ePerFrameList(startFrame:endFrame));
end