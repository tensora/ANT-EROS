function csvFilePath = save_evaluation_to_excel(metrics_struct,data_extra_info,resultVectors, saveFolder)
% SAVE_EVALUATION_TO_EXCEL Save summary metrics as a semicolon-separated Excel file

    % --- Metric definitions ---
    metricNames = { ...
        'tp','tn','fp','fn', ...
        'tp_MAE','tn_MAE','fp_MAE','fn_MAE', ...
        'precision','recall','accuracy','specificity','F1', ...
        'tot_MAE','tot_MAE_noTN','tot_MAEbal'};

    metricDescriptions = { ...
        'True positives (%)', 'True negatives (%)', 'False positives (%)', 'False negatives (%)', ...
        'True positives MAE', 'True negatives MAE', 'False positives MAE', 'False negatives MAE', ...
        'Precision (%)', 'Recall (%)', 'Accuracy (%)', 'Specificity (%)', 'F1 score (%)', ...
        'Total MAE', 'Total MAE (without TN)','Total MAE balanced'};

    % Metrics that should be treated as MAE (3 decimals)
    maeMetrics = contains(metricNames, 'MAE');

    nMetrics = numel(metricNames);
    dataCell = cell(nMetrics, 2);

    % --- Format metrics ---
    for i = 1:nMetrics
        meanField = [metricNames{i}, '_mean'];
        stdField  = [metricNames{i}, '_std'];

        meanVal = metrics_struct.(meanField);
        stdVal  = metrics_struct.(stdField);

        if maeMetrics(i)
            % MAE → 0.000 ± 0.000
            valueStr = sprintf('%.3f ± %.3f', meanVal, stdVal);
        else
            % Percentages / rates → 00.00 ± 00.00
            valueStr = sprintf('%.2f ± %.2f', meanVal, stdVal);
        end

        dataCell{i,1} = metricDescriptions{i};
        dataCell{i,2} = valueStr;
    end

    % ==========================================================
    % --- Append extra information section ---
    % ==========================================================
    
    extraInfoCell = {
        '', '';
        '--- Additional Information ---', '';
        'Frame count',         sprintf('%d', data_extra_info.frameCount);
        'Event count',         sprintf('%d', data_extra_info.eventCount);
        'Time per frame (µs)', sprintf('%.2f', data_extra_info.timePerFrameUs);
        'Total time (µs)',     sprintf('%.2f', data_extra_info.totalTimeUs);
        'Retinal width (px)',  sprintf('%d', data_extra_info.retinalWidth);
        'Retinal height (px)', sprintf('%d', data_extra_info.retinalHeight);
    };
    % Combine metric + extra info
    dataCell = [dataCell; extraInfoCell];


    % --- Save Excel file ---
    csvFile = fullfile(saveFolder, 'EvaluationMetrics.csv');
    T = cell2table(dataCell, 'VariableNames', {'Metric','Value'});

    writetable(T, csvFile, 'Delimiter', ';');

    % --- Save resultVectors struct as MAT file ---
    matFilePath = fullfile(saveFolder, 'ResultVectors.mat');
    save(matFilePath, 'resultVectors', '-v7.3');

    fprintf('Result vectors saved to: %s\n', matFilePath);
    fprintf('Evaluation metrics saved to: %s\n', csvFile);

    csvFilePath = csvFile;
end
