function xform_RAS_voxel = get_voxel_RAS_xform(nii_path)
    % Gets the 3x3 transformation used to convert voxel coordinates into 
    % "voxel RAS orientation". I used a similar method that xform_nii() 
    % uses, except the tolerance is set to "1" by default here and I take 
    % the voxel scaling into account. No translational component is 
    % provided because this is basically used for plotting results without
    % resampling.
    nii_hdr = load_untouch_header_only(nii_path);   

    % First, get xform_RAS
    xform_RAS = nifti_utils.get_RAS_xform(nii_path);

    % First, remove the scaling component. 
    xform_scale = diag([nii_hdr.dime.pixdim(2:4) 1]);            
    xform_RAS_voxel = vertcat(xform_RAS,[0 0 0 1]) * xform_scale^-1;

    % Then, clear everything below the 3rd largest absolute value 
    % in the non-translational component of the transformation. 
    xform_RAS_voxel = xform_RAS_voxel(1:3,1:3);
    [~,idx_sort] = sort(abs(xform_RAS_voxel(:)));
    xform_RAS_voxel(idx_sort(1:end-3)) = 0;
    xform_RAS_voxel = sign(xform_RAS_voxel);            
    if det(xform_RAS_voxel) == 0
        % TODO: maybe a different method can prevent this?
        error('RAS voxel orientation matrix is singular.');
    end
end