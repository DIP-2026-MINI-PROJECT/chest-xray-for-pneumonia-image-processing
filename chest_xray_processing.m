%% Chest X-ray Image Processing Pipeline
% Steps: load -> gray-level transforms -> CLAHE -> spatial filters ->
%        unsharp masking -> pseudocolor -> histograms.
% Note: local functions at the bottom of a script need MATLAB R2016b+.

clear; clc; close all;

%% Parameters
cfg.gamma       = 0.7;
cfg.claheClip   = 0.01;
cfg.claheTiles  = [8 8];
cfg.gaussSigma  = 1;
cfg.medianSize  = [3 3];
cfg.sharpen     = struct('Radius', 2, 'Amount', 1, 'Threshold', 0.02);
cfg.lungROI     = [0.22 0.82; 0.12 0.88]; 
cfg.zoomFactor  = 2;

%% Load image
[xray, grayImage] = loadXray();
if isempty(xray)
    disp('No image selected.');
    return;
end

%% Gray-level transformations
contrastImage = imadjust(grayImage, stretchlim(grayImage), []);
gammaImage    = imadjust(grayImage, [], [], cfg.gamma);
negativeImage = imcomplement(grayImage);

showGrid('Gray-Level Transformations', 1, 3, ...
    {contrastImage, gammaImage, negativeImage}, ...
    {'Contrast Stretching', 'Gamma Correction', 'Image Negative'});

%% CLAHE
enhancedImage = adapthisteq(grayImage, ...
    'ClipLimit', cfg.claheClip, 'NumTiles', cfg.claheTiles);

%% Spatial filtering comparison
meanFiltered     = imfilter(enhancedImage, ones(3) / 9, 'replicate');
gaussianFiltered = imgaussfilt(enhancedImage, cfg.gaussSigma);
medianFiltered   = medfilt2(enhancedImage, cfg.medianSize);
filteredImage    = medianFiltered;   
showGrid('Spatial Filters', 2, 2, ...
    {enhancedImage, meanFiltered, gaussianFiltered, medianFiltered}, ...
    {'Input', 'Mean Filter', 'Gaussian Filter', 'Median Filter'});

%% Lung region zoom
lungZoom = cropFractional(enhancedImage, cfg.lungROI);
lungZoom = imresize(lungZoom, cfg.zoomFactor);

%% Unsharp masking
unsharpImage = imsharpen(filteredImage, ...
    'Radius',    cfg.sharpen.Radius, ...
    'Amount',    cfg.sharpen.Amount, ...
    'Threshold', cfg.sharpen.Threshold);

showGrid('Image Sharpening', 1, 2, ...
    {filteredImage, unsharpImage}, ...
    {'Before Sharpening', 'Unsharp Masking'});

%% Pseudocolor visualization
colorXray = ind2rgb(enhancedImage, turbo(256));

showGrid('Pseudocolor X-ray', 1, 2, ...
    {enhancedImage, colorXray}, ...
    {'Grayscale X-ray', 'Pseudocolor X-ray'});

%% Summary figure
showGrid('Chest X-ray Processing', 2, 3, ...
    {xray, grayImage, enhancedImage, filteredImage, lungZoom, colorXray}, ...
    {'1. Original X-ray', '2. Grayscale', '3. CLAHE Enhanced', ...
     '4. Median Filtered', '5. Zoomed Lung Region', '6. Pseudocolor'}, ...
    'AutoScale', true);

%% Intensity histograms
figure('Name', 'Intensity Histograms', 'NumberTitle', 'off');
plotHistogram(grayImage,     1, 'Before CLAHE');
plotHistogram(enhancedImage, 2, 'After CLAHE');

%% Main functions
function [xray, grayImage] = loadXray()
    filter = {'*.png;*.jpg;*.jpeg;*.tif;*.tiff;*.bmp', 'Chest X-ray images'};
    [fileName, folderName] = uigetfile(filter, 'Select a chest X-ray');
    if isequal(fileName, 0)
        xray = [];
        grayImage = [];
        return;
    end
    xray = imread(fullfile(folderName, fileName));
    if ndims(xray) == 3
        grayImage = im2gray(xray);
    else
        grayImage = xray;
    end
    grayImage = im2uint8(mat2gray(grayImage));
end

function showGrid(figName, nRows, nCols, images, titles, varargin)
    p = inputParser;
    addParameter(p, 'AutoScale', false);
    parse(p, varargin{:});

    figure('Name', figName, 'NumberTitle', 'off');
    for k = 1:numel(images)
        subplot(nRows, nCols, k);
        if p.Results.AutoScale
            imshow(images{k}, []);
        else
            imshow(images{k});
        end
        title(titles{k});
    end
end

function region = cropFractional(img, roi)
    [rows, cols] = size(img);
    r1 = max(1,    round(roi(1,1) * rows));
    r2 = min(rows, round(roi(1,2) * rows));
    c1 = max(1,    round(roi(2,1) * cols));
    c2 = min(cols, round(roi(2,2) * cols));
    region = img(r1:r2, c1:c2);
end

function plotHistogram(img, idx, plotTitle)
    subplot(1, 2, idx);
    imhist(img);
    title(plotTitle);
    xlabel('Pixel Intensity');
    ylabel('Pixel Count');
end