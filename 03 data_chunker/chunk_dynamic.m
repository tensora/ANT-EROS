function chunkedVector = chunk_dynamic(v,chunkSize)
%Chunks together a 1-dim vector by summing together a dynamic nr of
%elements (chunkSize). It throws away the end if the vector is too short.
%input1: [23,1,0,5] input2:[1,2,1]
%output: [23,1,1]

%input1: [23,1,0,5] input2:[1,2,3,4]
%output: [23,1]


%chunkSize is us per Frame.

%returns a zeros[1,0] double vector if vectorLength shorter than chunkSize.


    vLen = max(size(v));
    %only used to count how many chunks we get???May not need to be
    %counted. but:
    %chunkCount = floor(vLen/chunkSize)
    %chunkCount = max(size(chunkSize));


    
    chunkSize;

    suggestedChunkCount = sum(chunkSize);

    vLenOff = vLen;
    chunkCount = 0;
    for j=1:max(size(chunkSize))
        vLenOff = vLenOff - chunkSize(j);
        if vLenOff<0
            %stop
        else
            chunkCount = chunkCount + 1;
        end
    end

    %Use to cut of one chunk from the end if there is too much.
    %May need to change to be able to cut of more than just one!
    % if(vLen<=suggestedChunkCount)
    %     chunkCount = chunkCount-1;
    % else
    %     %do nothing;
    % end

    chunkedVector = zeros(1,chunkCount);

    p = 0;
    for i = 1:chunkCount
        startPoint = p + 1;
        endPoint = startPoint + chunkSize(i)-1;
        chunkedVector(i) = sum( v(startPoint:endPoint) );
        p = endPoint;
    end

    chunkedVector = chunkedVector';
end