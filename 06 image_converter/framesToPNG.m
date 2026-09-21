function framesToPNG(erosFrames,outputImageFolder)   
    frameNr = size(erosFrames,1);
    %Use constant string width instead is better maybe when comparing
    strWidth = 6;
    for j = 1:frameNr
        %strWidth = numel(num2str(frameNr));
        strNr = sprintf(['%0' num2str(strWidth) 'd'], j-1);
        fileName = '';
        %TODO fixa filnummer börjar räkna från noll!
        fileNr = strNr;
        fileExt = '.png';

        fileNameAll = [fileName,fileNr,fileExt];

        %konstigt med squeeze?
        frameToFile = squeeze(erosFrames(j,:,:));
        imwritePath = strcat(outputImageFolder,fileNameAll);
        imwrite(frameToFile,imwritePath);
    end
end