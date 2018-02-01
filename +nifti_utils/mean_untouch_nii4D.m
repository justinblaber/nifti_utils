function mean_untouch_nii4D(nii_in_path,nii_out_path)
    % Calculates mean. Note this stores in whatever format the input image
    % is in, so decimals might get cast to integers.

    % Load
    nii = load_untouch_nii(nii_in_path);
    nii.img = nifti_utils.load_untouch_nii4D_vol(nii_in_path,'double'); % Does not need to be scaled for mean

    % Get mean
    nii.img = nanmean(nii.img,4);

    % Volume is 3D now
    nii.hdr.dime.dim(1) = 3;
    nii.hdr.dime.dim(5) = 1; 
    nii.hdr.dime.dim(6) = 1;    
    nii.hdr.dime.glmax = round(max(nii.img(:)));   
    nii.hdr.dime.glmin = round(min(nii.img(:)));     

    % Save
    save_untouch_nii(nii,nii_out_path);       
end