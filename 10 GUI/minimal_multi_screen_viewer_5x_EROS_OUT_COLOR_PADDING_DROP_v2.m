function minimal_multi_screen_viewer_5x_EROS_OUT_COLOR_PADDING_DROP_v2(erosFrames_double,fps_stat,ePerFrameList_in,micro,x_data,y_data,pol_data,t_data,retinaRes,path_reconstructed,path_canny,...
                                                                       cannyReconstructStartFrame,cannyReconstructEndFrame,mySystem)
%MINIMAL_DOUBLE_VIEWER_C_ASYMP  Interactive viewer with GAUSS controls and sigmoid decomposition

%% =========================== Initialization ===========================

%----ePerFrameList should come from the outside - not created here----%
usPerFrame = round((1 / fps_stat) * 1e6);
ePerFrameList = ePerFrameList_in;
ePerFrameCumsum = cumsum(ePerFrameList);

% Derive frame size from input
% Expect erosFrames_double as [Nframes x H x W]
[Nin, H0, W0] = size(erosFrames_double);
blackFrame = zeros(H0, W0);

% Crop for smaller frame (center)
halfWidth = floor(W0/2);
halfHeight = floor(H0/2);
[blackFrameHalf, xf_min, xf_max, yf_min, yf_max] = crop_center(blackFrame, halfHeight, halfWidth);

x_half_mask = x_data >= xf_min & x_data <= xf_max;
y_half_mask = y_data >= yf_min & y_data <= yf_max;
combined_half_mask = x_half_mask & y_half_mask;
filtered_half_x = x_data(combined_half_mask);
filtered_half_y = y_data(combined_half_mask);
filtered_half_pol = pol_data(combined_half_mask);
filtered_half_t = t_data(combined_half_mask);

ePerFrameListHalf = chunk(countEvents(filtered_half_t), usPerFrame);
ePerFrameCumsumHalf = cumsum(ePerFrameListHalf);

% Processed frames buffer (same shape as input frames)
erosFramesProcessed = erosFrames_double; %[N x H x W]
erosFramesProcessedR = erosFrames_double; %[N x H x W]

% Frames for viewing: H x W x N
frames = permute(erosFrames_double, [2 3 1]);
[H, W, Nframes] = size(frames);

%% =========================== Create Figures ===========================

hFig = figure('Name', 'Minimal Double Viewer', 'NumberTitle', 'off', ...
    'MenuBar', 'none', 'ToolBar', 'none', 'Color', [1 1 1]);

% --- Layout parameters ---
mainImageY = 0.40;
mainImageHeight = 0.55;
mainImageWidth = 0.37;
mainImageGap = 0;       % gap between images

smallImageWidth = 0.25;    % width of the small stacked images
smallImageHeight = smallImageWidth;   % each small image's height
stackGap = 0.00;           % gap between top and bottom small images

% Left big image position
mainImageX_L = 0.00-0.008+0.01;

% Middle column X (centered between left and right big images)
middleX = mainImageX_L + mainImageWidth + mainImageGap -0.03;

% Right big image position
mainImageX_R = middleX + smallImageWidth + mainImageGap - 0.03 + 0.01 + 0.055;

% Compute Y positions for stacked small images
smallImageY_top = mainImageY + (mainImageHeight - (2 * smallImageHeight + stackGap)) / 2 + smallImageHeight + stackGap/2;
smallImageY_bottom = smallImageY_top - (smallImageHeight + stackGap)-0.02;


% Main image axes
hAx = axes('Parent', hFig, 'Units', 'normalized', 'Position', [mainImageX_L mainImageY mainImageWidth mainImageHeight]);
hIm = imshow(frames(:, :, 1), [0 1], 'Parent', hAx);
axis(hAx, 'image', 'off');
colormap(hAx, gray);
%colormap(hAx, turbo);

% Create middle stacked small images
hAxSmallTop = axes('Parent', hFig, 'Units', 'normalized', ...
    'Position', [middleX+0.065 smallImageY_top+0.07 smallImageWidth-0.07 smallImageHeight-0.07]);
axis(hAxSmallTop, 'on');


hAxSmallBottom = axes('Parent', hFig, 'Units', 'normalized', ...
    'Position', [middleX-0.023 smallImageY_bottom 0.36 0.36]);
axis(hAxSmallBottom, 'on');

% Store for later use
setappdata(hFig, 'hAxSmallTop', hAxSmallTop);
setappdata(hFig, 'hAxSmallBottom', hAxSmallBottom);

% Call your function with top image
shiftedIDXStart = 1 + cannyReconstructStartFrame-1;
showReconstructedImageLeft(hFig, shiftedIDXStart, 'top');

% Call your function with bottom image
showReconstructedImageLeft(hFig, shiftedIDXStart, 'bottom');

% ===== RIGHT image =====
hAxRight = axes('Parent', hFig, 'Units', 'normalized', 'Position', [mainImageX_R mainImageY mainImageWidth mainImageHeight]); 
hImRight = imshow(frames(:, :, 1), [0 1], 'Parent', hAxRight);
axis(hAxRight, 'image', 'off');
colormap(hAxRight, gray);

% Title
hTxt = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [0.05 0.96 0.9 0.03], 'String', sprintf('Frame 1 / %d', Nframes), ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', 'k', 'HorizontalAlignment', 'center');

%% =========================== MAE tables ============================

% Sample data
percent_true_pos   = NaN; MAE_true_pos   = NaN;
percent_true_neg   = NaN; MAE_true_neg   = NaN;
percent_false_pos  = NaN; MAE_false_pos  = NaN;
percent_false_neg  = NaN; MAE_false_neg  = NaN;

% Sample data (replace NaN with real values from your computation)
threshold = NaN;  % your threshold
MAE_total = NaN;  % computed total MAE
F1_score = NaN;
MAE_no_TN = NaN;

% Create cell array with formatted strings
data = {
    sprintf('white %d%%\nMAE: %.2f', percent_true_pos, MAE_true_pos),   sprintf('blue %d%%\nMAE: %.2f', percent_true_neg, MAE_true_neg);
    sprintf('red %d%%\nMAE: %.2f', percent_false_pos, MAE_false_pos), sprintf('green %d%%\nMAE: %.2f', percent_false_neg, MAE_false_neg);
    sprintf('%.2f', threshold),                                  sprintf('%.2f', MAE_total);
    sprintf('F1 score %.2f', F1_score), sprintf('MAE no TN %.2f', MAE_no_TN)
};

% Create the tables
tableLeft = uitable(hFig, ...
    'Data', data, ...
    'ColumnName', {'Positive', 'Negative'}, ...
    'RowName', {'True', 'False','Summary','Metric'}, ...
    'FontSize', 9, ...
    'Units', 'normalized', ...
    'Position', [0.38 0.17 0.13 0.16], ...
    'ColumnEditable', [false false]);  % make sure only two columns exist

tableRight = uitable(hFig, ...
    'Data', data, ...
    'ColumnName', {'Positive', 'Negative'}, ...
    'RowName', {'True', 'False','Summary','Metric'}, ...
    'FontSize', 9, ...
    'Units', 'normalized', ...
    'Position', [0.85 0.17 0.13 0.16], ...
    'ColumnEditable', [false false]);  

% Store handles in the figure app data
setappdata(hFig, 'tableLeft', tableLeft);
setappdata(hFig, 'tableRight', tableRight);

%% =========================== Sliders ===========================

% Play slider
playControlHeight = 0.955;
hSlider = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [0.05 playControlHeight 0.76 0.02], 'Min', 1, 'Max', Nframes, 'Value', 1, ...
    'SliderStep', [1/(max(1,Nframes-1)) min(1,10/(max(1,Nframes-1)))], ...
    'Callback', @(src, ~) onSlider(src, hFig));

% Play/Pause toggle
hToggle = uicontrol('Style', 'togglebutton', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [0.82 playControlHeight 0.13 0.02], 'String', 'Play', ...
    'Callback', @(src, ~) onToggle(src, hFig));


allSliderX_txt = 0.05;
allSliderWidth_txt = 0.09;
allSliderX_sld = allSliderX_txt+allSliderWidth_txt;
allSliderWidth_sld = 0.25;
allSliderX_lbl = allSliderX_sld+allSliderWidth_sld;
allSliderWidth_lbl = 0.12;

allSliderX_txtR = 0.5;
allSliderX_sldR = allSliderX_txtR+allSliderWidth_txt;
allSliderX_lblR = allSliderX_sldR+allSliderWidth_sld;


% Radius slider (discrete)
txtRadius = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [allSliderX_txt 0.14 allSliderWidth_txt 0.025], 'String', 'kEROS (window radius)', ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', [1 0.5 0], 'HorizontalAlignment', 'left', 'FontSize', 9);
radiusDiscreteValues = 1:1:20;
values = radiusDiscreteValues;
range = values(end) - values(1);
if range <= 0
    minorStep = 0; majorStep = 1;
else
    minorStep = (values(2) - values(1)) / range;
    majorStep = (values(min(6, end)) - values(1)) / range;
end
sldRadius = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [allSliderX_sld 0.14 allSliderWidth_sld 0.03], 'Min', radiusDiscreteValues(1), 'Max', radiusDiscreteValues(end), ...
    'Value', radiusDiscreteValues(1), 'SliderStep', [minorStep majorStep], 'Callback', @(src, ~) sliderChanged(src, hFig));
lblRadius = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [allSliderX_lbl 0.14 allSliderWidth_lbl 0.03], 'String', '1', 'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', [1 0.5 0], ...
    'HorizontalAlignment', 'left', 'FontSize', 9);

% Radius slider (discrete) RIGHT
txtRadiusR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [allSliderX_txtR 0.14 allSliderWidth_txt 0.025], 'String', 'kEROS (window radius)', ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', [1 0.5 0], 'HorizontalAlignment', 'left', 'FontSize', 9);
sldRadiusR = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [allSliderX_sldR 0.14 allSliderWidth_sld 0.03], 'Min', radiusDiscreteValues(1), 'Max', radiusDiscreteValues(end), ...
    'Value', radiusDiscreteValues(1), 'SliderStep', [minorStep majorStep], 'Callback', @(src, ~) sliderChangedR(src, hFig));
lblRadiusR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [allSliderX_lblR 0.14 allSliderWidth_lbl 0.03], 'String', '1', 'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', [1 0.5 0], ...
    'HorizontalAlignment', 'left', 'FontSize', 9);

%% GAUSS sliders (stacked in one column) — reordered + colored labels
sliderW = 0.25; labelW = 0.09; valueW = 0.12; labelWSetEvent = 0.015;
colLabelX = 0.05; colSliderX = colLabelX+labelW; colValueX = colSliderX+sliderW;
topY = 0.10-0.015*2-0.01; dy = 0.015; sliderH = 0.015;

colLabelXR = 0.5; 
colSliderXR = colLabelXR+labelW;
colValueXR = colSliderXR+sliderW;

% Colors for parts (match plot colors)
colG = [0.85 0.33 0.1];   % orange
colH = [0 0.45 0.74];     % blue
colK = [0.47 0.67 0.19];  % green
colTotal = [0 0 0];       % black
violetColor = [0.6, 0, 0.8];  % example violet

% 0) set event (value)
txtSetEvent = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelX topY+dy*4 labelW sliderH], 'String', 'setEvent (r=0)', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);
se_min = 0; se_max = 5;
sldSetEvent = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderX topY+dy*4 sliderW sliderH], 'Min', se_min, 'Max', se_max, 'Value', 1.0, ...
    'SliderStep', [0.01/(se_max - se_min) 0.1], 'Callback', @(src, ~) sliderChanged(src, hFig));
lblSetEvent = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueX topY+dy*4 labelWSetEvent sliderH], 'String', sprintf('%.2f', get(sldSetEvent, 'Value')), ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);
% 0) set event (value) RIGHT
txtSetEventR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelXR topY+dy*4 labelW sliderH], 'String', 'setEvent (r=0)', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);
sldSetEventR = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderXR topY+dy*4 sliderW sliderH], 'Min', se_min, 'Max', se_max, 'Value', 1.0, ...
    'SliderStep', [0.01/(se_max - se_min) 0.1], 'Callback', @(src, ~) sliderChangedR(src, hFig));
lblSetEventR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueXR topY+dy*4 labelWSetEvent sliderH], 'String', sprintf('%.2f', get(sldSetEventR, 'Value')), ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);

%% --- Create new sliders/labels and store handles in appdata ---

% --- mEVENT (LEFT) -------------------------------------------------------
txtmEVENT = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelX topY+dy*3 labelW sliderH], 'String', 'mEVENT (L)', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);
me_min = -10; me_max = 10;                      % choose sensible range for m inside sigmoid
sldmEVENT = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderX topY+dy*3 sliderW sliderH], 'Min', me_min, 'Max', me_max, 'Value', -4.0, ...
    'SliderStep', [0.01/(me_max-me_min) 0.1], 'Callback', @(src, ~) sliderChanged(src, hFig));
lblmEVENT = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueX topY+dy*3 labelWSetEvent sliderH], 'String', sprintf('%.2f', get(sldmEVENT,'Value')), ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);

setappdata(hFig, 'sldmEVENT', sldmEVENT);
setappdata(hFig, 'lblmEVENT', lblmEVENT);

% --- mEVENT (RIGHT) ------------------------------------------------------
txtmEVENTR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelXR topY+dy*3 labelW sliderH], 'String', 'mEVENT (R)', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);
sldmEVENTR = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderXR topY+dy*3 sliderW sliderH], 'Min', me_min, 'Max', me_max, 'Value', -4.0, ...
    'SliderStep', [0.01/(me_max-me_min) 0.1], 'Callback', @(src, ~) sliderChangedR(src, hFig));
lblmEVENTR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueXR topY+dy*3 labelWSetEvent sliderH], 'String', sprintf('%.2f', get(sldmEVENTR,'Value')), ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);

setappdata(hFig, 'sldmEVENTR', sldmEVENTR);
setappdata(hFig, 'lblmEVENTR', lblmEVENTR);

% kEVENT (LEFT)
txtkEVENT = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelX topY+dy*2 labelW sliderH], 'String', 'kEVENT (L)', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', violetColor, 'HorizontalAlignment', 'left', 'FontSize', 9);
ke_min = 0; ke_max = 10;
sldkEVENT = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderX topY+dy*2 sliderW sliderH], ...
    'Min', ke_min, 'Max', ke_max, 'Value', 0, ...
    'SliderStep', [1/(ke_max-ke_min) 1/(ke_max-ke_min)], ...
    'Callback', @(src, ~) sliderChanged(src, hFig));
lblkEVENT = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueX topY+dy*2 labelWSetEvent sliderH], ...
    'String', sprintf('%d', round(get(sldkEVENT,'Value'))), ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', violetColor, 'HorizontalAlignment', 'left', 'FontSize', 9);

setappdata(hFig, 'sldkEVENT', sldkEVENT);
setappdata(hFig, 'lblkEVENT', lblkEVENT);

% kEVENT (RIGHT)
txtkEVENTR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelXR topY+dy*2 labelW sliderH], 'String', 'kEVENT (R)', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', violetColor, 'HorizontalAlignment', 'left', 'FontSize', 9);
sldkEVENTR = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderXR topY+dy*2 sliderW sliderH], ...
    'Min', ke_min, 'Max', ke_max, 'Value', 0, ...
    'SliderStep', [1/(ke_max-ke_min) 1/(ke_max-ke_min)], ...
    'Callback', @(src, ~) sliderChangedR(src, hFig));
