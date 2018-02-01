function vol_RAS = load_untouch_nii4D_vol_scaled_RAS(nii_path,type)
    % Does load_untouch_nii4D_vol_scaled + converts to "voxel RAS
    % orientation"

    vol = nifti_utils.load_untouch_nii4D_vol_scaled(nii_path,type);

    vol_RAS = nifti_utils.vol_apply_xform(vol,nifti_utils.get_voxel_RAS_xform(nii_path));  
end