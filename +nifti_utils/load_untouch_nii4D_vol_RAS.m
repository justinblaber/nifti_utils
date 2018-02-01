function vol_RAS = load_untouch_nii4D_vol_RAS(nii_path,type)
    % Does load_untouch_nii4D_vol + converts to "voxel RAS orientation"

    if exist('type','var')
        vol = nifti_utils.load_untouch_nii4D_vol(nii_path,type);
    else
        vol = nifti_utils.load_untouch_nii4D_vol(nii_path);
    end

    vol_RAS = nifti_utils.vol_apply_xform(vol,nifti_utils.get_voxel_RAS_xform(nii_path));  
end