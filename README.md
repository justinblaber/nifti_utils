# nifti_utils
This is an extension for [Tools for NIfTI and ANALYZE image](https://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image) and contains additional utilities that I found useful when dealing with NIFTIs in MATLAB. 

Utilities in this package allow for data processing to occur WRT storage orientation while also taking data scaling into account, saving NIFTIs after they have been modified/processed in the same orientation, getting the volume in "voxel RAS" orientation which is useful for plotting results without resampling or reslicing the data, and more...

There's more info and a tutorial [here](http://justinblaber.org/nifti-files-in-matlab/) for working with NIFTI files in MATLAB with this library.

# Installation instructions:
```
git clone https://github.com/justinblaber/nifti_utils.git
```
Then, in MATLAB:
```
addpath('nifti_utils');
```
You can try out some of the utilties like so:
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
The viewer should look like:
<p align="center">
  <img width="558" height="481"  src="https://i.imgur.com/qyLYnPl.png">
</p>
