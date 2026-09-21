function fileNameAll = framesToMP4(frames,fileFolder,fps)

fileName = 'output_video';
fileExt = '.mp4';
fileEncoding = 'MPEG-4';

fileNameAll = [fileFolder,fileName,fileExt];

v = VideoWriter(fileNameAll,fileEncoding);
%v = VideoWriter('output/video/output_video.avi', 'Uncompressed AVI');
v.Quality = 100;
v.FrameRate = fps;
open(v);

for k = 1:size(frames,1)
    tFrame = squeeze(frames(k,:,:));
    writeVideo(v, tFrame);
end

close(v);