lblkEVENTR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueXR topY+dy*2 labelWSetEvent sliderH], ...
    'String', sprintf('%d', round(get(sldkEVENTR,'Value'))), ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', violetColor, 'HorizontalAlignment', 'left', 'FontSize', 9);

setappdata(hFig, 'sldkEVENTR', sldkEVENTR);
setappdata(hFig, 'lblkEVENTR', lblkEVENTR);

% setEventTilt (LEFT)
txtTilt = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelX topY+dy*1 labelW sliderH], 'String', 'setEventTilt (L)', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);
tilt_min = -5; tilt_max = 5;
sldTilt = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderX topY+dy*1 sliderW sliderH], ...
    'Min', tilt_min, 'Max', tilt_max, 'Value', 0, ...
    'SliderStep', [0.01/(tilt_max-tilt_min) 0.1], ...
    'Callback', @(src, ~) sliderChanged(src, hFig));
lblTilt = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueX topY+dy*1 labelWSetEvent sliderH], ...
    'String', sprintf('%.2f', get(sldTilt,'Value')), ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);

setappdata(hFig, 'sldTilt', sldTilt);
setappdata(hFig, 'lblTilt', lblTilt);

% setEventTilt (RIGHT)
txtTiltR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelXR topY+dy*1 labelW sliderH], 'String', 'setEventTilt (R)', ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);
sldTiltR = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderXR topY+dy*1 sliderW sliderH], ...
    'Min', tilt_min, 'Max', tilt_max, 'Value', 0, ...
    'SliderStep', [0.01/(tilt_max-tilt_min) 0.1], ...
    'Callback', @(src, ~) sliderChangedR(src, hFig));
lblTiltR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueXR topY+dy*1 labelWSetEvent sliderH], ...
    'String', sprintf('%.2f', get(sldTiltR,'Value')), ...
    'BackgroundColor', [0 0 0], 'ForegroundColor', [1 1 1], 'HorizontalAlignment', 'left', 'FontSize', 9);

setappdata(hFig, 'sldTiltR', sldTiltR);
setappdata(hFig, 'lblTiltR', lblTiltR);

% (OPTIONAL) ensure your existing setEvent controls are stored too so callbacks can update them:
setappdata(hFig, 'sldSetEvent', sldSetEvent);
setappdata(hFig, 'lblSetEvent', lblSetEvent);
setappdata(hFig, 'sldSetEventR', sldSetEventR);
setappdata(hFig, 'lblSetEventR', lblSetEventR);


% 1) gGAUSS (vertical offset) - orange
txtGgauss = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelX topY labelW sliderH], 'String', 'gGAUSS (vertical offset)', ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colG, 'HorizontalAlignment', 'left', 'FontSize', 9);
g_min = -10; g_max = 10;
sldGgauss = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderX topY sliderW sliderH], 'Min', g_min, 'Max', g_max, 'Value', -1.5, ...
    'SliderStep', [0.01/(g_max - g_min) 0.1], 'Callback', @(src, ~) sliderChanged(src, hFig));
lblGgauss = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueX topY valueW sliderH], 'String', sprintf('%.2f', get(sldGgauss, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colG, 'HorizontalAlignment', 'left', 'FontSize', 9);


% 1) gGAUSS (vertical offset) - orange RIGHT
txtGgaussR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelXR topY labelW sliderH], 'String', 'gGAUSS (vertical offset)', ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colG, 'HorizontalAlignment', 'left', 'FontSize', 9);
sldGgaussR = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderXR topY sliderW sliderH], 'Min', g_min, 'Max', g_max, 'Value', -1.5, ...
    'SliderStep', [0.01/(g_max - g_min) 0.1], 'Callback', @(src, ~) sliderChangedR(src, hFig));
lblGgaussR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueXR topY valueW sliderH], 'String', sprintf('%.2f', get(sldGgaussR, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colG, 'HorizontalAlignment', 'left', 'FontSize', 9);

% 2) hGAUSS (tilt) - blue
y_h = topY - dy;
txtHgauss = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelX y_h labelW sliderH], 'String', 'hGAUSS (tilt)', ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colH, 'HorizontalAlignment', 'left', 'FontSize', 9);
h_min = -2; h_max = 2;
sldHgauss = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderX y_h sliderW sliderH], 'Min', h_min, 'Max', h_max, 'Value', 0.0, ...
    'SliderStep', [0.01/(h_max - h_min) 0.1], 'Callback', @(src, ~) sliderChanged(src, hFig));
lblHgauss = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueX y_h valueW sliderH], 'String', sprintf('%.2f', get(sldHgauss, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colH, 'HorizontalAlignment', 'left', 'FontSize', 9);

% 2) hGAUSS (tilt) - blue RIGHT
y_h = topY - dy;
txtHgaussR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelXR y_h labelW sliderH], 'String', 'hGAUSS (tilt)', ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colH, 'HorizontalAlignment', 'left', 'FontSize', 9);
h_min = -2; h_max = 2;
sldHgaussR = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderXR y_h sliderW sliderH], 'Min', h_min, 'Max', h_max, 'Value', 0.0, ...
    'SliderStep', [0.01/(h_max - h_min) 0.1], 'Callback', @(src, ~) sliderChangedR(src, hFig));
lblHgaussR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueXR y_h valueW sliderH], 'String', sprintf('%.2f', get(sldHgaussR, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colH, 'HorizontalAlignment', 'left', 'FontSize', 9);

% 3) kGAUSS (curve height/depth) - green
y_k = y_h - dy;
txtKgauss = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelX y_k labelW sliderH], 'String', 'kGAUSS (curve height/depth)', ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colK, 'HorizontalAlignment', 'left', 'FontSize', 9);
k_min = -20; k_max = 20;
sldKgauss = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderX y_k sliderW sliderH], 'Min', k_min, 'Max', k_max, 'Value', 0.0, ...
    'SliderStep', [0.01/(k_max - k_min) 0.1], 'Callback', @(src, ~) sliderChanged(src, hFig));
lblKgauss = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueX y_k valueW sliderH], 'String', sprintf('%.2f', get(sldKgauss, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colK, 'HorizontalAlignment', 'left', 'FontSize', 9);

% 3) kGAUSS (curve height/depth) - green RIGHT
y_k = y_h - dy;
txtKgaussR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelXR y_k labelW sliderH], 'String', 'kGAUSS (curve height/depth)', ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colK, 'HorizontalAlignment', 'left', 'FontSize', 9);
k_min = -20; k_max = 20;
sldKgaussR = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderXR y_k sliderW sliderH], 'Min', k_min, 'Max', k_max, 'Value', 0.0, ...
    'SliderStep', [0.01/(k_max - k_min) 0.1], 'Callback', @(src, ~) sliderChangedR(src, hFig));
lblKgaussR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueXR y_k valueW sliderH], 'String', sprintf('%.2f', get(sldKgaussR, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', colK, 'HorizontalAlignment', 'left', 'FontSize', 9);

% 4) r0 (horizontal shift) - black
y_r0 = y_k - dy;
txtR0 = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelX y_r0 labelW sliderH], ...
    'String', 'r0 (horizontal shift)', ...
    'BackgroundColor', get(hFig, 'Color'), ...
    'ForegroundColor', [0.47 0.67 0.19], ...  % <-- make green
    'HorizontalAlignment', 'left', 'FontSize', 9);
r_min = 0; r_max = 20;
sldR0 = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderX y_r0 sliderW sliderH], 'Min', r_min, 'Max', r_max, 'Value', 0, ...
    'SliderStep', [0.01/(r_max - r_min) 0.1], 'Callback', @(src, ~) sliderChanged(src, hFig));
lblR0 = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueX y_r0 valueW sliderH], ...
    'String', sprintf('%.2f', get(sldR0, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), ...
    'ForegroundColor', colK, ...   % <-- MAKE IT GREEN HERE
    'HorizontalAlignment', 'left', 'FontSize', 9);

% 4) r0 (horizontal shift) - black RIGHT
y_r0 = y_k - dy;
txtR0R = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelXR y_r0 labelW sliderH], ...
    'String', 'r0 (horizontal shift)', ...
    'BackgroundColor', get(hFig, 'Color'), ...
    'ForegroundColor', [0.47 0.67 0.19], ...  % <-- make green
    'HorizontalAlignment', 'left', 'FontSize', 9);
r_min = 0; r_max = 20;
sldR0R = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderXR y_r0 sliderW sliderH], 'Min', r_min, 'Max', r_max, 'Value', 0, ...
    'SliderStep', [0.01/(r_max - r_min) 0.1], 'Callback', @(src, ~) sliderChangedR(src, hFig));
lblR0R = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueXR y_r0 valueW sliderH], ...
    'String', sprintf('%.2f', get(sldR0R, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), ...
    'ForegroundColor', colK, ...   % <-- MAKE IT GREEN HERE
    'HorizontalAlignment', 'left', 'FontSize', 9);


% 5) sGAUSS (spread) - black
y_s = y_r0 - dy;
txtSgauss = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelX y_s labelW sliderH], ...
    'String', 'sGAUSS (spread)', ...
    'BackgroundColor', get(hFig, 'Color'), ...
    'ForegroundColor', [0.47 0.67 0.19], ...  % <-- make green
    'HorizontalAlignment', 'left', 'FontSize', 9);
s_min = 0; s_max = 5;
sldSgauss = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderX y_s sliderW sliderH], 'Min', s_min, 'Max', s_max, 'Value', 0.0, ...
    'SliderStep', [0.01/(s_max - s_min) 0.1], 'Callback', @(src, ~) sliderChanged(src, hFig));
lblSgauss = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueX y_s valueW sliderH], ...
    'String', sprintf('%.2f', get(sldSgauss, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), ...
    'ForegroundColor', colK, ...   % <-- MAKE IT GREEN HERE
    'HorizontalAlignment', 'left', 'FontSize', 9);

% 5) sGAUSS (spread) - black RIGHT
y_s = y_r0 - dy;
txtSgaussR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colLabelXR y_s labelW sliderH], ...
    'String', 'sGAUSS (spread)', ...
    'BackgroundColor', get(hFig, 'Color'), ...
    'ForegroundColor', [0.47 0.67 0.19], ...  % <-- make green
    'HorizontalAlignment', 'left', 'FontSize', 9);
s_min = 0; s_max = 5;
sldSgaussR = uicontrol('Style', 'slider', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colSliderXR y_s sliderW sliderH], 'Min', s_min, 'Max', s_max, 'Value', 0.0, ...
    'SliderStep', [0.01/(s_max - s_min) 0.1], 'Callback', @(src, ~) sliderChangedR(src, hFig));
lblSgaussR = uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [colValueXR y_s valueW sliderH], ...
    'String', sprintf('%.2f', get(sldSgaussR, 'Value')), ...
    'BackgroundColor', get(hFig, 'Color'), ...
    'ForegroundColor', colK, ...   % <-- MAKE IT GREEN HERE
    'HorizontalAlignment', 'left', 'FontSize', 9);

%% Clear setting dropdown
clearDDX_lbl = 0.41;
clearDDW_lbl = 0.03;
clearDDX = clearDDX_lbl+clearDDW_lbl;
clearDDW = 0.05;

uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [clearDDX_lbl 0.035 clearDDW_lbl 0.03], 'String', 'Clear:', ...
    'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', 'k', ...
    'HorizontalAlignment', 'left', 'FontSize', 9);
% popup values: change strings to suit what you need
popClear = uicontrol('Style', 'popupmenu', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [clearDDX 0.035 clearDDW 0.03], 'String', {'no-clear','clear','clear-always'}, ...
    'Value', 1, 'Callback', @(src,~) clearChanged(src, hFig));

%% Mode dropdown
uicontrol('Style', 'text', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [clearDDX_lbl 0.005 clearDDW_lbl 0.03], 'String', 'Mode:', 'BackgroundColor', get(hFig, 'Color'), 'ForegroundColor', 'k', ...
    'HorizontalAlignment', 'left', 'FontSize', 9);
popMode = uicontrol('Style', 'popupmenu', 'Parent', hFig, 'Units', 'normalized', ...
    'Position', [clearDDX 0.005 clearDDW 0.03], 'String', {'half', 'full'}, 'Value', 2, 'Callback', @(src, ~) modeChanged(src, hFig));

% --- Minimal Video-FPS selector (only updates setappdata 'FPS')
uicontrol('Style','text','Parent',hFig,'Units','normalized', ...
    'Position',[clearDDX_lbl 0.065 clearDDW_lbl 0.03], 'String','vFPS:', ...
    'BackgroundColor', get(hFig,'Color'), 'ForegroundColor','k','HorizontalAlignment','left','FontSize',9);

fpsList = [1 5 10 20 30];            % numeric mapping for popup entries
fpsLabels = {'1fps','5fps','10fps','20fps','30fps'};
defaultIdx = 4;                      % default = 20 fps (matches your fpsVideo = 20)

popFpsVideo = uicontrol('Style','popupmenu','Parent',hFig,'Units','normalized', ...
    'Position',[clearDDX 0.065 clearDDW 0.03], 'String', fpsLabels, ...
    'Value', defaultIdx, 'Callback', @(src,~) fpsSelectorCallback(src, hFig));

%some sizes and boxes for screen specific buttons and options
leftScreenOptionsX = 0.4;
rightScreenOptionsX = 0.85;
ScreenOptionsY = 0.36;
lsoLabelW = 0.05;
lsoH = 0.02;
lsoControllerW = 0.03;

% --- Left / Right screen on-off toggles
uicontrol('Style','text','Parent',hFig,'Units','normalized', ...
    'Position',[leftScreenOptionsX ScreenOptionsY lsoLabelW lsoH], 'String','Left:', ...
    'BackgroundColor',get(hFig,'Color'),'ForegroundColor','k','HorizontalAlignment','left','FontSize',9);
toggleLeft = uicontrol('Style','togglebutton','Parent',hFig,'Units','normalized', ...
    'Position',[leftScreenOptionsX+lsoLabelW ScreenOptionsY lsoControllerW lsoH], 'String','On', 'Value', 1, ...
    'Callback', @(src,~) toggleLeftCallback(src, hFig));

uicontrol('Style','text','Parent',hFig,'Units','normalized', ...
    'Position',[rightScreenOptionsX ScreenOptionsY lsoLabelW lsoH], 'String','Right:', ...
    'BackgroundColor',get(hFig,'Color'),'ForegroundColor','k','HorizontalAlignment','left','FontSize',9);
toggleRight = uicontrol('Style','togglebutton','Parent',hFig,'Units','normalized', ...
    'Position',[rightScreenOptionsX+lsoLabelW ScreenOptionsY lsoControllerW lsoH], 'String','On', 'Value', 1, ...
    'Callback', @(src,~) toggleRightCallback(src, hFig));

% store handles (optional)
setappdata(hFig, 'toggleLeft', toggleLeft);
setappdata(hFig, 'toggleRight', toggleRight);

%=================== ADD SET event toggle dropdown ================
%% --- Dropdowns under ON/OFF toggles ---

