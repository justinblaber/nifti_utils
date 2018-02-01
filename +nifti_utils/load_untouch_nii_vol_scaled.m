function vol = load_untouch_nii_vol_scaled(nii_path,type)
    % Loads .img untouched, then scales with scl_slope and scl_inter. Use 
    % this if the actual intensity matters. "type" is mandatory since image
    % intensity is scaled.

    type_fun = str2func(type);                   

    nii_hdr = load_untouch_header_only(nii_path);           
    vol = nifti_utils.load_untouch_nii_vol(nii_path,type);  

    if nii_hdr.dime.scl_slope ~= 0
        vol = type_fun(vol .* type_fun(nii_hdr.dime.scl_slope) + type_fun(nii_hdr.dime.scl_inter));   
    end
end