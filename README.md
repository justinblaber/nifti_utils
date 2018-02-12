# nifti_utils
This an an extension for [Tools for NIfTI and ANALYZE image](https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image) and contains additional utilities that I found useful when dealing with NIFTIs in MATLAB. 

Most of the utilities I developed are for allowing data processing to occur WRT storage orientation while also taking data scaling into account. And also saving NIFTIs after they have modified/processed in the same orientation. There are also utilities for getting the volume in "voxel RAS" orientation which is useful for plotting results with out resampling or reslicing the data. 

# Installation instructions:
1) It's simple, just set environment:
```
addpath(genpath('~/nifti_utils'));
```
