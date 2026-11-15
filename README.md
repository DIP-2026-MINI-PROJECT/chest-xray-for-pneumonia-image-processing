# Chest Xray Image Processing for Pneumonia 

### Project Description:
#### Summary - 
Our project demonstrates a MATLAB-based digital image processing script for enhancing and visualizing chest X-ray images. The program allows the user to select a chest X-ray image and applies grayscale conversion, intensity transformations, contrast enhancement, spatial filtering, sharpening, and pseudocolor visualization techniques.

Our script compares multiple enhancement and filtering methods so that their effects on image appearance can be inspected. It also displays intensity histograms before and after Contrast-Limited Adaptive Histogram Equalization (CLAHE), along with a zoomed view of a selected lung region.
(NOTE: This is only for image processing and does not perform pneumonia detection or provide clinical diagnosis.)

#### Course concepts used - 
1. Digital Image Fundamentals (Unit 1) - imread, im2gray, uint8, region of interest, etc.
2. Image enhancement in Spatial and Frequency domains (Unit 2 and 3) - Gray level transformations, Gamma Correction (imadjust), negative image, filters (mean, median, gaussian), image sharpening (imsharpen).
3. Morphological/Color Image Processing (Unit 4) - pseudocolor visualisation.
   
#### Additional concepts used -
1. Contrast-Limited Adaptive Histogram Equalisation (CLAHE).
2. Unsharp masking
   
#### Dataset - 
No datasets. Input xray images can be .png or .jpeg or .tif or .bmp.

#### Novelty - 
1. Focused lung-region visualization: A selected region of the
chest X-ray is cropped and enlarged to make local image details
easier to inspect.
2. Multiple enhancement methods in one workflow: Our script
presents contrast stretching, gamma correction, image negative,
CLAHE, and three spatial filters for comparison on the selected
image.
   
### Contributors:
1. Bhuwan Chandra J Beri (PES1UG24EC051)
2. D Nithish Kumar (PES1UG24EC059)
3. Hrishikesh Nadig (PES1UG24EC091)

### Outputs:
The program generates the following visual outputs:

-> Gray-level transformations:
  - Contrast-stretched image.
  - Gamma-corrected image.
  - Image negative.

-> Spatial filtering comparison:
  - CLAHE-enhanced input.
  - Mean-filtered image.
  - Gaussian-filtered image.
  - Median-filtered image.

-> Image sharpening:
  - Image before sharpening.
  - Image after unsharp masking.

-> Pseudocolor visualization:
  - CLAHE-enhanced grayscale image.
  - Pseudocolor image generated using the turbo colormap.

-> Chest X-ray processing overview:
  - Original X-ray.
  - Grayscale image.
  - CLAHE-enhanced image.
  - Median-filtered image.
  - Enlarged lower lung-region crop.

-> Intensity histograms:
  - Histogram before CLAHE.
  - Histogram after CLAHE.

### References:
1. Official Matlab Documentation

   
### Limitations:
-> The program performs visual enhancement only; it does not identify,
classify, or diagnose pneumonia.

-> The lung-region crop is selected using fixed proportional
coordinates. It is not an anatomical lung segmentation algorithm and
may not isolate the lungs accurately for every image.

-> The current comparison is primarily visual; it does not calculate
quantitative image-quality metrics.

### Future Work:
-> Add automatic lung-region segmentation instead of relying on a fixed
crop.
-> Implement morphological operations such as dilation, erosion,
opening, and closing.