% Vertical offset (space below toggle)
dropdownOffsetY = 0.025;  
dropdownH = 0.02;
dropdownW = lsoControllerW + 0.02;  % slightly wider than the button

% --- Left dropdown ---
uicontrol('Style','text','Parent',hFig,'Units','normalized', ...
    'Position',[leftScreenOptionsX ScreenOptionsY - dropdownOffsetY lsoLabelW lsoH], ...
    'String','Event Type:', 'BackgroundColor',get(hFig,'Color'), ...
    'ForegroundColor','k','HorizontalAlignment','left','FontSize',9);

popupLeftMode = uicontrol('Style','popupmenu','Parent',hFig,'Units','normalized', ...
    'Position',[leftScreenOptionsX+lsoLabelW ScreenOptionsY - dropdownOffsetY dropdownW dropdownH], ...
    'String',{'set','add'}, ...
    'Value',1, ...
    'Callback',@(src,~) leftDropdownChanged(src,hFig));

% --- Right dropdown ---
uicontrol('Style','text','Parent',hFig,'Units','normalized', ...
    'Position',[rightScreenOptionsX ScreenOptionsY - dropdownOffsetY lsoLabelW lsoH], ...
    'String','Event Type:', 'BackgroundColor',get(hFig,'Color'), ...
    'ForegroundColor','k','HorizontalAlignment','left','FontSize',9);

popupRightMode = uicontrol('Style','popupmenu','Parent',hFig,'Units','normalized', ...
    'Position',[rightScreenOptionsX+lsoLabelW ScreenOptionsY - dropdownOffsetY dropdownW dropdownH], ...
    'String',{'set','add'}, ...
    'Value',1, ...
    'Callback',@(src,~) rightDropdownChanged(src,hFig));

% Store handles if needed later
setappdata(hFig, 'popupLeftMode', popupLeftMode);
setappdata(hFig, 'popupRightMode', popupRightMode);

%% ================= Small Interactive Gaussian  =================

maxInteractiveY = 5;
rClip = 30;   % covers sqrt(2)*20 ≈ 28.3


smallGaussianY = 0.205;
smallGaussianX = 0.07;
smallGaussianWidth = 0.3;
smallGaussianHeight = 0.18;
smallGaussianXR = 0.53;



hAxGauss = axes('Parent',hFig,'Units','normalized','Position',[smallGaussianX smallGaussianY smallGaussianWidth smallGaussianHeight],'Color','k');

hAxGaussR = axes('Parent',hFig,'Units','normalized','Position',[smallGaussianXR smallGaussianY smallGaussianWidth smallGaussianHeight],'Color','k');




% %Axis warping
% ymin = 0;
% ymax = 5;
% warpFcn = @(y) y.^0.5;
% yticks_original = 0:0.5:5;                     
% yticks_warped = warpFcn(yticks_original) / warpFcn(ymax) * ymax;
% set(hAxGauss, 'YTick', yticks_warped, 'YTickLabel', string(yticks_original));
% set(hAxGaussR, 'YTick', yticks_warped, 'YTickLabel', string(yticks_original));



r = linspace(0,rClip,500);
rR = linspace(0,rClip,500);

% Initial parameter values
init_g = get(sldGgauss,'Value');
init_h = get(sldHgauss,'Value');
init_k = get(sldKgauss,'Value');
init_r0 = get(sldR0,'Value');
init_s = get(sldSgauss,'Value');

%Initial parameter values right
init_gR = get(sldGgaussR,'Value');
init_hR = get(sldHgaussR,'Value');
init_kR = get(sldKgaussR,'Value');
init_r0R = get(sldR0R,'Value');
init_sR = get(sldSgaussR,'Value');

% Individual parts
y_g_part = maxInteractiveY ./ (1 + exp(-init_g));
y_h_part = maxInteractiveY ./ (1 + exp(-init_h .* r));
y_k_part = maxInteractiveY ./ (1 + exp(-init_k .* exp(-((r - init_r0).^2)./(2*init_s.^2))));
y_total  = maxInteractiveY ./ (1 + exp(-(init_g + init_h .* r + init_k .* exp(-((r - init_r0).^2)./(2*init_s.^2)))));

% Individual parts right
y_g_partR = maxInteractiveY ./ (1 + exp(-init_gR));
y_h_partR = maxInteractiveY ./ (1 + exp(-init_hR .* rR));
y_k_partR = maxInteractiveY ./ (1 + exp(-init_kR .* exp(-((rR - init_r0R).^2)./(2*init_sR.^2))));
y_totalR  = maxInteractiveY ./ (1 + exp(-(init_gR + init_hR .* rR + init_kR .* exp(-((rR - init_r0R).^2)./(2*init_sR.^2)))));

% Plot parts
hLineGPart = plot(hAxGauss,r, y_g_part*ones(size(r)), 'Color',[0.85 0.33 0.1],'LineWidth',1); hold(hAxGauss,'on'); % orange
hLineHPart = plot(hAxGauss,r, y_h_part, 'Color',[0 0.45 0.74],'LineWidth',1); % blue
hLineKPart = plot(hAxGauss,r, y_k_part, 'Color',[0.47 0.67 0.19],'LineWidth',1); % green

% % Plot parts right
hLineGPartR = plot(hAxGaussR,rR, y_g_partR*ones(size(rR)), 'Color',[0.85 0.33 0.1],'LineWidth',1); hold(hAxGaussR,'on'); % orange
hLineHPartR = plot(hAxGaussR,rR, y_h_partR, 'Color',[0 0.45 0.74],'LineWidth',1); % blue
hLineKPartR = plot(hAxGaussR,rR, y_k_partR, 'Color',[0.47 0.67 0.19],'LineWidth',1); % green

% Plot total (white)
hLineTotal = plot(hAxGauss,r, y_total, 'w','LineWidth',2); % white line

% % Plot total (white) right
hLineTotalR = plot(hAxGaussR,rR, y_totalR, 'w','LineWidth',2); % white line

% --- ADD ORANGE MARKERS ON TOTAL LINE (initial) - generate according to kEROS slider
init_radius = round(get(sldRadius, 'Value'));   % current kEROS (left)
rMarkers = [];
for n = 1:init_radius
    for k = 0:n
        rMarkers(end+1) = sqrt(double(n.^2 + k.^2)); %#ok<AGROW>
    end
end
rMarkers = unique(rMarkers);
% clip to domain of r vector (r was defined earlier)
rMarkers = rMarkers(rMarkers <= rClip);

% compute initial Y-values using the init_* parameters you already have
if isempty(rMarkers)
    y_markers = [];
else
    y_markers = maxInteractiveY ./ (1 + exp(-(init_g + init_h .* rMarkers ...
                   + init_k .* exp(-((rMarkers - init_r0).^2) ./ (2 * init_s.^2)))));
end

% right-hand side initial Y-values (use right radius slider)
init_radiusR = round(get(sldRadiusR, 'Value'));   % current kEROS (right)
rMarkersR = [];
for n = 1:init_radiusR
    for k = 0:n
        rMarkersR(end+1) = sqrt(double(n.^2 + k.^2)); %#ok<AGROW>
    end
end
rMarkersR = unique(rMarkersR);
rMarkersR = rMarkersR(rMarkersR <= rClip);

if isempty(rMarkersR)
    y_markersR = [];
else
    y_markersR = maxInteractiveY ./ (1 + exp(-(init_gR + init_hR .* rMarkersR ...
                    + init_kR .* exp(-((rMarkersR - init_r0R).^2) ./ (2 * init_sR.^2)))));
end

hMarkers = plot(hAxGauss, rMarkers, y_markers, 'o', ...
    'MarkerFaceColor', [1 0.5 0], 'MarkerEdgeColor', 'k', 'MarkerSize', 6);

hMarkersR = plot(hAxGaussR, rMarkersR, y_markersR, 'o', ...
    'MarkerFaceColor', [1 0.5 0], 'MarkerEdgeColor', 'k', 'MarkerSize', 6);

% store for updates
setappdata(hFig, 'rMarkers', rMarkers);
setappdata(hFig, 'hMarkers', hMarkers);
setappdata(hFig, 'hMarkersR', hMarkersR);

grid(hAxGauss,'on');                   % turn grid on
xlabel(hAxGauss,'r','Color','k');      % x-axis label black
ylabel(hAxGauss,'d(r)','Color','k');   % y-axis label black
title(hAxGauss, 'Interactive Gaussian (sigmoid)', 'Color', [0 0 0]); % title black
set(hAxGauss, 'XColor', 'k', 'YColor', 'k', 'GridColor', [1 1 1], 'GridAlpha', 0.3);

grid(hAxGaussR,'on');                   % turn grid on
xlabel(hAxGaussR,'r','Color','k');      % x-axis label black
ylabel(hAxGaussR,'d(r)','Color','k');   % y-axis label black
title(hAxGaussR, 'Interactive Gaussian (sigmoid)', 'Color', [0 0 0]); % title black
set(hAxGaussR, 'XColor', 'k', 'YColor', 'k', 'GridColor', [1 1 1], 'GridAlpha', 0.3);

% -------------------- Event lines representing y = m + k * x --------------------
% CREATE event lines representing y = m + k * x (left & right)
% (replace any previous hEventLine creation that used a vertical line)

% Get handles to sliders
sldSetEvent  = getappdata(hFig, 'sldSetEvent');   % left m
sldSetEventR = getappdata(hFig, 'sldSetEventR');  % right m
sldTilt      = getappdata(hFig, 'sldTilt');       % left k
sldTiltR     = getappdata(hFig, 'sldTiltR');      % right k
sldmEVENT  = getappdata(hFig, 'sldmEVENT');   % left m for event line / processing
sldmEVENTR = getappdata(hFig, 'sldmEVENTR');  % right m

% Read starting values
m0  = get(sldmEVENT, 'Value'); 
k0  = get(sldTilt, 'Value'); 
m0R = get(sldmEVENTR, 'Value'); 
k0R = get(sldTiltR, 'Value'); 

% Build initial line data
xvec  = linspace(0,rClip,200);         % domain same as Gaussian plot

yvec = maxInteractiveY./( 1 + exp( -( m0  + k0  .* xvec ) ) );
yvecR = maxInteractiveY./( 1 + exp( -( m0R + k0R .* xvec ) ) );

%yvec  = m0  + k0  .* xvec;
%yvecR = m0R + k0R .* xvec;

% Create lines
hEventLine  = plot(hAxGauss,  xvec, yvec,  'w', 'LineWidth', 2);
uistack(hEventLine,'top');
hEventLineR = plot(hAxGaussR, xvec, yvecR, 'w', 'LineWidth', 2);
uistack(hEventLineR,'top');

% Store for updates
setappdata(hFig, 'hEventLine',  hEventLine);
setappdata(hFig, 'hEventLineR', hEventLineR);

% --- create violet event markers (left) ---------------------------------
hEventMarkers = plot(hAxGauss, NaN, NaN, 'o', ...
    'MarkerFaceColor', violetColor, 'MarkerEdgeColor', 'k', 'MarkerSize', 6, ...
    'Visible', 'off', 'HitTest', 'off'); % start hidden
setappdata(hFig, 'hEventMarkers', hEventMarkers);

% --- create violet event markers (right) --------------------------------
hEventMarkersR = plot(hAxGaussR, NaN, NaN, 'o', ...
    'MarkerFaceColor', violetColor, 'MarkerEdgeColor', 'k', 'MarkerSize', 6, ...
    'Visible', 'off', 'HitTest', 'off');
setappdata(hFig, 'hEventMarkersR', hEventMarkersR);

% SOME LIMITS FOR THE AXISES %
%Logscales cannot be zero in matlab so if we use it, put a supersmall value
%instead!!!

smallValue = 0;

xlim(hAxGauss,[smallValue rClip]); 
ylim(hAxGauss,[smallValue 5]);
%ylim(hAxGauss,warpFcn([ymin ymax]));



xlim(hAxGaussR,[smallValue rClip]); 
ylim(hAxGaussR,[smallValue 5]);
%ylim(hAxGaussR,warpFcn([ymin ymax]));

% ================= Custom colored labels (replace legend) =================
legendX = smallGaussianX+0.2;      % normalized X position (right)
legendYStart = 0.2; % normalized Y position (bottom)
legendDY = 0.02;     % vertical spacing

% gGAUSS
annotation('textbox', [legendX, legendYStart + 4*legendDY, 0.2, 0.03], ...
    'String', 'gGAUSS', 'Color', [0.85 0.33 0.1], 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'left');

% hGAUSS*r
annotation('textbox', [legendX, legendYStart + 3*legendDY, 0.2, 0.03], ...
    'String', 'hGAUSS', 'Color', [0 0.45 0.74], 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'left');

% kGAUSS*exp
annotation('textbox', [legendX, legendYStart + 2*legendDY, 0.2, 0.03], ...
    'String', 'kGAUSS,r0,sGAUSS', 'Color', [0.47 0.67 0.19], 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'left');

% Total (white)
annotation('textbox', [legendX, legendYStart + legendDY, 0.2, 0.03], ...
    'String', 'Total', 'Color', [1 1 1], 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'left');

% ================= Custom colored labels RIGHT =================
legendXR = smallGaussianXR+0.2;      % normalized X position (right)
legendYStartR = 0.2; % normalized Y position (bottom)
legendDYR = 0.02;     % vertical spacing

% gGAUSS
annotation('textbox', [legendXR, legendYStartR + 4*legendDYR, 0.2, 0.03], ...
    'String', 'gGAUSS', 'Color', [0.85 0.33 0.1], 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'left');

% hGAUSS*r
annotation('textbox', [legendXR, legendYStartR + 3*legendDYR, 0.2, 0.03], ...
    'String', 'hGAUSS', 'Color', [0 0.45 0.74], 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'left');

% kGAUSS*exp
annotation('textbox', [legendXR, legendYStartR + 2*legendDYR, 0.2, 0.03], ...
    'String', 'kGAUSS,r0,sGAUSS', 'Color', [0.47 0.67 0.19], 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'left');

% Total (white)
annotation('textbox', [legendXR, legendYStartR + legendDYR, 0.2, 0.03], ...
    'String', 'Total', 'Color', [1 1 1], 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'left');

%% =================== Slider label colors ===================
% Change r0 and sGAUSS numeric labels to green (same as kGAUSS)
set(lblR0, 'ForegroundColor', [0.47 0.67 0.19]);
set(lblSgauss, 'ForegroundColor', [0.47 0.67 0.19]);

%% =================== Slider label colors RIGHT ===================
% Change r0 and sGAUSS numeric labels to green (same as kGAUSS)
set(lblR0R, 'ForegroundColor', [0.47 0.67 0.19]);
set(lblSgaussR, 'ForegroundColor', [0.47 0.67 0.19]);

%video fps, not same as frames per second of accumulated events.
fpsVideo = 20;

