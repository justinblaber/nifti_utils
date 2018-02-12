# nifti_utils
This an an extension for [Tools for NIfTI and ANALYZE image](https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image) and contains additional utilities that I found useful when dealing with NIFTIs in MATLAB. 

Most of the utilities I developed are for allowing data processing to occur WRT storage orientation while also taking data scaling into account. And also saving NIFTIs after they have modified/processed in the same orientation. There are also utilities for getting the volume in "voxel RAS" orientation which is useful for plotting results without resampling or reslicing the data. 

# Installation instructions:
1) It's simple, just set environment:
```
addpath(genpath('~/nifti_utils'));
```
2) Test out some of the utilities:

```
# Load volume
test_vol = nifti_utils.load_untouch_nii_vol_scaled('test.nii.gz','double');

# Get "voxel RAS" transform
xform_RAS = nifti_utils.get_voxel_RAS_xform('test.nii.gz');

# Apply transform to volume
test_vol_RAS = nifti_utils.vol_apply_xform(test_vol,xform_RAS);

# View the 4D volume slice-wise
nifti_utils.vol_viewer_4D(test_vol_RAS);
```
<p align="center">
  <img width="558" height="481"  src="https://i.imgur.com/qyLYnPl.png">
</p>
