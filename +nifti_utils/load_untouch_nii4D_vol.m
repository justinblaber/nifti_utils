function vol = load_untouch_nii4D_vol(nii_path,type)
    % Returns 4D volume which is FSL compatible, in that if the 4D info is
    % stored in the 5th dimension, it gets permuted to the 4th. "type" is 
    % optional, and if provided, .img will get converted to this type. 
    % "type" is typically 'logical', 'double', etc... 

    nii_hdr = load_untouch_header_only(nii_path);   
    vol = nifti_utils.load_untouch_nii_vol(nii_path);  
    if nii_hdr.dime.dim(1) == 5 && nii_hdr.dime.dim(5) == 1 && nii_hdr.dime.dim(6) ~= 1
        % 4th dimensional info stored in 5th dimension - permute it
        vol = permute(vol,[1 2 3 5 4]);
    end

    if exist('type','var')
        type_fun = str2func(type);            
        vol = type_fun(vol);
    end
end