%% =================== Store App Data ===================
setappdata(hFig, 'Frames', frames);
setappdata(hFig, 'Nframes', Nframes);
setappdata(hFig, 'FrameIdx', 1);
setappdata(hFig, 'hIm', hIm);
setappdata(hFig, 'hSlider', hSlider);
setappdata(hFig, 'hTxt', hTxt);
setappdata(hFig, 'FPS', fpsVideo);
setappdata(hFig, 'sldRadius', sldRadius);
setappdata(hFig, 'lblRadius', lblRadius);
setappdata(hFig, 'radiusDiscreteValues', radiusDiscreteValues);
setappdata(hFig, 'sldHgauss', sldHgauss);
setappdata(hFig, 'lblHgauss', lblHgauss);
setappdata(hFig, 'sldGgauss', sldGgauss);
setappdata(hFig, 'lblGgauss', lblGgauss);
setappdata(hFig, 'sldSgauss', sldSgauss);
setappdata(hFig, 'lblSgauss', lblSgauss);
setappdata(hFig, 'sldR0', sldR0);
setappdata(hFig, 'lblR0', lblR0);
setappdata(hFig, 'sldKgauss', sldKgauss);
setappdata(hFig, 'lblKgauss', lblKgauss);
setappdata(hFig, 'popMode', popMode);
setappdata(hFig, 'ScreenSize', 'full');
setappdata(hFig, 'hAxGauss', hAxGauss);
% store line handles & r vector
setappdata(hFig, 'hLineGPart', hLineGPart);
setappdata(hFig, 'hLineHPart', hLineHPart);
setappdata(hFig, 'hLineKPart', hLineKPart);
setappdata(hFig, 'hLineTotal', hLineTotal);
setappdata(hFig, 'rGauss', r);
% clear dropdown.
setappdata(hFig, 'popClear', popClear);
setappdata(hFig, 'ClearOption', 'no-clear');   % default matches the popup initial Value=1

%% =================== Store App Data =================== RIGHT
setappdata(hFig, 'hImRight', hImRight);
setappdata(hFig, 'sldRadiusR', sldRadiusR);
setappdata(hFig, 'lblRadiusR', lblRadiusR);
setappdata(hFig, 'sldHgaussR', sldHgaussR);
setappdata(hFig, 'lblHgaussR', lblHgaussR);
setappdata(hFig, 'sldGgaussR', sldGgaussR);
setappdata(hFig, 'lblGgaussR', lblGgaussR);
setappdata(hFig, 'sldSgaussR', sldSgaussR);
setappdata(hFig, 'lblSgaussR', lblSgaussR);
setappdata(hFig, 'sldR0R', sldR0R);
setappdata(hFig, 'lblR0R', lblR0R);
setappdata(hFig, 'sldKgaussR', sldKgaussR);
setappdata(hFig, 'lblKgaussR', lblKgaussR);
setappdata(hFig, 'hAxGaussR', hAxGaussR);
% store line handles & r vector
setappdata(hFig, 'hLineGPartR', hLineGPartR);
setappdata(hFig, 'hLineHPartR', hLineHPartR);
setappdata(hFig, 'hLineKPartR', hLineKPartR);
setappdata(hFig, 'hLineTotalR', hLineTotalR);
setappdata(hFig, 'rGaussR', rR);
% setEvent sliders + labels
setappdata(hFig, 'sldSetEvent', sldSetEvent);
setappdata(hFig, 'lblSetEvent', lblSetEvent);
setappdata(hFig, 'sldSetEventR', sldSetEventR);
setappdata(hFig, 'lblSetEventR', lblSetEventR);

% Initialization
setappdata(hFig, 'erosClearToggle', 0);

% initialization: screens enabled by default
setappdata(hFig, 'LeftEnabled', true);
setappdata(hFig, 'RightEnabled', true);


% --- create white dot markers showing setEvent (initial)
xPos = 0;   % fixed x position on the vertical axis

init_set = get(sldSetEvent, 'Value');  % value is already in [0,2]
hSetEventDot = plot(hAxGauss, xPos, init_set, 'o', ...
    'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k', 'MarkerSize', 6);

init_setR = get(sldSetEventR, 'Value');
hSetEventDotR = plot(hAxGaussR, xPos, init_setR, 'o', ...
    'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k', 'MarkerSize', 6);

% store dot handles
setappdata(hFig, 'hSetEventDot', hSetEventDot);
setappdata(hFig, 'hSetEventDotR', hSetEventDotR);

%% =================== Timer ===================
period = 1 / max(1, fpsVideo);
t = timer('ExecutionMode', 'fixedRate', 'Period', period, 'BusyMode', 'drop', ...
    'TimerFcn', @(~, ~) onTimerTick(hFig));
setappdata(hFig, 'ViewerTimer', t);
set(hFig, 'CloseRequestFcn', @(src, evt) onClose(hFig));

%======RECORD BUTTON==========
hRecordBtn = uicontrol('Parent',hFig,...
    'Style','pushbutton',...
    'String','Record',...
    'Units','normalized',...
    'Position',[0.015 0.32 0.04 0.05],...
    'FontWeight','bold',...
    'Callback',@recordCallback);
setappdata(hFig, 'RecordButton', hRecordBtn);
setappdata(hFig,'isPlaying',false);



% % === EXTRA ERROR GRAPH ===
% errorVectorSize = Nframes;
% 
% maeValuesLeft = zeros(1,errorVectorSize);
% maeValuesRight = zeros(1,errorVectorSize);
% 
% maeFig = figure('Name','MAE per Frame', ...
%                 'Position',[950 300 500 400]);
% maeAx = axes('Parent', maeFig);
% xlabel(maeAx,'Frame Number')
% ylabel(maeAx,'MAE')
% title(maeAx,'MAE vs Frame')
% grid(maeAx,'on')
% 
% maeLineLeft = plot(maeAx, NaN, NaN,'c', 'LineWidth', 2);
% hold(maeAx,'on')
% maeLineRight = plot(maeAx, NaN, NaN,'r', 'LineWidth', 2);
% legend(maeAx, {'MAE Left', 'MAE Right'})
% 
% xlim(maeAx, [1 errorVectorSize])
% 
% % === extra moving average of error ===
% maeValuesLeft_MA = zeros(1,errorVectorSize);
% maeValuesRight_MA = zeros(1,errorVectorSize);
% 
% maeMovFig = figure('Name','Moving Average MAE per Frame', ...
%                    'Position',[1500 300 500 400]);
% maeMovAx = axes('Parent', maeMovFig);
% xlabel(maeMovAx,'Frame Number')
% ylabel(maeMovAx,'MAE (Moving Average)')
% title(maeMovAx,'Moving Average MAE vs Frame')
% grid(maeMovAx,'on')
% 
% maeMovLineLeft  = plot(maeMovAx, NaN, NaN,  'c', 'LineWidth', 2);
% hold(maeMovAx,'on')
% maeMovLineRight = plot(maeMovAx, NaN, NaN, 'r', 'LineWidth', 2);
% legend(maeMovAx, {'MAE Left (MA)', 'MAE Right (MA)'})
% 
% xlim(maeMovAx, [1 errorVectorSize])
% 
% % === EXTRA MOVING AVERAGE F1 SCORE GRAPH ===
% f1VectorSize = Nframes;
% 
% % Raw F1 values per frame
% f1ValuesLeft  = zeros(1, f1VectorSize);
% f1ValuesRight = zeros(1, f1VectorSize);
% 
% % Moving-average F1 values
% f1ValuesLeft_MA  = zeros(1, f1VectorSize);
% f1ValuesRight_MA = zeros(1, f1VectorSize);
% 
% % Figure and axes
% f1MovFig = figure('Name','Moving Average F1 Score per Frame', ...
%                   'Position',[1600 300 500 400]);
% f1MovAx = axes('Parent', f1MovFig);
% 
% xlabel(f1MovAx,'Frame Number')
% ylabel(f1MovAx,'F1 Score (Moving Average)')
% title(f1MovAx,'Moving Average F1 Score vs Frame')
% grid(f1MovAx,'on')
% ylim(f1MovAx,[0 1])
% 
% % Plot handles (initialized empty)
% f1MovLineLeft  = plot(f1MovAx, NaN, NaN, 'c', 'LineWidth', 2);
% hold(f1MovAx,'on')
% f1MovLineRight = plot(f1MovAx, NaN, NaN, 'r', 'LineWidth', 2);
% 
% legend(f1MovAx, {'F1 Left (MA)', 'F1 Right (MA)'})
% xlim(f1MovAx, [1 f1VectorSize])
% 
% % === EXTRA CUMULATIVE AVERAGE MAE (ignoring TN) GRAPH ===
% maeNoTNVectorSize = Nframes;
% 
% % Raw MAE_no_TN values per frame
% maeNoTNValuesLeft  = zeros(1, maeNoTNVectorSize);
% maeNoTNValuesRight = zeros(1, maeNoTNVectorSize);
% 
% % Cumulative-average MAE_no_TN values
% maeNoTNValuesLeft_MA  = zeros(1, maeNoTNVectorSize);
% maeNoTNValuesRight_MA = zeros(1, maeNoTNVectorSize);
% 
% % Figure and axes
% maeNoTNFig = figure('Name','Cumulative Average MAE (No TN) per Frame', ...
%                     'Position',[1700 300 500 400]);
% maeNoTNAx = axes('Parent', maeNoTNFig);
% 
% xlabel(maeNoTNAx,'Frame Number')
% ylabel(maeNoTNAx,'MAE (No TN, Cumulative Average)')
% title(maeNoTNAx,'Cumulative Average MAE (No TN) vs Frame')
% grid(maeNoTNAx,'on')
% 
% % Since MAE is unbounded but usually small, you can leave auto Y-limits
% % or set a reasonable one if you like, e.g., ylim(maeNoTNAx,[0 1])
% 
% % Plot handles (initialized empty)
% maeNoTNLineLeft  = plot(maeNoTNAx, NaN, NaN, 'c', 'LineWidth', 2);
% hold(maeNoTNAx,'on')
% maeNoTNLineRight = plot(maeNoTNAx, NaN, NaN, 'r', 'LineWidth', 2);
% 
% legend(maeNoTNAx, {'MAE Left (No TN, CA)', 'MAE Right (No TN, CA)'})
% xlim(maeNoTNAx, [1 maeNoTNVectorSize])


% Set vector sizes for all metrics
errorVectorSize   = Nframes;
f1VectorSize      = Nframes;
maeNoTNVectorSize = Nframes;


% === COMBINED 2x2 FIGURE FOR ALL METRICS ===
combinedFig = figure('Name','All Metrics Overview', ...
                     'Position',[900 200 1200 800]);  % Bigger figure to fit 4 subplots

% === 1) MAE per Frame ===
maeValuesLeft  = zeros(1,errorVectorSize);
maeValuesRight = zeros(1,errorVectorSize);

subplot(2,2,1)
maeAx = gca;
maeLineLeft  = plot(maeAx, NaN, NaN, 'c', 'LineWidth', 2);
hold(maeAx,'on')
maeLineRight = plot(maeAx, NaN, NaN, 'r', 'LineWidth', 2);
xlabel(maeAx,'Frame Number')
ylabel(maeAx,'MAE')
title(maeAx,'MAE vs Frame')
grid(maeAx,'on')
legend(maeAx, {'MAE Left', 'MAE Right'})
xlim(maeAx, [1 errorVectorSize])

% === 2) Moving Average MAE ===
maeValuesLeft_MA  = zeros(1,errorVectorSize);
maeValuesRight_MA = zeros(1,errorVectorSize);

subplot(2,2,2)
maeMovAx = gca;
maeMovLineLeft  = plot(maeMovAx, NaN, NaN, 'c', 'LineWidth', 2);
hold(maeMovAx,'on')
maeMovLineRight = plot(maeMovAx, NaN, NaN, 'r', 'LineWidth', 2);
xlabel(maeMovAx,'Frame Number')
ylabel(maeMovAx,'Cumulative Average MAE')
title(maeMovAx,'Cumulative Average MAE vs Frame')
grid(maeMovAx,'on')
legend(maeMovAx, {'Left Cumulative Average MAE', 'Right Cumulative Average MAE'})
xlim(maeMovAx, [1 errorVectorSize])

% === 3) Moving Average F1 Score ===
f1ValuesLeft  = zeros(1,f1VectorSize);
f1ValuesRight = zeros(1,f1VectorSize);
f1ValuesLeft_MA  = zeros(1,f1VectorSize);
f1ValuesRight_MA = zeros(1,f1VectorSize);

subplot(2,2,3)
f1MovAx = gca;
f1MovLineLeft  = plot(f1MovAx, NaN, NaN, 'c', 'LineWidth', 2);
hold(f1MovAx,'on')
f1MovLineRight = plot(f1MovAx, NaN, NaN, 'r', 'LineWidth', 2);
xlabel(f1MovAx,'Frame Number')
ylabel(f1MovAx,'Cumulative Average F1 Score')
title(f1MovAx,'Cumulative Average F1 Score vs Frame')
grid(f1MovAx,'on')
ylim(f1MovAx,[0 1])
legend(f1MovAx, {'Left Cumulative Average F1 Score', 'Right Cumulative Average F1 Score'})
xlim(f1MovAx, [1 f1VectorSize])

% === 4) Cumulative Average MAE (No TN) ===
maeNoTNValuesLeft  = zeros(1,maeNoTNVectorSize);
maeNoTNValuesRight = zeros(1,maeNoTNVectorSize);
maeNoTNValuesLeft_MA  = zeros(1,maeNoTNVectorSize);
maeNoTNValuesRight_MA = zeros(1,maeNoTNVectorSize);

subplot(2,2,4)
maeNoTNAx = gca;
maeNoTNLineLeft  = plot(maeNoTNAx, NaN, NaN, 'c', 'LineWidth', 2);
hold(maeNoTNAx,'on')
maeNoTNLineRight = plot(maeNoTNAx, NaN, NaN, 'r', 'LineWidth', 2);
xlabel(maeNoTNAx,'Frame Number')
ylabel(maeNoTNAx,'Cumulative Average MAE (Excluding TN)')
title(maeNoTNAx,'Cumulative Average MAE (Excluding True Negatives) vs Frame')
grid(maeNoTNAx,'on')
legend(maeNoTNAx, {'Left Cumulative Average MAE (Excluding TN)', 'Right Cumulative Average MAE (Excluding TN)'})
xlim(maeNoTNAx, [1 maeNoTNVectorSize])





%======== 4 color overlays =========

hIm = getappdata(hFig,'hIm');
parentAx = ancestor(hIm,'axes');
parentAxRight = ancestor(hImRight,'axes');

% Constant colors
% Precompute colors
red   = cat(3, ones(H,W), zeros(H,W), zeros(H,W));
green = cat(3, zeros(H,W), ones(H,W), zeros(H,W));
blue  = cat(3, zeros(H,W), zeros(H,W), ones(H,W));
yellow = cat(3, ones(H,W), ones(H,W), zeros(H,W));
white = cat(3, ones(H,W), ones(H,W), ones(H,W));

% Base alpha
alpha0 = zeros(H,W);

hOverlay(1) = image('Parent', parentAx, 'CData', red,   'AlphaData', alpha0, 'HitTest','off');
hOverlay(2) = image('Parent', parentAx, 'CData', white, 'AlphaData', alpha0, 'HitTest','off');
hOverlay(3) = image('Parent', parentAx, 'CData', blue,  'AlphaData', alpha0, 'HitTest','off');
hOverlay(4) = image('Parent', parentAx, 'CData', green,'AlphaData', alpha0, 'HitTest','off');
hOverlay(5) = image('Parent', parentAx, 'CData', yellow,'AlphaData', alpha0, 'HitTest','off');

