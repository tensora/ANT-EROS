function mask = paddedMask(image, thickness)
    % INPUT:
    %   image     - grayscale image
    %   thickness - positive integer
    %
    % OUTPUT:
    %   mask      - logical mask of padded region (0 or 1)

    orig = image > 0;    % binary ink mask

    se = strel('square', 2*thickness + 1);
    dil = imdilate(orig, se);
    
    mask = dil & ~orig;  % remove original region



end
