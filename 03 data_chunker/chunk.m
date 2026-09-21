function chunkedVector = chunk(v,chunkSize)
%Chunks together a 1-dim vector by summing together a static nr of
%elements (chunkSize). It throws away the end if the vector is too short.
%input1: [23,1,0,5] input2:2
%output: [24,5]

%returns a zeros[1,0] double vector if vectorLength shorter than chunkSize.


    vLen = max(size(v));
    chunkCount = floor(vLen/chunkSize);

    chunkedVector = zeros(1,chunkCount);
    
    for i = 1:chunkCount
        chunkedVector(i) = sum(v((i-1)*chunkSize + 1 : i*chunkSize));
    end

    chunkedVector = chunkedVector';

        % Check if there are leftover elements
    leftover = mod(vLen, chunkSize);
    if leftover > 0; % true if last frame is partial
        warning('The last frame is partial and therefore ignored.');
    end
end