uistack(hOverlay,'top');
setappdata(hFig,'hOverlay',hOverlay);

hOverlayRight(1) = image('Parent', parentAxRight, 'CData', red,   'AlphaData', alpha0, 'HitTest','off');
hOverlayRight(2) = image('Parent', parentAxRight, 'CData', white, 'AlphaData', alpha0, 'HitTest','off');
hOverlayRight(3) = image('Parent', parentAxRight, 'CData', blue,  'AlphaData', alpha0, 'HitTest','off');
hOverlayRight(4) = image('Parent', parentAxRight, 'CData', green,'AlphaData', alpha0, 'HitTest','off');
hOverlayRight(5) = image('Parent', parentAxRight, 'CData', yellow,'AlphaData', alpha0, 'HitTest','off');

uistack(hOverlayRight,'top');
setappdata(hFig,'hOverlayRight',hOverlayRight);

%==========VARIABLES TO store detection masks
MAE_metrics_left = NaN;
MAE_metrics_right = NaN;

setappdata(hFig,'MAE_metrics_left', MAE_metrics_left);
setappdata(hFig,'MAE_metrics_right', MAE_metrics_right);


%========COLOR BUTTONS ==============
% --- Create button in bottom-left corner ---
btnColor = uicontrol('Parent', hFig, ...
    'Style', 'pushbutton', ...
    'String', 'Color', ...
    'Units', 'normalized', ...          % normalized positioning
    'Position', [0.01 0.01 0.03 0.04], ... % [x y width height]
    'FontSize', 8, ...
    'Callback', @(src,event) toggleOverlayColor(hFig));

btnColor2 = uicontrol('Parent', hFig, ...
    'Style', 'pushbutton', ...
    'String', 'Color', ...
    'Units', 'normalized', ...          % normalized positioning
    'Position', [0.90 0.01 0.03 0.04], ... % [x y width height]
    'FontSize', 8, ...
    'Callback', @(src,event) toggleOverlayColor2(hFig));

setappdata(hFig, 'colorOn', true);  % start with color ON
setappdata(hFig, 'colorOn2', true);  % start with color ON

%ADD DROPDOWNS FOR TOLERANCE REGIONS

%% =================== Tolerance thickness dropdowns ===================

% Positioning (aligned with Left / Right screen controls)
tolOffsetY = 0.06*4-0.03;
tolLabelW = 0.03;
tolDDW = 0.05;
tolH = 0.02;

% ---- LEFT tolerance dropdown ----
uicontrol('Style','text','Parent',hFig,'Units','normalized', ...
    'Position',[leftScreenOptionsX ScreenOptionsY - tolOffsetY tolLabelW tolH], ...
    'String','Tol (L):', ...
    'BackgroundColor',get(hFig,'Color'), ...
    'ForegroundColor','k', ...
    'HorizontalAlignment','left', ...
    'FontSize',9);

popupTolLeft = uicontrol('Style','popupmenu','Parent',hFig,'Units','normalized', ...
    'Position',[leftScreenOptionsX+tolLabelW ScreenOptionsY - tolOffsetY tolDDW tolH], ...
    'String',{'0','1','2','3'}, ...
    'Value',1, ...                     % default = 0
    'Callback',@(src,~) tolLeftChanged(src,hFig));

% Store handle + initial value
setappdata(hFig,'popupTolLeft',popupTolLeft);
setappdata(hFig,'tolLeft',0);


% ---- RIGHT tolerance dropdown ----
uicontrol('Style','text','Parent',hFig,'Units','normalized', ...
    'Position',[rightScreenOptionsX ScreenOptionsY - tolOffsetY tolLabelW tolH], ...
    'String','Tol (R):', ...
    'BackgroundColor',get(hFig,'Color'), ...
    'ForegroundColor','k', ...
    'HorizontalAlignment','left', ...
    'FontSize',9);

popupTolRight = uicontrol('Style','popupmenu','Parent',hFig,'Units','normalized', ...
    'Position',[rightScreenOptionsX+tolLabelW ScreenOptionsY - tolOffsetY tolDDW tolH], ...
    'String',{'0','1','2','3'}, ...
    'Value',1, ...                     % default = 0
    'Callback',@(src,~) tolRightChanged(src,hFig));

% Store handle + initial value
setappdata(hFig,'popupTolRight',popupTolRight);
setappdata(hFig,'tolRight',0);



%%ADD ZOOM
z = zoom(hFig);
set(z, 'Enable', 'on'); 
set(z, 'Motion', 'both');  % allow X and Y zoom




%%=========================================================================
%%=========                FUNCTIONS                          =============
%%=========================================================================

function tolLeftChanged(src, hFig)
    val = get(src,'Value') - 1;   % popup index → {0,1,2,3}
    setappdata(hFig,'tolLeft',val);

    % ---- place your update logic here ----
    % Example:
    % updateLeftImage(hFig);
    updateImage(hFig);
end


function tolRightChanged(src, hFig)
    val = get(src,'Value') - 1;   % popup index → {0,1,2,3}
    setappdata(hFig,'tolRight',val);

    % ---- place your update logic here ----
    % Example:
    % updateRightImage(hFig);
    updateImage(hFig);
end


function toggleOverlayColor(hFig)
    % Get handles and current state
    hOverlay = getappdata(hFig,'hOverlay');
    colorOn = getappdata(hFig,'colorOn');
    
    % Flip the flag
    colorOn = ~colorOn;
    setappdata(hFig, 'colorOn', colorOn);

    % Update overlays immediately
    if colorOn
        baseAlpha = 0.6;
        baseAlphaStrong = 0.9;
        MAE_metrics_left = getappdata(hFig,'MAE_metrics_left');
        [hOverlay.AlphaData] = deal( ...
            baseAlpha*MAE_metrics_left.FP_mask, ...
            baseAlpha*MAE_metrics_left.TP_mask, ...
            baseAlpha*MAE_metrics_left.TN_mask, ...
            baseAlphaStrong*MAE_metrics_left.FN_mask,...
            baseAlpha*MAE_metrics_left.P_mask);
    else
        [hOverlay.AlphaData] = deal(zeros(size(hOverlay(1).AlphaData)));
    end
end

function toggleOverlayColor2(hFig)
    % Get handles and current state
    hOverlayRight = getappdata(hFig,'hOverlayRight');
    colorOn2 = getappdata(hFig,'colorOn2');
    
    % Flip the flag
    colorOn2 = ~colorOn2;
    setappdata(hFig, 'colorOn2', colorOn2);

    % Update overlays immediately
    if colorOn2
        baseAlpha = 0.6;
        baseAlphaStrong = 0.9;
        MAE_metrics_right = getappdata(hFig,'MAE_metrics_right');
        [hOverlayRight.AlphaData] = deal( ...
            baseAlpha*MAE_metrics_right.FP_mask, ...
            baseAlpha*MAE_metrics_right.TP_mask, ...
            baseAlpha*MAE_metrics_right.TN_mask, ...
            baseAlphaStrong*MAE_metrics_right.FN_mask, ...
            baseAlpha*MAE_metrics_right.P_mask);
    else
        [hOverlayRight.AlphaData] = deal(zeros(size(hOverlayRight(1).AlphaData)));
    end
end




% function printLeftSettings(hFig)
%     % Print all LEFT-side GUI settings in the CONSOLE! not good right
%     now! can be used later maybe.
% 
%     fprintf('=== LEFT SIDE GUI SETTINGS ===\n');
% 
%     % Sliders
%     sliderNames = {'sldRadius', 'sldGgauss', 'sldHgauss', 'sldKgauss', ...
%                    'sldR0', 'sldSgauss', 'sldSetEvent', 'sldmEVENT', ...
%                    'sldkEVENT', 'sldTilt'};
% 
%     for i = 1:length(sliderNames)
%         hSlider = getappdata(hFig, sliderNames{i});
%         val = get(hSlider, 'Value');
%         fprintf('  %s = %.3f\n', sliderNames{i}, val);
%     end
% 
%     % Dropdowns
%     popupLeftMode = getappdata(hFig, 'popupLeftMode');
%     popupStr = popupLeftMode.String{popupLeftMode.Value};
%     fprintf('  Event Type = %s\n', popupStr);
% 
%     % Clear option
%     popClear = findobj(hFig, 'Style', 'popupmenu', 'String', {'no-clear','clear','clear-always'});
%     clearStr = popClear.String{popClear.Value};
%     fprintf('  ClearOption = %s\n', clearStr);
% 
%     % Left toggle
%     toggleLeft = getappdata(hFig, 'toggleLeft');
%     fprintf('  Left (on/off) = %d\n', get(toggleLeft,'Value'));
% 
%     % Mode dropdown
%     popMode = findobj(hFig, 'Style', 'popupmenu', 'String', {'half','full'});
%     modeStr = popMode.String{popMode.Value};
%     fprintf('  Mode = %s\n', modeStr);
% 
%     % FPS dropdown
%     popFpsVideo = findobj(hFig, 'Style', 'popupmenu', 'String', {'1fps','5fps','10fps','20fps','30fps'});
%     fpsVal = popFpsVideo.String{popFpsVideo.Value};
%     fprintf('  Playback FPS (not data fps!) = %s\n', fpsVal);
% 
%     % --- Graph markers (dots on left Gaussian plot) ---
%     hMarkers = getappdata(hFig, 'hMarkers');  % handle to scatter/line markers
%     if ~isempty(hMarkers)
%         xData = hMarkers.XData;
%         yData = hMarkers.YData;
%         fprintf('  Marker values (decay kernel):\n');
%         for i = 1:length(xData)
%             fprintf('    (%.15f, %.15f)\n', xData(i), yData(i));
%         end
%     else
%         fprintf('  No markers found on the left plot.\n');
%     end
% 
%     fprintf('===============================\n');
% end

function settingsStr = printLeftSettings(hFig)
% PRINTLEFTSETTINGS Collect all left-side GUI settings into a string
%   settingsStr = printLeftSettings(hFig)

    lines = {};  % cell array to store each line

    lines{end+1} = '=== LEFT SIDE GUI SETTINGS ===';

    % --- Sliders ---
    sliderNames = {'sldRadius', 'sldGgauss', 'sldHgauss', 'sldKgauss', ...
                   'sldR0', 'sldSgauss', 'sldSetEvent', 'sldmEVENT', ...
                   'sldkEVENT', 'sldTilt'};
    for i = 1:length(sliderNames)
        hSlider = getappdata(hFig, sliderNames{i});
        val = get(hSlider, 'Value');
        lines{end+1} = sprintf('  %s = %.3f', sliderNames{i}, val);
    end

    % --- Dropdowns ---
    popupLeftMode = getappdata(hFig, 'popupLeftMode');
    popupStr = popupLeftMode.String{popupLeftMode.Value};
    lines{end+1} = sprintf('  Event Type = %s', popupStr);

    % Clear option
    popClear = findobj(hFig, 'Style', 'popupmenu', 'String', {'no-clear','clear','clear-always'});
    clearStr = popClear.String{popClear.Value};
    lines{end+1} = sprintf('  ClearOption (not affecting folder output) = %s', clearStr);

    % Left toggle
    toggleLeft = getappdata(hFig, 'toggleLeft');
    lines{end+1} = sprintf('  Left (on/off) = %d', get(toggleLeft,'Value'));

    % Mode dropdown
    popMode = findobj(hFig, 'Style', 'popupmenu', 'String', {'half','full'});
    modeStr = popMode.String{popMode.Value};
    lines{end+1} = sprintf('  Mode = %s', modeStr);

    % FPS dropdown
    popFpsVideo = findobj(hFig, 'Style', 'popupmenu', 'String', {'1fps','5fps','10fps','20fps','30fps'});
    fpsVal = popFpsVideo.String{popFpsVideo.Value};
    lines{end+1} = sprintf('  Playback FPS (not data fps!) = %s', fpsVal);

    % --- Tolerance level (pixels) ---
    tolLeftVal = getappdata(hFig, 'tolLeft');  % stored value in appdata
    lines{end+1} = sprintf('  Left Tolerance (pixels) = %d', tolLeftVal);

    % --- Graph markers ---
    hMarkers = getappdata(hFig, 'hMarkers');  % handle to scatter/line markers
    if ~isempty(hMarkers)
        xData = hMarkers.XData;
        yData = hMarkers.YData;
        lines{end+1} = '  Marker values (decay kernel):';
        for i = 1:length(xData)
            lines{end+1} = sprintf('    (%.15f, %.15f)', xData(i), yData(i));
        end
    else
        lines{end+1} = '  No markers found on the left plot.';
    end

    lines{end+1} = '===============================';

    % Combine all lines into a single string with newline characters
    settingsStr = strjoin(lines, '\n');
end



