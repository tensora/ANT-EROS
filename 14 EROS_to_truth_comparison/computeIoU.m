function iouValue = computeIoU(procFrame, imagePath)
% computeIoU  Compute IoU between a processed frame (double 0–1) and a binary image file.
%
% Usage:
%   iouValue = computeIoU(procFrame, imagePath)
%
% Inputs:
%   procFrame - double matrix, values 0–1 (from processOneFrame)
%   imagePath - string, full path to a grayscale or binary .png image
%
% Output:
%   iouValue - Intersection over Union (scalar between 0 and 1)

    % --- Read comparison image ---
    refImg = imread(imagePath);
    if size(refImg,3) == 3
        refImg = rgb2gray(refImg);
    end

    % --- Convert to double 0–1 ---
    refImg = im2double(refImg);

    % --- Binarize both images ---
    % Otsu's method or fixed threshold (tune if needed)
    level1 = graythresh(procFrame)
    bw1 = imbinarize(procFrame, level1);

    level2 = graythresh(refImg);
    bw2 = imbinarize(refImg, level2);

    % --- Compute IoU ---
    intersection = bw1 & bw2;
    unionArea    = bw1 | bw2;
    iouValue = sum(intersection(:)) / sum(unionArea(:) + eps);

end
