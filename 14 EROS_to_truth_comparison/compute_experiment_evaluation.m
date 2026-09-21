function metrics_mean_std = compute_experiment_evaluation(tp_per_frame, tn_per_frame, fp_per_frame, fn_per_frame, ...
                                                          tp_MAE_per_frame, tn_MAE_per_frame, fp_MAE_per_frame, fn_MAE_per_frame, ...
                                                          tot_MAE_per_frame, tot_MAE_per_frame_no_tn, tot_MAEbal_per_frame)
% COMPUTE_EXPERIMENT_EVALUATION Computes mean ± std for TP, TN, FP, FN, MAE, and derived metrics
%
% Inputs:
%   tp_per_frame, tn_per_frame, fp_per_frame, fn_per_frame           : percent vectors per frame
%   tp_MAE_per_frame, tn_MAE_per_frame, fp_MAE_per_frame, fn_MAE_per_frame : MAE vectors per frame
%   tot_MAE_per_frame, tot_MAE_per_frame_no_tn                        : total MAE vectors per frame
%
% Output:
%   metrics_mean_std : struct containing mean and std for 30 metrics

    Nframes = length(tp_per_frame);
    
    % --- 1. Compute derived metrics per frame ---
    precision_per_frame = NaN(Nframes,1);
    recall_per_frame    = NaN(Nframes,1);
    accuracy_per_frame  = NaN(Nframes,1);
    specificity_per_frame = NaN(Nframes,1);
    F1_per_frame = NaN(Nframes,1);

    for i = 1:Nframes
        TP = tp_per_frame(i);
        TN = tn_per_frame(i);
        FP = fp_per_frame(i);
        FN = fn_per_frame(i);

        % Precision
        if TP+FP > 0
            precision_per_frame(i) = 100*TP/(TP+FP);
        else
            precision_per_frame(i) = NaN;
        end

        % Recall
        if TP+FN > 0
            recall_per_frame(i) = 100*TP/(TP+FN);
        else
            recall_per_frame(i) = NaN;
        end

        % Accuracy
        total_pixels = TP + TN + FP + FN;
        if total_pixels > 0
            accuracy_per_frame(i) = 100*(TP+TN)/total_pixels;
        else
            accuracy_per_frame(i) = NaN;
        end

        % Specificity
        if TN+FP > 0
            specificity_per_frame(i) = 100*TN/(TN+FP);
        else
            specificity_per_frame(i) = NaN;
        end

        % F1-score
        if precision_per_frame(i)+recall_per_frame(i) > 0
            F1_per_frame(i) = 2*(precision_per_frame(i)*recall_per_frame(i)) / ...
                              (precision_per_frame(i)+recall_per_frame(i));
        else
            F1_per_frame(i) = NaN;
        end
    end

    % --- 2. Compute mean and standard deviation for all metrics ---
    metrics_mean_std = struct();

    % Percent metrics
    metrics_mean_std.tp_mean  = mean(tp_per_frame,'omitnan');  metrics_mean_std.tp_std  = std(tp_per_frame,'omitnan');
    metrics_mean_std.tn_mean  = mean(tn_per_frame,'omitnan');  metrics_mean_std.tn_std  = std(tn_per_frame,'omitnan');
    metrics_mean_std.fp_mean  = mean(fp_per_frame,'omitnan');  metrics_mean_std.fp_std  = std(fp_per_frame,'omitnan');
    metrics_mean_std.fn_mean  = mean(fn_per_frame,'omitnan');  metrics_mean_std.fn_std  = std(fn_per_frame,'omitnan');

    % MAE metrics
    metrics_mean_std.tp_MAE_mean = mean(tp_MAE_per_frame,'omitnan'); metrics_mean_std.tp_MAE_std = std(tp_MAE_per_frame,'omitnan');
    metrics_mean_std.tn_MAE_mean = mean(tn_MAE_per_frame,'omitnan'); metrics_mean_std.tn_MAE_std = std(tn_MAE_per_frame,'omitnan');
    metrics_mean_std.fp_MAE_mean = mean(fp_MAE_per_frame,'omitnan'); metrics_mean_std.fp_MAE_std = std(fp_MAE_per_frame,'omitnan');
    metrics_mean_std.fn_MAE_mean = mean(fn_MAE_per_frame,'omitnan'); metrics_mean_std.fn_MAE_std = std(fn_MAE_per_frame,'omitnan');

    

    % Derived metrics
    metrics_mean_std.precision_mean   = mean(precision_per_frame,'omitnan');   metrics_mean_std.precision_std   = std(precision_per_frame,'omitnan');
    metrics_mean_std.recall_mean      = mean(recall_per_frame,'omitnan');      metrics_mean_std.recall_std      = std(recall_per_frame,'omitnan');
    metrics_mean_std.accuracy_mean    = mean(accuracy_per_frame,'omitnan');    metrics_mean_std.accuracy_std    = std(accuracy_per_frame,'omitnan');
    metrics_mean_std.specificity_mean = mean(specificity_per_frame,'omitnan'); metrics_mean_std.specificity_std = std(specificity_per_frame,'omitnan');
    metrics_mean_std.F1_mean          = mean(F1_per_frame,'omitnan');          metrics_mean_std.F1_std          = std(F1_per_frame,'omitnan');

    % Total MAE
    metrics_mean_std.tot_MAE_mean       = mean(tot_MAE_per_frame,'omitnan');       metrics_mean_std.tot_MAE_std       = std(tot_MAE_per_frame,'omitnan');
    metrics_mean_std.tot_MAE_noTN_mean  = mean(tot_MAE_per_frame_no_tn,'omitnan'); metrics_mean_std.tot_MAE_noTN_std  = std(tot_MAE_per_frame_no_tn,'omitnan');

    %MAE balanced added
    metrics_mean_std.tot_MAEbal_mean  = mean(tot_MAEbal_per_frame,'omitnan'); metrics_mean_std.tot_MAEbal_std  = std(tot_MAEbal_per_frame,'omitnan');
end