function recordCallback(~,~)
    if getappdata(hFig, 'isPlaying')
        errordlg('Pause playback before recording.', 'Recording disabled');
        return;
    end

    % --- Print slider values ---
    settingsString = printLeftSettings(hFig);

    % --- Create output directory automatically ---
    recordingsDir = fullfile(pwd, '10.1 GUI recordings');  % base recordings folder
    if ~exist(recordingsDir, 'dir')
        mkdir(recordingsDir);
    end

    % Folder named with current date and time
    timestamp = char(datetime('now','Format','yyyy-MM-dd_HH-mm-ss')); % convert to char for folder name
    outDir = fullfile(recordingsDir, timestamp);
    mkdir(outDir);

    % --- EROS folder for frames ---
    erosDir = fullfile(outDir, 'EROS');
    mkdir(erosDir);

    % --- Save GUI settings text file ---
    settingsFile = fullfile(outDir, 'GUIsettings.txt');
    fid = fopen(settingsFile, 'w');
    if fid ~= -1
        fprintf(fid, '%s', settingsString);
        fclose(fid);
    else
        warning('Could not write GUI settings to file: %s', settingsFile);
    end

    N = getappdata(hFig,'Nframes');

    %Vectors for error calculations on all the EROS output compared to the
    %groundtruths:
    tp_per_frame = NaN(N,1);
    tn_per_frame = NaN(N,1);
    fp_per_frame = NaN(N,1);
    fn_per_frame = NaN(N,1);
    
    tp_MAE_per_frame = NaN(N,1);
    tn_MAE_per_frame = NaN(N,1);
    fp_MAE_per_frame = NaN(N,1);
    fn_MAE_per_frame = NaN(N,1);

    tot_MAE_per_frame = NaN(N,1);
    tot_MAE_per_frame_no_tn = NaN(N,1);

    % --- Initialize previous frame to black ---
    prevFrameL = blackFrame;
    tolRec = getappdata(hFig,'tolLeft');
    for idx = 1:N
        frameL = computeErosFrameLeft(hFig, idx,prevFrameL);

        shiftedIDX = idx + cannyReconstructStartFrame-1;
        cannyPath = getCannyImagePath(shiftedIDX);
        cannyTruthRaw = imread(cannyPath);
        cannyTruthDouble = im2double(cannyTruthRaw);

        MAE_metrics_recorded  = computeMAE_paddedCanny(cannyTruthDouble, frameL,tolRec);

        tp_per_frame(idx) = MAE_metrics_recorded.TP_percent;
        tn_per_frame(idx) = MAE_metrics_recorded.TN_percent;
        fp_per_frame(idx) = MAE_metrics_recorded.FP_percent;
        fn_per_frame(idx) = MAE_metrics_recorded.FN_percent;
        
        tp_MAE_per_frame(idx) = MAE_metrics_recorded.MAE_TP;
        tn_MAE_per_frame(idx) = MAE_metrics_recorded.MAE_TN;
        fp_MAE_per_frame(idx) = MAE_metrics_recorded.MAE_FP;
        fn_MAE_per_frame(idx) = MAE_metrics_recorded.MAE_FN;
        
        tot_MAE_per_frame(idx) = MAE_metrics_recorded.MAE_ALL;
        tot_MAE_per_frame_no_tn(idx) = MAE_metrics_recorded.MAE_no_TN;


        % Save frame as PNG in EROS folder
        imwrite(mat2gray(frameL), fullfile(erosDir, sprintf('L_%05d.png', idx)));

        % --- Create colored overlay frame ---
        coloredFrame = createColorOverlay(frameL, cannyTruthDouble, tolRec);
    
        % Save colored frame in a subfolder "EROS_color"
        erosColorDir = fullfile(outDir, 'EROS_color');
        if ~exist(erosColorDir, 'dir')
            mkdir(erosColorDir);
        end
        imwrite(coloredFrame, fullfile(erosColorDir, sprintf('L_color_%05d.png', idx)));

        % --- Create 2-color intensity representation of events for this frame ---
        rgbFrame = processFrame2ColorEventsPerIdx(idx, ePerFrameList, ePerFrameCumsum, ...
            x_data, y_data, pol_data, retinaRes);
        
        % Save RGB event frame in its own subfolder "EROS_events_color"
        eventsColorDir = fullfile(outDir, 'Events_color');
        if ~exist(eventsColorDir, 'dir')
            mkdir(eventsColorDir);
        end
        imwrite(rgbFrame, fullfile(eventsColorDir, sprintf('L_events_color_%05d.png', idx)));

        

        % Update prevFrameL for next iteration
        prevFrameL = frameL;

        % --- Progress update ---
        fprintf('\rFrame %d of %d completed', idx, N);
        %drawnow;  % <-- force console refresh
    end
    fprintf('\n');

    %put result vectors in a struct for saving later:
    resultVectors = struct();
    resultVectors.tp_percent = tp_per_frame;
    resultVectors.tn_percent = tn_per_frame;
    resultVectors.fp_percent = fp_per_frame;
    resultVectors.fn_percent = fn_per_frame;
    resultVectors.MAE_tp = tp_MAE_per_frame;
    resultVectors.MAE_tn = tn_MAE_per_frame;
    resultVectors.MAE_fp = fp_MAE_per_frame;
    resultVectors.MAE_fn = fn_MAE_per_frame;
    resultVectors.MAE_total = tot_MAE_per_frame;
    resultVectors.MAE_total_no_tn = tot_MAE_per_frame_no_tn;

    %use the vectors an calculate total errors,mean,standard devations
    complete_output_evaluation = compute_experiment_evaluation(tp_per_frame,...
                                                               tn_per_frame,...
                                                               fp_per_frame,...
                                                               fn_per_frame,...
                                                               tp_MAE_per_frame,...
                                                               tn_MAE_per_frame,...
                                                               fp_MAE_per_frame,...
                                                               fn_MAE_per_frame,...
                                                               tot_MAE_per_frame,...
                                                               tot_MAE_per_frame_no_tn);

    data_extra_info = struct();
    data_extra_info.frameCount = N;
    data_extra_info.eventCount = numel(x_data);
    data_extra_info.timePerFrameUs = usPerFrame;
    data_extra_info.totalTimeUs = N*usPerFrame;
    data_extra_info.retinalWidth = retinaRes(2);
    data_extra_info.retinalHeight = retinaRes(1);

    % After computing complete_output_evaluation
    csvFile = save_evaluation_to_excel(complete_output_evaluation,data_extra_info,resultVectors, outDir);


    % --- Done ---
    msgbox(sprintf([ ...
        'Recording complete!\n' ...
        'Frames saved to:\n%s\n\n' ...
        'GUI settings saved to:\n%s\n\n' ...
        'Evaluation metrics saved to:\n%s'], ...
        erosDir, settingsFile, csvFile), 'Done');

end

function frameL = computeErosFrameLeft(figHandle, idx,prevFrameL)
    %--- prev frame handling ---
    clearOption = getappdata(figHandle,'ClearOption');
    erosClearToggle = getappdata(figHandle,'erosClearToggle');

    if idx == 1 || strcmp(clearOption,'clear-always') || ...
       (erosClearToggle == 1 && strcmp(clearOption,'clear'))
        prevFrameUse = blackFrame;
        setappdata(figHandle,'erosClearToggle',0);
    else
        %this is only used in GUI where all frames are stored.
        %prevFrameL = squeeze(erosFramesProcessed(idx-1,:,:));
        prevFrameUse = prevFrameL;
    end

    %--- left slider values ---
    radius = round(get(sldRadius,'Value'));
    g = get(sldGgauss,'Value');
    h = get(sldHgauss,'Value');
    kg = get(sldKgauss,'Value');
    r0 = get(sldR0,'Value');
    s = get(sldSgauss,'Value');
    
    %--- left setEvent sliders ---
    setEventVal = get(sldSetEvent,'Value');
    kEVENT = round(get(sldkEVENT,'Value'));
    setEventTilt = get(sldTilt,'Value');
    mEVENT = get(sldmEVENT,'Value');

    %--- event type from popup ---
    popupLeftMode = getappdata(figHandle,'popupLeftMode');
    eventTypeLeft = popupLeftMode.String{popupLeftMode.Value};

    %--- compute frame ---
    %method = 'SET_ADD_MULT_KERNEL_max_5_mex';  % same as updateImage
    method = NaN;
    switch mySystem
        case 'windows'
            method = 'SET_ADD_CLIP1_max_5_mex';
        otherwise
            method = 'SET_ADD_CLIP1_max_5';
    end
    
    
    %these two values are not used anymore. TODO remove them from the code
    %when cleaning.
    decaySliderValue = 1;
    laplaceSliderValue = 0;

    frameL = processOneFrame( ...
        idx, ePerFrameCumsum, ePerFrameList, ...
        x_data, y_data, pol_data, t_data, retinaRes, ...
        decaySliderValue, radius, laplaceSliderValue, ...
        method, prevFrameUse, g, h, kg, r0, s, ...
        setEventVal, kEVENT, setEventTilt, mEVENT, eventTypeLeft);
end

%PLAY slider only one
function onSlider(src, figHandle)
    idx = round(get(src, 'Value'));
    setappdata(figHandle, 'FrameIdx', idx);
    updateImage(figHandle);
end

%play/pause toggle
function onToggle(src, figHandle)

    tLocal = getappdata(figHandle, 'ViewerTimer');
    hRecordBtn = getappdata(figHandle, 'RecordButton');   % <-- add

    if get(src, 'Value') == 1
        set(src, 'String', 'Pause');

        % --- PLAYBACK STARTED ---
        setappdata(figHandle, 'isPlaying', true);         % <-- add
        if ~isempty(hRecordBtn)
            set(hRecordBtn, 'Enable', 'off');              % <-- add
        end

        if isempty(tLocal) || ~(isa(tLocal, 'timer') && isvalid(tLocal))
            fpsLocal = getappdata(figHandle, 'FPS');
            tLocal = timer('ExecutionMode', 'fixedRate', 'Period', 1 / max(1, fpsLocal), ...
                'BusyMode', 'drop', 'TimerFcn', @(~, ~) onTimerTick(figHandle));
            setappdata(figHandle, 'ViewerTimer', tLocal);
        end
        try start(tLocal); catch, end
    else
        set(src, 'String', 'Play');

        % --- PLAYBACK STOPPED / PAUSED ---
        setappdata(figHandle, 'isPlaying', false);        % <-- add
        if ~isempty(hRecordBtn)
            set(hRecordBtn, 'Enable', 'on');               % <-- add
        end

        if ~isempty(tLocal) && isa(tLocal, 'timer') && isvalid(tLocal)
            try stop(tLocal); catch, end
        end
    end
end

function onTimerTick(figHandle)
    idx = getappdata(figHandle, 'FrameIdx') + 1;
    Nf = getappdata(figHandle, 'Nframes');
    if idx > Nf, idx = 1; end
    setappdata(figHandle, 'FrameIdx', idx);

    hS = getappdata(figHandle, 'hSlider');
    if isgraphics(hS), set(hS, 'Value', idx); end
    updateImage(figHandle);
end


