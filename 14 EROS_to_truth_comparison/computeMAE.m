%Compute True positives, True Negatives, False positives, False Negatives:
%of a ground truth image consisting of either 1 or zero, and an estimate consisting of
% a grayscale image with values between 0 and 1.

function MAE_metrics = computeMAE(true_image,estimate_image)

    %my_threshold = 0.1;

    difference = true_image - estimate_image;

    total_pixels = numel(difference);
    
    %TN:True negatives and their MAE (Mean absolute error)
    %If truth is 0 and estimate is also 0.
    TN_mask = (true_image == 0) & (estimate_image == 0);
    TN_num = sum(TN_mask(:));
    TN_percent_all = (TN_num / total_pixels) * 100;

    %FN:False negatives and their MAE (Mean absolute error)
    %If truth is 1 and estimate is 0.
    FN_mask = (true_image == 1) & (estimate_image == 0);
    FN_num = sum(FN_mask(:));
    FN_percent_all = (FN_num / total_pixels) * 100;

    %TP: True positives and their MAE (Mean absolute error)
    TP_mask = (true_image == 1) & (estimate_image > 0) & (estimate_image <= 1);
    TP_num = sum(TP_mask(:));
    TP_percent_all = (TP_num / total_pixels) * 100; 

    %FP: False positives and their MAE (Mean absolute error)
    FP_mask = (true_image == 0) & (estimate_image > 0) & (estimate_image <= 1);
    FP_num = sum(FP_mask(:));
    FP_percent_all = (FP_num / total_pixels) * 100; 

    %All mean absolute errors
    % Difference absolute values
    abs_diff = abs(difference);

    MAE_TP = mean(abs_diff(TP_mask));
    MAE_TN = mean(abs_diff(TN_mask));
    MAE_FP = mean(abs_diff(FP_mask));
    MAE_FN = mean(abs_diff(FN_mask));

    %Store in the output variable:
    MAE_metrics.TP_percent = TP_percent_all;
    MAE_metrics.TN_percent = TN_percent_all;
    MAE_metrics.FP_percent = FP_percent_all;
    MAE_metrics.FN_percent = FN_percent_all;
    
    MAE_metrics.MAE_TP = MAE_TP;
    MAE_metrics.MAE_TN = MAE_TN;
    MAE_metrics.MAE_FP = MAE_FP;
    MAE_metrics.MAE_FN = MAE_FN;

end