function idx_untouch_nii4D(nii_in_path,idxs,nii_out_path)
    % Loads nifti, applies idxs to 4th dimension, and then saves. Uses 
    % FSL convention in that 4th dimension is used for diffusion weighting.

    nii = load_untouch_nii(nii_in_path);
    nii.img = nifti_utils.load_untouch_nii4D_vol(nii_in_path);
    nii.img = nii.img(:,:,:,idxs);
    if size(nii.img,4) == 1
        nii.hdr.dime.dim(1) = 3;
    else
        nii.hdr.dime.dim(1) = 4;           % fsl convention
    end
    nii.hdr.dime.dim(5) = size(nii.img,4); % fsl convention
    nii.hdr.dime.dim(6) = 1;               % fsl convention
    nii.hdr.dime.glmax = max(nii.img(:));
    nii.hdr.dime.glmin = min(nii.img(:));
    save_untouch_nii(nii,nii_out_path);
end