function updateImage(figHandle)
    idx = getappdata(figHandle, 'FrameIdx');

    screenSize = getappdata(figHandle, 'ScreenSize');
    if isempty(screenSize), screenSize = 'full'; end

    clearOption = getappdata(figHandle, 'ClearOption');
    if isempty(clearOption)
        clearOption = 'no-clear';
    end

    % In updateImage:
    erosClearToggle = getappdata(figHandle, 'erosClearToggle');


    % Prev processed frame
    doClear = false;
    if idx == 1
        doClear = true;
    elseif strcmp(clearOption, 'clear-always')
        doClear = true;
    elseif (erosClearToggle == 1) && strcmp(clearOption, 'clear')
        doClear = true;
    end

    if doClear
        prevProcessedFrame = blackFrame;
        prevProcessedFrameR = blackFrame;
        setappdata(figHandle, 'erosClearToggle', 0);
    else
        prevProcessedFrame = squeeze(erosFramesProcessed(idx-1, :, :));
        prevProcessedFrameR = squeeze(erosFramesProcessedR(idx-1, :, :));
    end

    % Read sliders (cache values)
    radiusSliderValue = round(get(sldRadius, 'Value'));
    gGAUSS = get(sldGgauss, 'Value');
    hGAUSS = get(sldHgauss, 'Value');
    kGAUSS = get(sldKgauss, 'Value');
    r0_val = get(sldR0, 'Value');
    sGAUSS = get(sldSgauss, 'Value');

    % Read setEvent sliders (cache values)
    setEventVal = get(sldSetEvent, 'Value');
    setEventValR = get(sldSetEventR, 'Value');

    % Read sliders (cache values) RIGHT
    radiusSliderValueR = round(get(sldRadiusR, 'Value'));
    gGAUSSR = get(sldGgaussR, 'Value');
    hGAUSSR = get(sldHgaussR, 'Value');
    kGAUSSR = get(sldKgaussR, 'Value');
    r0_valR = get(sldR0R, 'Value');
    sGAUSSR = get(sldSgaussR, 'Value');

    %These two are not really used anymore.
    decaySliderValue = 1;
    laplaceSliderValue = 0;
    decaySliderValueR = 1;
    laplaceSliderValueR = 0;


    setEvent = setEventVal;
    setEventR = setEventValR;

    %method = 'ASYMP_mex';
    %method = 'ENHANCE_mex';
    %method = 'ENHANCE_XTRA';
    %method = 'ENHANCE_XTRA_mex';

    %the middle event is set, the rest are added.
    %method = 'SET_KERNEL_3_mex';
    %method = 'SET_ADD_KERNEL_max_5_mex';
    %method = 'SET_ADD_MULT_KERNEL_max_5_mex';
    method = NaN;
    switch mySystem
        case 'windows'
            method = 'SET_ADD_CLIP1_max_5_mex';
        otherwise
            method = 'SET_ADD_CLIP1_max_5';
    end

    % Get the dropdown handles for set and add
    popupLeftMode  = getappdata(hFig, 'popupLeftMode');
    popupRightMode = getappdata(hFig, 'popupRightMode');
    % Read current selections directly from the dropdowns
    eventTypeLeft  = popupLeftMode.String{popupLeftMode.Value};
    eventTypeRight = popupRightMode.String{popupRightMode.Value};

    % === Get slider values for event parameters ===
    sldkEVENT    = getappdata(figHandle, 'sldkEVENT');
    sldkEVENTR   = getappdata(figHandle, 'sldkEVENTR');
    sldTilt      = getappdata(figHandle, 'sldTilt');
    sldTiltR     = getappdata(figHandle, 'sldTiltR');
    
    % Read values (snap kEVENT to integer)
    kEVENT = round(get(sldkEVENT, 'Value'));
    kEVENTR = round(get(sldkEVENTR, 'Value'));
    setEventTilt = get(sldTilt, 'Value');
    setEventTiltR = get(sldTiltR, 'Value');

    %mEVENT = 1;
    %mEVENTR = 1;

    % read new mEVENT sliders (for the internal line/processing)
    sldmEVENT  = getappdata(figHandle, 'sldmEVENT');   % left m for event line / processing
    sldmEVENTR = getappdata(figHandle, 'sldmEVENTR');  % right m
    
    if isgraphics(sldmEVENT)
        mEVENT  = get(sldmEVENT, 'Value');
    else
        mEVENT  = 1;  % fallback if new slider missing
    end
    if isgraphics(sldmEVENTR)
        mEVENTR = get(sldmEVENTR, 'Value');
    else
        mEVENTR = 1;
    end


    % Check left screen enabled
    %Seems like you get the old uncleared screen frame when pressing on/off,
    %is this a bug or should it be like this?
    leftEnabled = getappdata(figHandle, 'LeftEnabled');
    if isempty(leftEnabled), leftEnabled = true; end
    
    if leftEnabled
        switch screenSize
            case 'full'
                processedFrame = processOneFrame(idx, ePerFrameCumsum, ePerFrameList, ...
                    x_data, y_data, pol_data, t_data, retinaRes, decaySliderValue, radiusSliderValue, ...
                    laplaceSliderValue, method, prevProcessedFrame, gGAUSS, hGAUSS, kGAUSS, r0_val, sGAUSS,setEvent,kEVENT,setEventTilt,mEVENT,eventTypeLeft);
            case 'half'
                processedFrame = processOneFrame(idx, ePerFrameCumsumHalf, ePerFrameListHalf, ...
                    filtered_half_x, filtered_half_y, filtered_half_pol, filtered_half_t, retinaRes, decaySliderValue, ...
                    radiusSliderValue, laplaceSliderValue, method, prevProcessedFrame, gGAUSS, hGAUSS, kGAUSS, r0_val, sGAUSS, setEvent,kEVENT,setEventTilt,mEVENT,eventTypeLeft);
            otherwise
                processedFrame = prevProcessedFrame;
        end
    else
        % screen disabled -> use black frame and skip heavy processing
        processedFrame = blackFrame;
    end


    % Check right screen enabled
    rightEnabled = getappdata(figHandle, 'RightEnabled');
    if isempty(rightEnabled), rightEnabled = true; end
    
    if rightEnabled
        switch screenSize
            case 'full'
                processedFrameR = processOneFrame(idx, ePerFrameCumsum, ePerFrameList, ...
                    x_data, y_data, pol_data, t_data, retinaRes, decaySliderValueR, radiusSliderValueR, ...
                    laplaceSliderValueR, method, prevProcessedFrameR, gGAUSSR, hGAUSSR, kGAUSSR, r0_valR, sGAUSSR, setEventR,kEVENTR,setEventTiltR,mEVENTR,eventTypeRight);
            case 'half'
                processedFrameR = processOneFrame(idx, ePerFrameCumsumHalf, ePerFrameListHalf, ...
                    filtered_half_x, filtered_half_y, filtered_half_pol, filtered_half_t, retinaRes, decaySliderValueR, ...
                    radiusSliderValueR, laplaceSliderValueR, method, prevProcessedFrameR, gGAUSSR, hGAUSSR, kGAUSSR, r0_valR, sGAUSSR, setEventR,kEVENTR,setEventTiltR,mEVENTR,eventTypeRight);
            otherwise
                processedFrameR = prevProcessedFrameR;
        end
    else
        processedFrameR = blackFrame;
    end

    % Write back processed frame
    erosFramesProcessed(idx, :, :) = processedFrame;
    set(hIm, 'CData', processedFrame);
    set(hTxt, 'String', sprintf('Frame %d / %d', idx, getappdata(figHandle, 'Nframes')));

    % Write back processed frame RIGHT
    erosFramesProcessedR(idx, :, :) = processedFrameR;
    set(hImRight, 'CData', processedFrameR);


    % Update Gaussian plot using sigmoid decomposition
    r = getappdata(figHandle, 'rGauss');
    hLineGPart = getappdata(figHandle, 'hLineGPart');
    hLineHPart = getappdata(figHandle, 'hLineHPart');
    hLineKPart = getappdata(figHandle, 'hLineKPart');
    hLineTotal = getappdata(figHandle, 'hLineTotal');

    % Update Gaussian plot using sigmoid decomposition RIGHT
    rR = getappdata(figHandle, 'rGaussR');
    hLineGPartR = getappdata(figHandle, 'hLineGPartR');
    hLineHPartR = getappdata(figHandle, 'hLineHPartR');
    hLineKPartR = getappdata(figHandle, 'hLineKPartR');
    hLineTotalR = getappdata(figHandle, 'hLineTotalR');


    if all(isgraphics([hLineGPart, hLineHPart, hLineKPart, hLineTotal]))
        y_g_part = maxInteractiveY ./ (1 + exp(-gGAUSS));
        y_h_part = maxInteractiveY ./ (1 + exp(-hGAUSS .* r));
        y_k_part = maxInteractiveY ./ (1 + exp(-kGAUSS .* exp(-((r - r0_val).^2) ./ (2 * sGAUSS.^2))));
        y_total  = maxInteractiveY ./ (1 + exp(-(gGAUSS + hGAUSS .* r + kGAUSS .* exp(-((r - r0_val).^2) ./ (2 * sGAUSS.^2)))));

        set(hLineGPart, 'YData', y_g_part * ones(size(r)));
        set(hLineHPart, 'YData', y_h_part);
        set(hLineKPart, 'YData', y_k_part);
        set(hLineTotal, 'YData', y_total);

        % --- update markers on left total (recompute from current kEROS)
        hMarkers = getappdata(figHandle, 'hMarkers');
        if isgraphics(hMarkers)
            currRadius = round(get(sldRadius, 'Value'));  % current kEROS (left)
            rMarkers = [];
            for n = 1:currRadius
                for k = 0:n
                    rMarkers(end+1) = sqrt(double(n.^2 + k.^2)); %#ok<AGROW>
                end
            end
            rMarkers = unique(rMarkers);
            rMarkers = rMarkers(rMarkers <= max(r));   % clip to domain
            if isempty(rMarkers)
                set(hMarkers, 'XData', [], 'YData', []);
            else
                y_markers = maxInteractiveY ./ (1 + exp(-(gGAUSS + hGAUSS .* rMarkers ...
                              + kGAUSS .* exp(-((rMarkers - r0_val).^2) ./ (2 * sGAUSS.^2)))));
                set(hMarkers, 'XData', rMarkers, 'YData', y_markers);
            end
        end

    end

    if all(isgraphics([hLineGPartR, hLineHPartR, hLineKPartR, hLineTotalR]))
        y_g_partR = maxInteractiveY ./ (1 + exp(-gGAUSSR));
        y_h_partR = maxInteractiveY ./ (1 + exp(-hGAUSSR .* rR));
        y_k_partR = maxInteractiveY ./ (1 + exp(-kGAUSSR .* exp(-((rR - r0_valR).^2) ./ (2 * sGAUSSR.^2))));
        y_totalR  = maxInteractiveY ./ (1 + exp(-(gGAUSSR + hGAUSSR .* rR + kGAUSSR .* exp(-((rR - r0_valR).^2) ./ (2 * sGAUSSR.^2)))));

        set(hLineGPartR, 'YData', y_g_partR * ones(size(rR)));
        set(hLineHPartR, 'YData', y_h_partR);
        set(hLineKPartR, 'YData', y_k_partR);
        set(hLineTotalR, 'YData', y_totalR);

        % --- update markers on right total (recompute from current kEROSR)
        hMarkersR = getappdata(figHandle, 'hMarkersR');
        if isgraphics(hMarkersR)
            currRadiusR = round(get(sldRadiusR, 'Value'));  % current kEROS (right)
            rMarkersR = [];
            for n = 1:currRadiusR
                for k = 0:n
                    rMarkersR(end+1) = sqrt(double(n.^2 + k.^2)); %#ok<AGROW>
                end
            end
            rMarkersR = unique(rMarkersR);
            rMarkersR = rMarkersR(rMarkersR <= max(rR));   % clip to domain
            if isempty(rMarkersR)
                set(hMarkersR, 'XData', [], 'YData', []);
            else
                y_markersR = maxInteractiveY ./ (1 + exp(-(gGAUSSR + hGAUSSR .* rMarkersR ...
                               + kGAUSSR .* exp(-((rMarkersR - r0_valR).^2) ./ (2 * sGAUSSR.^2)))));
                set(hMarkersR, 'XData', rMarkersR, 'YData', y_markersR);
            end
        end
    end

    % --- update setEvent dot (left)
    hDot = getappdata(figHandle, 'hSetEventDot');
    if isgraphics(hDot)
        xPos = 0;
        set(hDot, 'XData', xPos, 'YData', setEventVal);  % y directly from slider [0,2]
    end
    
    % --- update setEvent dot (right)
    hDotR = getappdata(figHandle, 'hSetEventDotR');
    if isgraphics(hDotR)
        xPos = 0;
        set(hDotR, 'XData', xPos, 'YData', setEventValR);
    end

    % --- update event lines y = m + k * x (left & right) ---
    hEventLine = getappdata(figHandle, 'hEventLine');
    hEventLineR = getappdata(figHandle, 'hEventLineR');
    
    % --- Left-side event line and violet markers ---
    sldMline = getappdata(figHandle,'sldmEVENT');  
    sldK     = getappdata(figHandle,'sldTilt');
    axL      = getappdata(figHandle,'hAxGauss');
    
    assert(isgraphics(sldMline), 'sldmEVENT slider missing!');
    assert(isgraphics(sldK), 'sldTilt slider missing!');
    assert(isgraphics(axL), 'Left Gaussian axes missing!');
    
    m_line = get(sldMline,'Value');
    k_line = get(sldK,'Value');
    
    % Event line (smooth)
    xl = xlim(axL);
    xvec = linspace(xl(1), xl(2), 300);
    yvec = maxInteractiveY./(1 + exp(-(m_line + k_line .* xvec)));
    yl = ylim(axL);
    yvec_clipped = min(max(yvec, yl(1)), yl(2));
    
    hEventLine = getappdata(figHandle,'hEventLine');
    if isgraphics(hEventLine)
        set(hEventLine, 'XData', xvec, 'YData', yvec_clipped, 'Visible', 'on');
    end
    
    % Violet markers
    currRadius = round(get(getappdata(figHandle,'sldkEVENT'),'Value'));
    if currRadius <= 0
        set(getappdata(figHandle,'hEventMarkers'), 'XData', [], 'YData', [], 'Visible', 'off');
    else
        rMarkers = [];
        for n = 1:currRadius
            for kk = 0:n
                rMarkers(end+1) = sqrt(n^2 + kk^2); %#ok<AGROW>
            end
        end
        rMarkers = unique(rMarkers);
        rMarkers = rMarkers(rMarkers >= xl(1) & rMarkers <= xl(2));
    
        y_mark = interp1(xvec, yvec, rMarkers, 'linear', 'extrap');
    
        hEventMarkers = getappdata(figHandle,'hEventMarkers');
        set(hEventMarkers, 'XData', rMarkers, 'YData', y_mark, 'Visible', 'on');
        uistack(hEventMarkers,'top');

    %disp('Small top position:'), disp(get(hAxSmallTop, 'Position'))
    %disp('Small bottom position:'), disp(get(hAxSmallBottom, 'Position'))

    end





    % --- Right-side event line and violet markers ---
    sldMlineR = getappdata(figHandle,'sldmEVENTR');  
    sldKR     = getappdata(figHandle,'sldTiltR');
    axR       = getappdata(figHandle,'hAxGaussR');
    
    assert(isgraphics(sldMlineR), 'sldmEVENTR slider missing!');
    assert(isgraphics(sldKR), 'sldTiltR slider missing!');
    assert(isgraphics(axR), 'Right Gaussian axes missing!');
    
    m_lineR = get(sldMlineR,'Value');
    kR = get(sldKR,'Value');
    
    xlR = xlim(axR);
    xvecR = linspace(xlR(1), xlR(2), 300);
    yvecR = maxInteractiveY./(1 + exp(-(m_lineR + kR .* xvecR)));
    ylR = ylim(axR);
    yvecR_clipped = min(max(yvecR, ylR(1)), ylR(2));
    
    hEventLineR = getappdata(figHandle,'hEventLineR');
    if isgraphics(hEventLineR)
        set(hEventLineR, 'XData', xvecR, 'YData', yvecR_clipped, 'Visible', 'on');
    end
    
    currRadiusR = round(get(getappdata(figHandle,'sldkEVENTR'),'Value'));
    if currRadiusR <= 0
        set(getappdata(figHandle,'hEventMarkersR'), 'XData', [], 'YData', [], 'Visible', 'off');
    else
        rMarkersR = [];
        for n = 1:currRadiusR
            for kk = 0:n
                rMarkersR(end+1) = sqrt(n^2 + kk^2); %#ok<AGROW>
            end
        end
        rMarkersR = unique(rMarkersR);
        rMarkersR = rMarkersR(rMarkersR >= xlR(1) & rMarkersR <= xlR(2));
    
        y_markR = interp1(xvecR, yvecR, rMarkersR, 'linear', 'extrap');
    
        hEventMarkersR = getappdata(figHandle,'hEventMarkersR');
        set(hEventMarkersR, 'XData', rMarkersR, 'YData', y_markR, 'Visible', 'on');
        uistack(hEventMarkersR,'top');
    end

    %reconstructed and extracted curve images:
    % Call your function with top image
    shiftedIDX = idx + cannyReconstructStartFrame-1;
    showReconstructedImageLeft(hFig, shiftedIDX, 'top');
    
    % Call your function with bottom image
    lineImagePath = showReconstructedImageLeft(hFig, shiftedIDX, 'bottom');
    
    % iouValue = computeIoU(processedFrame, lineImagePath);
    % 
    % display(iouValue);
    % iouText = getappdata(hFig, 'iouText');
    % set(iouText, 'String', sprintf('IoU: %.4f', iouValue));

    %============MAE METRICS update==========

    refImg = imread(lineImagePath);
    refImg = im2double(refImg);

    updateMAETables(hFig, processedFrame, processedFrameR, refImg,idx);


    drawnow limitrate
end

%% --- Simple callbacks (left and right) ---
function sliderChanged(~, figHandle)
    % LEFT-side callback (no safety checks — will error if appdata names missing)

    % setEvent (m)
    lblSetEvent = getappdata(figHandle, 'lblSetEvent');
    sldSetEvent = getappdata(figHandle, 'sldSetEvent');
    set(lblSetEvent, 'String', sprintf('%.2f', get(sldSetEvent, 'Value')));

    % kEVENT (discrete integer)
    lblk = getappdata(figHandle, 'lblkEVENT');
    sldk = getappdata(figHandle, 'sldkEVENT');
    v = round(get(sldk, 'Value'));
    set(sldk, 'Value', v);
    set(lblk, 'String', sprintf('%d', v));

    % setEventTilt (k)
    lblT = getappdata(figHandle, 'lblTilt');
    sldT = getappdata(figHandle, 'sldTilt');
    set(lblT, 'String', sprintf('%.2f', get(sldT, 'Value')));

    % radius (discrete)
    lblRadius = getappdata(figHandle, 'lblRadius');
    sldRadius = getappdata(figHandle, 'sldRadius');
    vr = round(get(sldRadius, 'Value'));
    set(sldRadius, 'Value', vr);
    set(lblRadius, 'String', sprintf('%d', vr));

    % gGAUSS (left)
    lblGgauss = getappdata(figHandle, 'lblGgauss');
    sldGgauss = getappdata(figHandle, 'sldGgauss');
    set(lblGgauss, 'String', sprintf('%.2f', get(sldGgauss, 'Value')));

    % hGAUSS (left)
    lblHgauss = getappdata(figHandle, 'lblHgauss');
    sldHgauss = getappdata(figHandle, 'sldHgauss');
    set(lblHgauss, 'String', sprintf('%.2f', get(sldHgauss, 'Value')));

    % kGAUSS (left)
    lblKgauss = getappdata(figHandle, 'lblKgauss');
    sldKgauss = getappdata(figHandle, 'sldKgauss');
    set(lblKgauss, 'String', sprintf('%.2f', get(sldKgauss, 'Value')));

    % r0 (left)
    lblR0 = getappdata(figHandle, 'lblR0');
    sldR0 = getappdata(figHandle, 'sldR0');
    set(lblR0, 'String', sprintf('%.2f', get(sldR0, 'Value')));

    % sGAUSS (left)
    lblSgauss = getappdata(figHandle, 'lblSgauss');
    sldSgauss = getappdata(figHandle, 'sldSgauss');
    set(lblSgauss, 'String', sprintf('%.2f', get(sldSgauss, 'Value')));

    % trigger redraw
    setappdata(figHandle, 'erosClearToggle', 1);

    % mEVENT left numeric label
    lblmEVENT = getappdata(figHandle, 'lblmEVENT');
    sldmEVENT = getappdata(figHandle, 'sldmEVENT');
    if isgraphics(lblmEVENT) && isgraphics(sldmEVENT)
        set(lblmEVENT, 'String', sprintf('%.2f', get(sldmEVENT, 'Value')));
    end



    updateImage(figHandle);
end

