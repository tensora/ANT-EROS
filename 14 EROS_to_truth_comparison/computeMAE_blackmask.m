%Compute True positives, True Negatives, False positives, False Negatives:
%of a ground truth image consisting of either 1 or zero, and an estimate consisting of
% a grayscale image with values between 0 and 1.

function MAE_metrics = computeMAE_blackmask(true_image,estimate_image)

    % Classification threshold for the estimate image
    my_thresh = 0.1;

    %black threshold
    black_thresh = 0.05;
    % Foreground mask: include pixel if either image is non-black
    fg_mask = (true_image > 0) | (estimate_image > black_thresh);

    % Create binary predictions
    pred_image = estimate_image >= my_thresh;

    % Absolute error per pixel
    abs_diff = abs(true_image - estimate_image);

    total_pixels = numel(true_image);

    % Masks
    TP_mask = (true_image == 1) & (pred_image == 1);
    TN_mask = (true_image == 0) & (pred_image == 0);

    FP_mask = (true_image == 0) & (pred_image == 1);
    FN_mask = (true_image == 1) & (pred_image == 0);

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

    %threshold for the moment
    MAE_metrics.my_thresh = my_thresh;

    %also save masks
    MAE_metrics.TP_mask = TP_mask;
    MAE_metrics.TN_mask = TN_mask;
    MAE_metrics.FP_mask = FP_mask;
    MAE_metrics.FN_mask = FN_mask;


end