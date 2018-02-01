function voxel_coords = get_voxel_coords(nii_path)
    % Returns coordinates of voxels in continuous RAS (mm). Same as
    % XYZ output in [~,XYZ] = spm_read_vols(V). Outputs are returned as a
    % 3xn row vector format.

    % First, get xform_RAS
    xform_RAS = nifti_utils.get_RAS_xform(nii_path);

    % Get voxel coordinates; note that these will use zero based
    % indexing.
    nii_hdr = load_untouch_header_only(nii_path);  
    [I,J,K] = ndgrid(0:nii_hdr.dime.dim(2)-1, ...
                     0:nii_hdr.dime.dim(3)-1, ...
                     0:nii_hdr.dime.dim(4)-1);

    % Get real coordinates of voxels
    voxel_coords = xform_RAS * [I(:)';J(:)';K(:)';ones(size(I(:)'))];            
end