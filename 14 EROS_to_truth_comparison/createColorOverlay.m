function colorImg = createColorOverlay(processedFrame, refImg, tol,detectionThresh)
%CREATECOLOROVERLAY Generate alpha-blended color EROS overlay image


MAE_metrics = computeMAE_paddedCanny(refImg, processedFrame, tol,detectionThresh);

% Base grayscale
grayFrame = mat2gray(processedFrame);
colorImg = repmat(grayFrame,1,1,3);

% Define alpha strengths
baseAlpha = 0.6;       % for TP, TN, FP, P
baseAlphaStrong = 0.9; % for FN

% Blend helper function
blend = @(bg, fg, alpha) bg .* (1-alpha) + fg .* alpha;

% TP (white)
fg = ones(size(colorImg));
alpha = baseAlpha * MAE_metrics.TP_mask;
for c = 1:3
    colorImg(:,:,c) = blend(colorImg(:,:,c), fg(:,:,c), alpha);
end

% TN (blue)
fg = cat(3, zeros(size(grayFrame)), zeros(size(grayFrame)), ones(size(grayFrame)));
alpha = baseAlpha * MAE_metrics.TN_mask;
for c = 1:3
    colorImg(:,:,c) = blend(colorImg(:,:,c), fg(:,:,c), alpha);
end

% FP (red)
fg = cat(3, ones(size(grayFrame)), zeros(size(grayFrame)), zeros(size(grayFrame)));
alpha = baseAlpha * MAE_metrics.FP_mask;
for c = 1:3
    colorImg(:,:,c) = blend(colorImg(:,:,c), fg(:,:,c), alpha);
end

% FN (green)
fg = cat(3, zeros(size(grayFrame)), ones(size(grayFrame)), zeros(size(grayFrame)));
alpha = baseAlphaStrong * MAE_metrics.FN_mask;
for c = 1:3
    colorImg(:,:,c) = blend(colorImg(:,:,c), fg(:,:,c), alpha);
end

% P / tolerance mask (yellow)
fg = cat(3, ones(size(grayFrame)), ones(size(grayFrame)), zeros(size(grayFrame)));
alpha = baseAlpha * MAE_metrics.P_mask;
for c = 1:3
    colorImg(:,:,c) = blend(colorImg(:,:,c), fg(:,:,c), alpha);
end

% Clip
colorImg = min(max(colorImg,0),1);
end