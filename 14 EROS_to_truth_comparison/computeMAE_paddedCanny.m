%Compute True positives, True Negatives, False positives, False Negatives:
%of a ground truth image consisting of either 1 or zero, and an estimate consisting of
% a grayscale image with values between 0 and 1.

function MAE_metrics = computeMAE_paddedCanny(true_image,estimate_image,padThickness,detectionThresh)

    %Calculate a padding around the true image. This is a no-man's land that
    %should be excluded from all the calculations below. What i mean is,
    %all 4 detection masks below should have this true_image_padding area
    %removed from them so that they are excluded from the calculations.
    true_image_padding = paddedMask(true_image,padThickness);

    %This is a mask for all areas that are valid. Where we can do our
    %calculations.
    %Problems can occur if valid mask is all false at some point!
    valid_mask = ~true_image_padding;

    % Classification threshold for the estimate image
    %my_thresh = 0.2;
    my_thresh = detectionThresh;

    %black threshold
    black_thresh = 0.0;
    %black_thresh = 0.05;
    %black_thresh = 0.1;

    % Foreground mask: include pixel if either image is non-black
    %fg_mask = (true_image > 0) | (estimate_image > black_thresh);
    fg_mask = (true_image > 0) | (estimate_image >= black_thresh);
    fg_mask = fg_mask & valid_mask;

    % Create binary predictions
    pred_image = estimate_image >= my_thresh;

    % Absolute error per pixel
    abs_diff = abs(true_image - estimate_image);

    %total_pixels = numel(true_image);
    total_pixels = sum(valid_mask(:));

    % Masks
    TP_mask = (true_image == 1) & (pred_image == 1);
    TN_mask = (true_image == 0) & (pred_image == 0);
    FP_mask = (true_image == 0) & (pred_image == 1);
    FN_mask = (true_image == 1) & (pred_image == 0);

    % Exclude padded areas from the masks
    TP_mask = TP_mask & valid_mask;
    TN_mask = TN_mask & valid_mask;
    FP_mask = FP_mask & valid_mask;
    FN_mask = FN_mask & valid_mask;
    P_mask = true_image_padding;

    % Percent of total pixels
    MAE_metrics.TP_percent = 100 * sum(TP_mask(:)) / total_pixels;
    MAE_metrics.TN_percent = 100 * sum(TN_mask(:)) / total_pixels;
    MAE_metrics.FP_percent = 100 * sum(FP_mask(:)) / total_pixels;
    MAE_metrics.FN_percent = 100 * sum(FN_mask(:)) / total_pixels;

    % Mean Absolute Errors (returns nan if there are problems)
    MAE_metrics.MAE_TP = mean(abs_diff(TP_mask));
    MAE_metrics.MAE_TN = mean(abs_diff(TN_mask));
    MAE_metrics.MAE_FP = mean(abs_diff(FP_mask));
    MAE_metrics.MAE_FN = mean(abs_diff(FN_mask));

    %total MAE used for optimization
    %MAE_total = mean(abs_diff(:));
    if any(fg_mask(:))
        MAE_total = mean(abs_diff(fg_mask));
    else
        MAE_total = 0; % or NaN, depending on your preference
    end

    MAE_metrics.MAE_ALL = MAE_total;

    %add the balanced mae as a metric:
    MAE_metrics.MAE_BALANCED = balanced_mae(true_image,estimate_image);

    %threshold for the moment
    MAE_metrics.my_thresh = my_thresh;

    %also save masks
    MAE_metrics.TP_mask = TP_mask;
    MAE_metrics.TN_mask = TN_mask;
    MAE_metrics.FP_mask = FP_mask;
    MAE_metrics.FN_mask = FN_mask;
    MAE_metrics.P_mask = P_mask;

    %Compute F1 metric
    % Calculate precision and recall
    precision = sum(TP_mask(:)) / (sum(TP_mask(:)) + sum(FP_mask(:)));
    recall = sum(TP_mask(:)) / (sum(TP_mask(:)) + sum(FN_mask(:)));

    % Compute F1 score
    if precision + recall > 0
        MAE_metrics.F1_score = 2 * (precision * recall) / (precision + recall);
    else
        MAE_metrics.F1_score = 0; % Handle case where precision and recall are both zero
    end

    % MAE ignoring True Negatives
    MAE_metrics.MAE_no_TN = (MAE_metrics.MAE_TP*sum(TP_mask(:)) + ...
                             MAE_metrics.MAE_FP*sum(FP_mask(:)) + ...
                             MAE_metrics.MAE_FN*sum(FN_mask(:))) / ...
                            (sum(TP_mask(:)) + sum(FP_mask(:)) + sum(FN_mask(:)));


end