function mae_weighted = balanced_mae(truth, est)
%BALANCED_MAE Computes class-balanced mean absolute error
%
%   mae_weighted = balanced_mae(truth, est)
%
%   Inputs:
%       truth - matrix of 0s and 1s
%       est   - matrix of same size (grayscale or numeric)
%
%   Output:
%       mae_weighted - balanced mean absolute error

    % Ensure inputs are same size
    if ~isequal(size(truth), size(est))
        error('truth and est must have the same size');
    end

    diff = abs(truth - est);

    pos_idx = truth == 1;
    neg_idx = truth == 0;

    mae_vals = [];

    if any(pos_idx(:))
        mae_vals(end+1) = mean(diff(pos_idx));
    end

    if any(neg_idx(:))
        mae_vals(end+1) = mean(diff(neg_idx));
    end

    % Final balanced MAE
    mae_weighted = mean(mae_vals);

end