function sliderChangedR(~, figHandle)
    % RIGHT-side callback (no safety checks — will error if appdata names missing)

    % setEvent (m) right
    lblSetEventR = getappdata(figHandle, 'lblSetEventR');
    sldSetEventR = getappdata(figHandle, 'sldSetEventR');
    set(lblSetEventR, 'String', sprintf('%.2f', get(sldSetEventR, 'Value')));

    % kEVENTR (discrete integer)
    lblkR = getappdata(figHandle, 'lblkEVENTR');
    sldkR = getappdata(figHandle, 'sldkEVENTR');
    vR = round(get(sldkR, 'Value'));
    set(sldkR, 'Value', vR);
    set(lblkR, 'String', sprintf('%d', vR));

    % setEventTilt (k) right
    lblTR = getappdata(figHandle, 'lblTiltR');
    sldTR = getappdata(figHandle, 'sldTiltR');
    set(lblTR, 'String', sprintf('%.2f', get(sldTR, 'Value')));

    % radius right
    lblRadiusR = getappdata(figHandle, 'lblRadiusR');
    sldRadiusR = getappdata(figHandle, 'sldRadiusR');
    vrR = round(get(sldRadiusR, 'Value'));
    set(sldRadiusR, 'Value', vrR);
    set(lblRadiusR, 'String', sprintf('%d', vrR));

    % gGAUSS right
    lblGgaussR = getappdata(figHandle, 'lblGgaussR');
    sldGgaussR = getappdata(figHandle, 'sldGgaussR');
    set(lblGgaussR, 'String', sprintf('%.2f', get(sldGgaussR, 'Value')));

    % hGAUSS right
    lblHgaussR = getappdata(figHandle, 'lblHgaussR');
    sldHgaussR = getappdata(figHandle, 'sldHgaussR');
    set(lblHgaussR, 'String', sprintf('%.2f', get(sldHgaussR, 'Value')));

    % kGAUSS right
    lblKgaussR = getappdata(figHandle, 'lblKgaussR');
    sldKgaussR = getappdata(figHandle, 'sldKgaussR');
    set(lblKgaussR, 'String', sprintf('%.2f', get(sldKgaussR, 'Value')));

    % r0 right
    lblR0R = getappdata(figHandle, 'lblR0R');
    sldR0R = getappdata(figHandle, 'sldR0R');
    set(lblR0R, 'String', sprintf('%.2f', get(sldR0R, 'Value')));

    % sGAUSS right
    lblSgaussR = getappdata(figHandle, 'lblSgaussR');
    sldSgaussR = getappdata(figHandle, 'sldSgaussR');
    set(lblSgaussR, 'String', sprintf('%.2f', get(sldSgaussR, 'Value')));

    % trigger redraw
    setappdata(figHandle, 'erosClearToggle', 1);

    % mEVENT right numeric label
    lblmEVENTR = getappdata(figHandle, 'lblmEVENTR');
    sldmEVENTR = getappdata(figHandle, 'sldmEVENTR');
    if isgraphics(lblmEVENTR) && isgraphics(sldmEVENTR)
        set(lblmEVENTR, 'String', sprintf('%.2f', get(sldmEVENTR, 'Value')));
    end


    updateImage(figHandle);
end




function modeChanged(src, figHandle)
    options = get(src, 'String'); val = get(src, 'Value');
    setappdata(figHandle, 'ScreenSize', options{val});

    setappdata(hFig, 'erosClearToggle', 1);

    updateImage(figHandle);
    disp(['Current mode: ' options{val}])
end

function clearChanged(src, figHandle)
    options = get(src, 'String');
    val = get(src, 'Value');
    % store choice (string) in appdata for easy access elsewhere
    setappdata(figHandle, 'ClearOption', options{val});
    % optional: display small console message
    disp(['Clear option: ' options{val}]);
    % refresh image if you want immediate effect
    setappdata(hFig, 'erosClearToggle', 1);
    updateImage(figHandle);
end

% nested minimal callback (only updates fpsVideo in appdata)
function fpsSelectorCallback(src, figHandle)
    fpsList = [1 5 10 20 30];
    idx = get(src, 'Value');
    fpsNew = fpsList(idx);
    setappdata(figHandle, 'FPS', fpsNew);

    % Update timer if it exists
    t = getappdata(figHandle, 'ViewerTimer');
    if ~isempty(t) && isa(t, 'timer') && isvalid(t)
        wasRunning = strcmp(t.Running, 'on');
        stop(t);
        t.Period = 1 / max(1, fpsNew);
        if wasRunning
            start(t);
        end
    end

    setappdata(hFig, 'erosClearToggle', 1);

    disp(['vFPS option: ' num2str(fpsNew)]);
end

function toggleLeftCallback(src, figHandle)
    isOn = get(src,'Value') == 1;
    % update button text
    consoleTxt = '';
    if isOn
        set(src,'String','On');
        consoleTxt = 'On';
    else
        set(src,'String','Off');
        consoleTxt = 'Off';
    end
    setappdata(figHandle, 'LeftEnabled', isOn);
    disp([ 'Left image: ' consoleTxt ]);

    setappdata(hFig, 'erosClearToggle', 1);
    updateImage(figHandle);
    
end

function toggleRightCallback(src, figHandle)
    isOn = get(src,'Value') == 1;
    consoleTxt = '';
    if isOn
        set(src,'String','On');
        consoleTxt = 'On';
    else
        set(src,'String','Off');
        consoleTxt = 'Off';
    end
    setappdata(figHandle, 'RightEnabled', isOn);
    disp([ 'Right image: ' consoleTxt ]);

    setappdata(hFig, 'erosClearToggle', 1);
    updateImage(figHandle);
end


%only one button
function onClose(figHandle)
    tLocal = getappdata(figHandle, 'ViewerTimer');
    if ~isempty(tLocal) && isa(tLocal, 'timer') && isvalid(tLocal)
        try stop(tLocal); catch, end
        try delete(tLocal); catch, end
    end
    delete(figHandle);
end

function imagePath = showReconstructedImageLeft(figHandle, nr, whichAxes)
    % Get folder
    path = path_reconstructed;
    path2 = path_canny;

    % Determine which axes to use
    if strcmp(whichAxes, 'top')
        hAx = getappdata(figHandle, 'hAxSmallTop');
        imgFiles = dir(fullfile(path, '*.png'));
            % Load image
        %imgFiles = dir(fullfile(path, '*.png'));
        nr = max(1, min(nr, numel(imgFiles)));
        img = imread(fullfile(path, imgFiles(nr).name));
    
        % Display
        imshow(img, 'Parent', hAx);
        axis(hAx, 'off');
    else
        hAx = getappdata(figHandle, 'hAxSmallBottom');
        imgFiles = dir(fullfile(path2, '*.png'));
            % Load image
        %imgFiles = dir(fullfile(path, '*.png'));
        nr = max(1, min(nr, numel(imgFiles)));
        fullfilevar = fullfile(path2, imgFiles(nr).name);
        img = imread(fullfilevar);
    
        % Display
        imshow(img, 'Parent', hAx);
        axis(hAx, 'off');

        imagePath = fullfile(path2, imgFiles(nr).name);
    end

end

function imagePath = getCannyImagePath(nr)
% GETCANNYIMAGEPATH Return the full path to the nr-th Canny image
%   imagePath = getCannyImagePath(nr)
%
%   nr - index of the image (1-based)
%   imagePath - full path to the Canny image

    % Folder containing Canny images
    path2 = path_canny;  % make sure this variable exists in your workspace or function

    % Get list of PNG files
    imgFiles = dir(fullfile(path2, '*.png'));

    % Clamp nr to valid range
    nr = max(1, min(nr, numel(imgFiles)));

    % Return full path
    imagePath = fullfile(path2, imgFiles(nr).name);
end


function updateMAETables(hFig, processedFrame, processedFrameR, refImg,idx)
    % Retrieve table handles
    tableLeft  = getappdata(hFig, 'tableLeft');
    tableRight = getappdata(hFig, 'tableRight');

    % Compute metrics
    %tolerance_thickness = 2;
    
    tolL = getappdata(hFig,'tolLeft');
    tolR = getappdata(hFig,'tolRight');

    %MAE_metrics_left  = computeMAE_blackmask(refImg, processedFrame);
    MAE_metrics_left  = computeMAE_paddedCanny(refImg, processedFrame,tolL);
    %MAE_metrics_right = computeMAE_blackmask(refImg, processedFrameR);
    MAE_metrics_right = computeMAE_paddedCanny(refImg, processedFrameR,tolR);
    setappdata(hFig, 'MAE_metrics_left', MAE_metrics_left);
    setappdata(hFig, 'MAE_metrics_right', MAE_metrics_right);

    % Format new data
    dataLeft = {
        sprintf('white %.2f%%\nMAE: %.2f', MAE_metrics_left.TP_percent, MAE_metrics_left.MAE_TP), ...
        sprintf('blue %.2f%%\nMAE: %.2f', MAE_metrics_left.TN_percent, MAE_metrics_left.MAE_TN);
        sprintf('red %.2f%%\nMAE: %.2f', MAE_metrics_left.FP_percent, MAE_metrics_left.MAE_FP), ...
        sprintf('green %.2f%%\nMAE: %.2f', MAE_metrics_left.FN_percent, MAE_metrics_left.MAE_FN)

        sprintf('Thrshld: %.2f', MAE_metrics_left.my_thresh), ...
        sprintf('Tot MAE: %.3f', MAE_metrics_left.MAE_ALL), ...


        sprintf('F1:%.3f', MAE_metrics_left.F1_score), ...
        sprintf('MAEnoTN:%.3f', MAE_metrics_left.MAE_no_TN)
    };

    dataRight = {
        sprintf('white %.2f%%\nMAE: %.2f', MAE_metrics_right.TP_percent, MAE_metrics_right.MAE_TP), ...
        sprintf('blue %.2f%%\nMAE: %.2f', MAE_metrics_right.TN_percent, MAE_metrics_right.MAE_TN);
        sprintf('red %.2f%%\nMAE: %.2f', MAE_metrics_right.FP_percent, MAE_metrics_right.MAE_FP), ...
        sprintf('green %.2f%%\nMAE: %.2f', MAE_metrics_right.FN_percent, MAE_metrics_right.MAE_FN)

        sprintf('Thrshld: %.2f', MAE_metrics_right.my_thresh), ...
        sprintf('Tot MAE: %.3f', MAE_metrics_right.MAE_ALL), ...

        sprintf('F1:%.3f', MAE_metrics_right.F1_score), ...
        sprintf('MAEnoTN:%.3f', MAE_metrics_right.MAE_no_TN)
    };

    % Update tables
    tableLeft.Data  = dataLeft;
    tableRight.Data = dataRight;

    % Update error window
    maeValuesLeft(idx) = MAE_metrics_left.MAE_ALL;
    maeValuesRight(idx) = MAE_metrics_right.MAE_ALL;

    % if idx==1
    %     % First frame, running average = first value
    %     maeValuesLeft_MA(idx)  = MAE_metrics_left.MAE_ALL;
    %     maeValuesRight_MA(idx) = MAE_metrics_right.MAE_ALL;
    % else
    %     maeValuesLeft_MA(idx) = maeValuesLeft_MA(idx-1) + ( MAE_metrics_left.MAE_ALL - maeValuesLeft_MA(idx-1) )/idx;
    %     maeValuesRight_MA(idx) = maeValuesRight_MA(idx-1) + ( MAE_metrics_right.MAE_ALL - maeValuesRight_MA(idx-1) )/idx;
    % end
    maeValuesLeft_MA(idx)  = mean(maeValuesLeft(1:idx));
    maeValuesRight_MA(idx) = mean(maeValuesRight(1:idx));


    set(maeLineLeft, ...
    'XData', 1:errorVectorSize, ...
    'YData', maeValuesLeft(1:errorVectorSize));

    set(maeLineRight, ...
    'XData', 1:errorVectorSize, ...
    'YData', maeValuesRight(1:errorVectorSize));

    % Update the moving-average MAE lines
    set(maeMovLineLeft, ...
        'XData', 1:errorVectorSize, ...
        'YData', maeValuesLeft_MA(1:errorVectorSize));
    
    set(maeMovLineRight, ...
        'XData', 1:errorVectorSize, ...
        'YData', maeValuesRight_MA(1:errorVectorSize));

    % === UPDATE F1 WINDOW ===
    
    % Store current F1 values
    f1ValuesLeft(idx)  = MAE_metrics_left.F1_score;
    f1ValuesRight(idx) = MAE_metrics_right.F1_score;
    
    % Running (cumulative) moving average
    f1ValuesLeft_MA(idx)  = mean(f1ValuesLeft(1:idx));
    f1ValuesRight_MA(idx) = mean(f1ValuesRight(1:idx));

    
    % Update F1 moving-average plots
    set(f1MovLineLeft, ...
        'XData', 1:errorVectorSize, ...
        'YData', f1ValuesLeft_MA(1:errorVectorSize));
    
    set(f1MovLineRight, ...
        'XData', 1:errorVectorSize, ...
        'YData', f1ValuesRight_MA(1:errorVectorSize));

    % === UPDATE CUMULATIVE MAE_NO_TN WINDOW ===

    % Store current MAE_no_TN values for this frame
    maeNoTNValuesLeft(idx)  = MAE_metrics_left.MAE_no_TN;
    maeNoTNValuesRight(idx) = MAE_metrics_right.MAE_no_TN;
    
    % Running (cumulative) moving average
    maeNoTNValuesLeft_MA(idx)  = mean(maeNoTNValuesLeft(1:idx));
    maeNoTNValuesRight_MA(idx) = mean(maeNoTNValuesRight(1:idx));

    
    % Update the cumulative-average plots
    set(maeNoTNLineLeft, ...
        'XData', 1:maeNoTNVectorSize, ...
        'YData', maeNoTNValuesLeft_MA(1:maeNoTNVectorSize));
    
    set(maeNoTNLineRight, ...
        'XData', 1:maeNoTNVectorSize, ...
        'YData', maeNoTNValuesRight_MA(1:maeNoTNVectorSize));



    %== UPDATE COLOR MASKS ==

    hOverlay = getappdata(hFig,'hOverlay');
    colorOn = getappdata(hFig, 'colorOn');
    
    if colorOn == false
        % Turn OFF overlays
        [hOverlay.AlphaData] = deal(zeros(size(hOverlay(1).AlphaData)));
    else
        % Turn ON overlays (restore last MAE masks)
        baseAlpha = 0.6;
        baseAlphaStrong = 0.9;
        
        [hOverlay.AlphaData] = deal( ...
            baseAlpha*MAE_metrics_left.FP_mask, ...
            baseAlpha*MAE_metrics_left.TP_mask, ...
            baseAlpha*MAE_metrics_left.TN_mask, ...
            baseAlphaStrong*MAE_metrics_left.FN_mask, ...
            baseAlpha*MAE_metrics_left.P_mask);
    end

    hOverlayRight = getappdata(hFig,'hOverlayRight');
    colorOn2 = getappdata(hFig, 'colorOn2');
    
    if colorOn2 == false
        % Turn OFF overlays
        [hOverlayRight.AlphaData] = deal(zeros(size(hOverlayRight(1).AlphaData)));
    else
        % Turn ON overlays (restore last MAE masks)
        baseAlpha = 0.6;
        baseAlphaStrong = 0.9;
        [hOverlayRight.AlphaData] = deal( ...
            baseAlpha*MAE_metrics_right.FP_mask, ...
            baseAlpha*MAE_metrics_right.TP_mask, ...
            baseAlpha*MAE_metrics_right.TN_mask, ...
            baseAlphaStrong*MAE_metrics_right.FN_mask, ...
            baseAlpha*MAE_metrics_right.P_mask);
    end
    
    drawnow limitrate;
end

function leftDropdownChanged(src, hFig)
    val = src.Value;
    items = src.String;
    disp(['Left dropdown changed to: ' items{val}]);
    
    % Trigger image update
    setappdata(hFig, 'erosClearToggle', 1);
    updateImage(hFig);
end

function rightDropdownChanged(src, hFig)
    val = src.Value;
    items = src.String;
    disp(['Right dropdown changed to: ' items{val}]);
    
    % Trigger image update
    setappdata(hFig, 'erosClearToggle', 1);
    updateImage(hFig);
end






end
