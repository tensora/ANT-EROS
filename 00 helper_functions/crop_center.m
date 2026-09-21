function [B, x_min, x_max, y_min, y_max] = crop_center(A, newH, newW)
%CROP_CENTER Crop center region and return crop limits.
%   [B, x_min, x_max, y_min, y_max] = CROP_CENTER(A, newH, newW)
%   crops the center region of size newH-by-newW from the last two
%   dimensions of A and returns the crop limits (1-based indices).
%
%   Supports:
%     - 2D input A (H x W) -> B (newH x newW)
%     - 3D input A (N x H x W) -> B (N x newH x newW)
%
%   x corresponds to columns (width), y corresponds to rows (height).
%
%   Example:
%     A = rand(5,480,640);                  % N x H x W
%     [B, xmin, xmax, ymin, ymax] = crop_center(A,240,320);
%     % xmin..xmax are in 1..640, ymin..ymax are in 1..480

    % Basic checks
    narginchk(3,3);
    if ~isnumeric(A)
        error('Input A must be numeric.');
    end
    if ~(isscalar(newH) && newH==floor(newH) && newH>0)
        error('newH must be a positive integer scalar.');
    end
    if ~(isscalar(newW) && newW==floor(newW) && newW>0)
        error('newW must be a positive integer scalar.');
    end

    sz = size(A);
    nd = ndims(A);

    switch nd
        case 2
            H = sz(1);
            W = sz(2);
            is3D = false;
        case 3
            N = sz(1); %#ok<NASGU>
            H = sz(2);
            W = sz(3);
            is3D = true;
        otherwise
            error('Input A must be 2D or 3D (H x W or N x H x W).');
    end

    if newH > H || newW > W
        error('Requested size [%d x %d] is larger than input size [%d x %d].', newH, newW, H, W);
    end

    % Compute center start/end (rows = y, cols = x)
    y_min = floor((H - newH)/2) + 1;
    y_max = y_min + newH - 1;

    x_min = floor((W - newW)/2) + 1;
    x_max = x_min + newW - 1;

    % Crop
    if is3D
        B = A(:, y_min:y_max, x_min:x_max);
    else
        B = A(y_min:y_max, x_min:x_max);
    end
end
